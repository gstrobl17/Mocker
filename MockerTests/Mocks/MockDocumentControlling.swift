//
//  MockDocumentControlling.swift
//  MockerTests
//
//  Created by Greg Strobl on 2/3/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import Foundation

class MockDocumentControlling: DocumentControlling {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: UInt
        static let noteNewRecentDocumentURLUrlCalled = Method(rawValue: 1 << 0)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
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

    func noteNewRecentDocumentURL(_ url: URL) {
        calledMethods.insert(.noteNewRecentDocumentURLUrlCalled)
        self.url = url
        assignedParameters.insert(.url)
    }

}

extension MockDocumentControlling.Method: CustomStringConvertible {
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

        if self.contains(.noteNewRecentDocumentURLUrlCalled) {
            handleFirst()
            value += ".noteNewRecentDocumentURLUrlCalled"
        }

        value += "]"
        return value
    }
}

extension MockDocumentControlling.MethodParameter: CustomStringConvertible {
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

extension MockDocumentControlling: CustomReflectable {
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
