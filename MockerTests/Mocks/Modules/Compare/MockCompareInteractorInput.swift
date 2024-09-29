//
//  MockCompareInteractorInput.swift
//  Mocker
//
//  Created by Greg Strobl on 9/28/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import AppKit

@MainActor
class MockCompareInteractorInput: CompareInteractorInputProtocol {

    // MARK: - Variables for Protocol Conformance

    var presenter: (any CompareInteractorOutputProtocol)?

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet, Sendable {
        let rawValue: UInt
        static let fileToCompareSelectedUrlCalled = Method(rawValue: 1 << 0)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
        let rawValue: UInt
        static let url = MethodParameter(rawValue: 1 << 0)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var url: URL?

    func reset() {
        calledMethods = []
        assignedParameters = []
        url = nil
    }

    // MARK: - Methods for Protocol Conformance

    func fileToCompareSelected(_ url: URL) {
        calledMethods.insert(.fileToCompareSelectedUrlCalled)
        self.url = url
        assignedParameters.insert(.url)
    }

}

extension MockCompareInteractorInput.Method: CustomStringConvertible {
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

        if self.contains(.fileToCompareSelectedUrlCalled) {
            handleFirst()
            value += ".fileToCompareSelectedUrlCalled"
        }

        value += "]"
        return value
    }
}

extension MockCompareInteractorInput.MethodParameter: CustomStringConvertible {
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

extension MockCompareInteractorInput: @preconcurrency CustomReflectable {
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
