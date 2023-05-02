//
//  MockFileSynthesisInteractorInput.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit
import XcodeEditor

class MockFileSynthesisInteractorInput: FileSynthesisInteractorInputProtocol {

    var presenter: FileSynthesisInteractorOutputProtocol?
    var group: XCGroup?

    struct Method: OptionSet {
        let rawValue: Int
        static let generateMockFileCalled = Method(rawValue: 1)
        static let addNewFileToProjectChangedNewValueCalled = Method(rawValue: 2)
        static let viewHasLoadedCalled = Method(rawValue: 4)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let newValue = MethodParameter(rawValue: 1)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var newValue: Bool?

    func reset() {
        calledMethods = []
        assignedParameters = []
        newValue = nil
    }

    func generateMockFile() {
        calledMethods.insert(.generateMockFileCalled)
    }

    func addNewFileToProjectChanged(_ newValue: Bool) {
        calledMethods.insert(.addNewFileToProjectChangedNewValueCalled)
        self.newValue = newValue
        assignedParameters.insert(.newValue)
    }

    func viewHasLoaded() {
        calledMethods.insert(.viewHasLoadedCalled)
    }

}

extension MockFileSynthesisInteractorInput.Method: CustomStringConvertible {
    var description: String {
        var value = "["
        var first = true
        func handleFirst() {
            if first {
                first = false
            } else {
                value += ", "
            }
        }

        if self.contains(.generateMockFileCalled) {
            handleFirst()
            value += ".generateMockFileCalled"
        }
        if self.contains(.addNewFileToProjectChangedNewValueCalled) {
            handleFirst()
            value += ".addNewFileToProjectChangedNewValueCalled"
        }
        if self.contains(.viewHasLoadedCalled) {
            handleFirst()
            value += ".viewHasLoadedCalled"
        }

        value += "]"
        return value
    }
}

extension MockFileSynthesisInteractorInput.MethodParameter: CustomStringConvertible {
    var description: String {
        var value = "["
        var first = true
        func handleFirst() {
            if first {
                first = false
            } else {
                value += ", "
            }
        }

        if self.contains(.newValue) {
            handleFirst()
            value += ".newValue"
        }

        value += "]"
        return value
    }
}
