//
//  MockSourceFileDataSource.swift
//  Mocker
//
// Created by Greg Strobl on 5/13/24.
// Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import Foundation

class MockSourceFileDataSource: SourceFileDataSource {

    // MARK: - Variables for Properties Used for Protocol Conformance
    // Use these properties to get/set/initialize the properties without registering a method call

    var _projectName: String?
    var _projectDirectoryURL: URL?
    var _organizationName: String?
    var _targets: [String] = []

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: UInt
        static let projectNameGetterCalled = Method(rawValue: 1 << 0)
        static let projectDirectoryURLGetterCalled = Method(rawValue: 1 << 1)
        static let organizationNameGetterCalled = Method(rawValue: 1 << 2)
        static let targetsGetterCalled = Method(rawValue: 1 << 3)
        static let traverseFilteredByFilterMonitoredByCalled = Method(rawValue: 1 << 4)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: UInt
        static let filter = MethodParameter(rawValue: 1 << 0)
        static let monitoredBy = MethodParameter(rawValue: 1 << 1)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var filter: String?
    private(set) var monitoredBy: (any CancelMonitoring)?

    // MARK: - Variables to Use as Method Return Values

    var traverseFilteredByFilterMonitoredByReturnValue: ProjectTraversalResult!
    var filePathReturnValue: String!

    func reset() {
        calledMethods = []
        assignedParameters = []
        filter = nil
        monitoredBy = nil
    }

    // MARK: - Properties for Protocol Conformance

    var projectName: String? {
        calledMethods.insert(.projectNameGetterCalled)
        return _projectName
    }

    var projectDirectoryURL: URL? {
        calledMethods.insert(.projectDirectoryURLGetterCalled)
        return _projectDirectoryURL
    }

    var organizationName: String? {
        calledMethods.insert(.organizationNameGetterCalled)
        return _organizationName
    }

    var targets: [String] {
        calledMethods.insert(.targetsGetterCalled)
        return _targets
    }

    // MARK: - Methods for Protocol Conformance

    func traverse(filteredBy filter: String, monitoredBy: any CancelMonitoring) -> ProjectTraversalResult {
        calledMethods.insert(.traverseFilteredByFilterMonitoredByCalled)
        self.filter = filter
        assignedParameters.insert(.filter)
        self.monitoredBy = monitoredBy
        assignedParameters.insert(.monitoredBy)
        return traverseFilteredByFilterMonitoredByReturnValue
    }

}

extension MockSourceFileDataSource.Method: CustomStringConvertible {
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

        if self.contains(.projectNameGetterCalled) {
            handleFirst()
            value += ".projectNameGetterCalled"
        }
        if self.contains(.projectDirectoryURLGetterCalled) {
            handleFirst()
            value += ".projectDirectoryURLGetterCalled"
        }
        if self.contains(.organizationNameGetterCalled) {
            handleFirst()
            value += ".organizationNameGetterCalled"
        }
        if self.contains(.targetsGetterCalled) {
            handleFirst()
            value += ".targetsGetterCalled"
        }
        if self.contains(.traverseFilteredByFilterMonitoredByCalled) {
            handleFirst()
            value += ".traverseFilteredByFilterMonitoredByCalled"
        }

        value += "]"
        return value
    }
}

extension MockSourceFileDataSource.MethodParameter: CustomStringConvertible {
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

        if self.contains(.filter) {
            handleFirst()
            value += ".filter"
        }
        if self.contains(.monitoredBy) {
            handleFirst()
            value += ".monitoredBy"
        }

        value += "]"
        return value
    }
}

extension MockSourceFileDataSource: CustomReflectable {
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
