//
//  MockFilterView.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit

@MainActor
class MockFilterView: NSViewController, FilterViewProtocol {

    var presenter: (any FilterPresenterProtocol)?

    struct Method: OptionSet, Sendable {
        let rawValue: Int
        static let setValueValueCalled = Method(rawValue: 1)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
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

extension MockFilterView.Method: CustomStringConvertible {
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

extension MockFilterView.MethodParameter: CustomStringConvertible {
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

extension MockFilterView: CustomReflectable {
    var customMirror: Mirror {
        Mirror(self,
               children: [
                "calledMethods": calledMethods,
                "assignedParameters": assignedParameters
               ],
               displayStyle: .none
        )
    }
}
