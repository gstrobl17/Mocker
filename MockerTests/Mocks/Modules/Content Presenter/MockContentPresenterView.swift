//
//  MockContentPresenterView.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit

class MockContentPresenterView: NSViewController, ContentPresenterInterfaceProtocol {

    struct Method: OptionSet, Sendable {
        let rawValue: Int
        static let presentTextCalled = Method(rawValue: 1)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
        let rawValue: Int
        static let text = MethodParameter(rawValue: 1)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var text: String?

    func reset() {
        calledMethods = []
        assignedParameters = []
        text = nil
    }

    func present(text: String?) {
        calledMethods.insert(.presentTextCalled)
        self.text = text
        assignedParameters.insert(.text)
    }

}

extension MockContentPresenterView.Method: CustomStringConvertible {
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

        if self.contains(.presentTextCalled) {
            handleFirst()
            value += ".presentTextCalled"
        }

        value += "]"
        return value
    }
}

extension MockContentPresenterView.MethodParameter: CustomStringConvertible {
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

        if self.contains(.text) {
            handleFirst()
            value += ".text"
        }

        value += "]"
        return value
    }
}

extension MockContentPresenterView: CustomReflectable {
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
