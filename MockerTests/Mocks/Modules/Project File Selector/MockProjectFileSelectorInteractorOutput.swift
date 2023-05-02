//
//  MockProjectFileSelectorInteractorOutput.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit

class MockProjectFileSelectorInteractorOutput: ProjectFileSelectorInteractorOutputProtocol {

    struct Method: OptionSet {
        let rawValue: Int
        static let showSelectedFileUrlCalled = Method(rawValue: 1)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let url = MethodParameter(rawValue: 1)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var url: URL?

    func reset() {
        calledMethods = []
        assignedParameters = []
        url = nil
    }

    func showSelectedFile(_ url: URL) {
        calledMethods.insert(.showSelectedFileUrlCalled)
        self.url = url
        assignedParameters.insert(.url)
    }

}

extension MockProjectFileSelectorInteractorOutput.Method: CustomStringConvertible {
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

        if self.contains(.showSelectedFileUrlCalled) {
            handleFirst()
            value += ".showSelectedFileUrlCalled"
        }

        value += "]"
        return value
    }
}

extension MockProjectFileSelectorInteractorOutput.MethodParameter: CustomStringConvertible {
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

        if self.contains(.url) {
            handleFirst()
            value += ".url"
        }

        value += "]"
        return value
    }
}
