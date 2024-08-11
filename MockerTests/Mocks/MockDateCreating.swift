//
//  MockDateCreating.swift
//  MockerTests
//
//  Created by Greg Strobl on 1/24/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import Foundation

class MockDateCreating: DateCreating {

    // MARK: - Variables for Properties Used for Protocol Conformance
    // Use these properties to get/set/initialize the properties without registering a method call

    var _now: Date = Date.distantPast

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet, Sendable {
        let rawValue: UInt
        static let nowGetterCalled = Method(rawValue: 1 << 0)
        static let dateTimeIntervalSinceNowCalled = Method(rawValue: 1 << 1)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
        let rawValue: UInt
        static let timeIntervalSinceNow = MethodParameter(rawValue: 1 << 0)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var timeIntervalSinceNow: TimeInterval?

    // MARK: - Variables to Use as Method Return Values

    var dateTimeIntervalSinceNowReturnValue: Date = Date.distantPast

    func reset() {
        calledMethods = []
        assignedParameters = []
        timeIntervalSinceNow = nil
    }

    // MARK: - Properties for Protocol Conformance

    var now: Date {
        calledMethods.insert(.nowGetterCalled)
        return _now
    }

    // MARK: - Methods for Protocol Conformance

    func date(timeIntervalSinceNow: TimeInterval) -> Date {
        calledMethods.insert(.dateTimeIntervalSinceNowCalled)
        self.timeIntervalSinceNow = timeIntervalSinceNow
        assignedParameters.insert(.timeIntervalSinceNow)
        return dateTimeIntervalSinceNowReturnValue
    }

}

extension MockDateCreating.Method: CustomStringConvertible {
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

        if self.contains(.nowGetterCalled) {
            handleFirst()
            value += ".nowGetterCalled"
        }
        if self.contains(.dateTimeIntervalSinceNowCalled) {
            handleFirst()
            value += ".dateTimeIntervalSinceNowCalled"
        }

        value += "]"
        return value
    }
}

extension MockDateCreating.MethodParameter: CustomStringConvertible {
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

        if self.contains(.timeIntervalSinceNow) {
            handleFirst()
            value += ".timeIntervalSinceNow"
        }

        value += "]"
        return value
    }
}

extension MockDateCreating: CustomReflectable {
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
