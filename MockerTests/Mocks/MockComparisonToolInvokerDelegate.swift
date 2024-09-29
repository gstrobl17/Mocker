//
//  MockComparisonToolInvokerDelegate.swift
//  Mocker
//
//  Created by Greg Strobl on 9/29/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import Foundation

class MockComparisonToolInvokerDelegate: ComparisonToolInvokerDelegate {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet, Sendable {
        let rawValue: UInt
        static let invokerInvokerToolFoundCalled = Method(rawValue: 1 << 0)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
        let rawValue: UInt
        static let invoker = MethodParameter(rawValue: 1 << 0)
        static let toolFound = MethodParameter(rawValue: 1 << 1)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var invoker: (any ComparisonToolInvoking)?
    private(set) var toolFound: Bool?

    func reset() {
        calledMethods = []
        assignedParameters = []
        invoker = nil
        toolFound = nil
    }

    // MARK: - Methods for Protocol Conformance

    func invoker(_ invoker: any ComparisonToolInvoking, toolFound: Bool) {
        calledMethods.insert(.invokerInvokerToolFoundCalled)
        self.invoker = invoker
        assignedParameters.insert(.invoker)
        self.toolFound = toolFound
        assignedParameters.insert(.toolFound)
    }

}

extension MockComparisonToolInvokerDelegate.Method: CustomStringConvertible {
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

        if self.contains(.invokerInvokerToolFoundCalled) {
            handleFirst()
            value += ".invokerInvokerToolFoundCalled"
        }

        value += "]"
        return value
    }
}

extension MockComparisonToolInvokerDelegate.MethodParameter: CustomStringConvertible {
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

        if self.contains(.invoker) {
            handleFirst()
            value += ".invoker"
        }
        if self.contains(.toolFound) {
            handleFirst()
            value += ".toolFound"
        }

        value += "]"
        return value
    }
}

extension MockComparisonToolInvokerDelegate: CustomReflectable {
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
