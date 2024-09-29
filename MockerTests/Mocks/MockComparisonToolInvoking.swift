//
//  MockComparisonToolInvoking.swift
//  Mocker
//
//  Created by Greg Strobl on 9/29/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import Foundation

class MockComparisonToolInvoking: ComparisonToolInvoking {

    // MARK: - Variables for Protocol Conformance

    var delegate: (any ComparisonToolInvokerDelegate)?

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet, Sendable {
        let rawValue: UInt
        static let lookForComparisonToolCalled = Method(rawValue: 1 << 0)
        static let openComparisonToolForUrl1AndUrl2Called = Method(rawValue: 1 << 1)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
        let rawValue: UInt
        static let url1 = MethodParameter(rawValue: 1 << 0)
        static let url2 = MethodParameter(rawValue: 1 << 1)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var url1: URL?
    private(set) var url2: URL?

    // MARK: - Variables to Use as Method Return Values

    var openComparisonToolForUrl1AndUrl2ReturnValue: (terminationStatus: Int32, output: String) = (0, "")

    func reset() {
        calledMethods = []
        assignedParameters = []
        url1 = nil
        url2 = nil
    }

    // MARK: - Methods for Protocol Conformance

    func lookForComparisonTool() {
        calledMethods.insert(.lookForComparisonToolCalled)
    }

    func openComparisonTool(for url1: URL, and url2: URL) -> (terminationStatus: Int32, output: String) {
        calledMethods.insert(.openComparisonToolForUrl1AndUrl2Called)
        self.url1 = url1
        assignedParameters.insert(.url1)
        self.url2 = url2
        assignedParameters.insert(.url2)
        return openComparisonToolForUrl1AndUrl2ReturnValue
    }

}

extension MockComparisonToolInvoking.Method: CustomStringConvertible {
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

        if self.contains(.lookForComparisonToolCalled) {
            handleFirst()
            value += ".lookForComparisonToolCalled"
        }
        if self.contains(.openComparisonToolForUrl1AndUrl2Called) {
            handleFirst()
            value += ".openComparisonToolForUrl1AndUrl2Called"
        }

        value += "]"
        return value
    }
}

extension MockComparisonToolInvoking.MethodParameter: CustomStringConvertible {
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

        if self.contains(.url1) {
            handleFirst()
            value += ".url1"
        }
        if self.contains(.url2) {
            handleFirst()
            value += ".url2"
        }

        value += "]"
        return value
    }
}

extension MockComparisonToolInvoking: CustomReflectable {
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
