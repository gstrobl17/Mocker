//
//  MockRecentDocumentManaging.swift
//  MockerTests
//
//  Created by Greg Strobl on 2/3/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import Foundation

class MockRecentDocumentManaging: RecentDocumentManaging {

    // MARK: - Variables for Properties Used for Protocol Conformance
    // Use these properties to get/set/initialize the properties without registering a method call

    var _recents: [URL] = []

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: UInt
        static let recentsGetterCalled = Method(rawValue: 1 << 0)
        static let addUrlCalled = Method(rawValue: 1 << 1)
        static let removeUrlCalled = Method(rawValue: 1 << 2)
        static let clearCalled = Method(rawValue: 1 << 3)
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

    // MARK: - Properties for Protocol Conformance

    var recents: [URL] {
        calledMethods.insert(.recentsGetterCalled)
        return _recents
    }

    // MARK: - Methods for Protocol Conformance

    func add(_ url: URL) {
        calledMethods.insert(.addUrlCalled)
        self.url = url
        assignedParameters.insert(.url)
    }

    func remove(_ url: URL) {
        calledMethods.insert(.removeUrlCalled)
        self.url = url
        assignedParameters.insert(.url)
    }

    func clear() {
        calledMethods.insert(.clearCalled)
    }

}

extension MockRecentDocumentManaging.Method: CustomStringConvertible {
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

        if self.contains(.recentsGetterCalled) {
            handleFirst()
            value += ".recentsGetterCalled"
        }
        if self.contains(.addUrlCalled) {
            handleFirst()
            value += ".addUrlCalled"
        }
        if self.contains(.removeUrlCalled) {
            handleFirst()
            value += ".removeUrlCalled"
        }
        if self.contains(.clearCalled) {
            handleFirst()
            value += ".clearCalled"
        }

        value += "]"
        return value
    }
}

extension MockRecentDocumentManaging.MethodParameter: CustomStringConvertible {
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

extension MockRecentDocumentManaging: CustomReflectable {
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
