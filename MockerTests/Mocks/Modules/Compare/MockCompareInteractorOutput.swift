//
//  MockCompareInteractorOutput.swift
//  Mocker
//
//  Created by Greg Strobl on 9/28/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import AppKit

@MainActor
class MockCompareInteractorOutput: CompareInteractorOutputProtocol {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet, Sendable {
        let rawValue: UInt
        static let showButtonFlagCalled = Method(rawValue: 1 << 0)
        static let reportErrorConditionWithMessageTextAndInformativeTextCalled = Method(rawValue: 1 << 1)
        static let mockCodeForCompareCalled = Method(rawValue: 1 << 2)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
        let rawValue: UInt
        static let flag = MethodParameter(rawValue: 1 << 0)
        static let messageText = MethodParameter(rawValue: 1 << 1)
        static let informativeText = MethodParameter(rawValue: 1 << 2)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var flag: Bool?
    private(set) var messageText: String?
    private(set) var informativeText: String?

    // MARK: - Variables to Use as Method Return Values

    var mockCodeForCompareReturnValue: String = ""

    func reset() {
        calledMethods = []
        assignedParameters = []
        flag = nil
        messageText = nil
        informativeText = nil
    }

    // MARK: - Methods for Protocol Conformance

    func showButton(_ flag: Bool) {
        calledMethods.insert(.showButtonFlagCalled)
        self.flag = flag
        assignedParameters.insert(.flag)
    }

    func reportErrorCondition(with messageText: String, and informativeText: String) {
        calledMethods.insert(.reportErrorConditionWithMessageTextAndInformativeTextCalled)
        self.messageText = messageText
        assignedParameters.insert(.messageText)
        self.informativeText = informativeText
        assignedParameters.insert(.informativeText)
    }

    func mockCodeForCompare() -> String {
        calledMethods.insert(.mockCodeForCompareCalled)
        return mockCodeForCompareReturnValue
    }

}

extension MockCompareInteractorOutput.Method: CustomStringConvertible {
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

        if self.contains(.showButtonFlagCalled) {
            handleFirst()
            value += ".showButtonFlagCalled"
        }
        if self.contains(.reportErrorConditionWithMessageTextAndInformativeTextCalled) {
            handleFirst()
            value += ".reportErrorConditionWithMessageTextAndInformativeTextCalled"
        }
        if self.contains(.mockCodeForCompareCalled) {
            handleFirst()
            value += ".mockCodeForCompareCalled"
        }

        value += "]"
        return value
    }
}

extension MockCompareInteractorOutput.MethodParameter: CustomStringConvertible {
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

        if self.contains(.flag) {
            handleFirst()
            value += ".flag"
        }
        if self.contains(.messageText) {
            handleFirst()
            value += ".messageText"
        }
        if self.contains(.informativeText) {
            handleFirst()
            value += ".informativeText"
        }

        value += "]"
        return value
    }
}

extension MockCompareInteractorOutput: @preconcurrency CustomReflectable {
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
