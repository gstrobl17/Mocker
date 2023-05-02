//
//  MockFilterInteractorOutput.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit

class MockFilterInteractorOutput: FilterInteractorOutputProtocol {

    struct Method: OptionSet {
        let rawValue: Int
        static let setValueValueCalled = Method(rawValue: 1)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let value = MethodParameter(rawValue: 1)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var value: String?

    func reset() {
        calledMethods = []
        assignedParameters = []
        value = nil
    }

    func setValue(_ value: String) {
        calledMethods.insert(.setValueValueCalled)
        self.value = value
        assignedParameters.insert(.value)
    }

}

extension MockFilterInteractorOutput.Method: CustomStringConvertible {
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

        if self.contains(.setValueValueCalled) {
            handleFirst()
            value += ".setValueValueCalled"
        }

        value += "]"
        return value
    }
}

extension MockFilterInteractorOutput.MethodParameter: CustomStringConvertible {
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

        if self.contains(.value) {
            handleFirst()
            value += ".value"
        }

        value += "]"
        return value
    }
}
