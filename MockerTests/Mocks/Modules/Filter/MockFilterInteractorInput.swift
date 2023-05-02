//
//  MockFilterInteractorInput.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit

class MockFilterInteractorInput: FilterInteractorInputProtocol {

    var presenter: FilterInteractorOutputProtocol?

    struct Method: OptionSet {
        let rawValue: Int
        static let viewHasLoadedCalled = Method(rawValue: 1)
        static let filterValueChangedToValueCalled = Method(rawValue: 2)
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

    func viewHasLoaded() {
        calledMethods.insert(.viewHasLoadedCalled)
    }

    func filterValueChanged(to value: String) {
        calledMethods.insert(.filterValueChangedToValueCalled)
        self.value = value
        assignedParameters.insert(.value)
    }

}

extension MockFilterInteractorInput.Method: CustomStringConvertible {
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

        if self.contains(.viewHasLoadedCalled) {
            handleFirst()
            value += ".viewHasLoadedCalled"
        }
        if self.contains(.filterValueChangedToValueCalled) {
            handleFirst()
            value += ".filterValueChangedToValueCalled"
        }

        value += "]"
        return value
    }
}

extension MockFilterInteractorInput.MethodParameter: CustomStringConvertible {
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
