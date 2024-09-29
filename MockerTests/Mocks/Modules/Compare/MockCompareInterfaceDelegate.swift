//
//  MockCompareInterfaceDelegate.swift
//  Mocker
//
//  Created by Greg Strobl on 9/28/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import AppKit

@MainActor
class MockCompareInterfaceDelegate: CompareInterfaceDelegate {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet, Sendable {
        let rawValue: UInt
        static let mockCodeForCompareViewCalled = Method(rawValue: 1 << 0)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
        let rawValue: UInt
        static let view = MethodParameter(rawValue: 1 << 0)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var view: (any NSViewController & CompareInterfaceProtocol)?

    // MARK: - Variables to Use as Method Return Values

    var mockCodeForCompareViewReturnValue: String = ""

    func reset() {
        calledMethods = []
        assignedParameters = []
        view = nil
    }

    // MARK: - Methods for Protocol Conformance

    func mockCodeForCompare(_ view: any NSViewController & CompareInterfaceProtocol) -> String {
        calledMethods.insert(.mockCodeForCompareViewCalled)
        self.view = view
        assignedParameters.insert(.view)
        return mockCodeForCompareViewReturnValue
    }

}

extension MockCompareInterfaceDelegate.Method: CustomStringConvertible {
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

        if self.contains(.mockCodeForCompareViewCalled) {
            handleFirst()
            value += ".mockCodeForCompareViewCalled"
        }

        value += "]"
        return value
    }
}

extension MockCompareInterfaceDelegate.MethodParameter: CustomStringConvertible {
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

        if self.contains(.view) {
            handleFirst()
            value += ".view"
        }

        value += "]"
        return value
    }
}

extension MockCompareInterfaceDelegate: @preconcurrency CustomReflectable {
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
