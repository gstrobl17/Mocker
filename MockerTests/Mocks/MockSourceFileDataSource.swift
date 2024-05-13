//
//  MockSourceFileDataSource.swift
//  Mocker
//
// Created by Greg Strobl on 5/13/24.
// Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import Foundation
import XcodeEditor  //TODO: remove import when abstraction completed

class MockSourceFileDataSource: SourceFileDataSource {

    // MARK: - Variables for Properties Used for Protocol Conformance
    // Use these properties to get/set/initialize the properties without registering a method call

    var _projectName: String?
    var _projectDirectoryURL: URL?
    var _organizationName: String?

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: UInt
        static let projectNameGetterCalled = Method(rawValue: 1 << 0)
        static let projectDirectoryURLGetterCalled = Method(rawValue: 1 << 1)
        static let organizationNameGetterCalled = Method(rawValue: 1 << 2)
        static let targetsCalled = Method(rawValue: 1 << 3)
        static let traverseFilteredByFilterMonitoredByCalled = Method(rawValue: 1 << 4)
        static let fileWithKeyKeyCalled = Method(rawValue: 1 << 5)
        static let filePathCalled = Method(rawValue: 1 << 6)
        static let groupWithPathFromRootCalled = Method(rawValue: 1 << 7)
        static let targetWithNameNameCalled = Method(rawValue: 1 << 8)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: UInt
        static let filter = MethodParameter(rawValue: 1 << 0)
        static let monitoredBy = MethodParameter(rawValue: 1 << 1)
        static let key = MethodParameter(rawValue: 1 << 2)
        static let fromRoot = MethodParameter(rawValue: 1 << 3)
        static let name = MethodParameter(rawValue: 1 << 4)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var filter: String?
    private(set) var monitoredBy: CancelMonitoring?
    private(set) var key: String?
    private(set) var fromRoot: String?
    private(set) var name: String?

    // MARK: - Variables to Use as Method Return Values

    var targetsReturnValue: [XCTarget]!
    var traverseFilteredByFilterMonitoredByReturnValue: ProjectTraversalResult!
    var fileWithKeyKeyReturnValue: XCSourceFile!
    var filePathReturnValue: String!
    var groupWithPathFromRootReturnValue: XCGroup!
    var targetWithNameNameReturnValue: XCTarget!

    func reset() {
        calledMethods = []
        assignedParameters = []
        filter = nil
        monitoredBy = nil
        key = nil
        fromRoot = nil
        name = nil
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

    // MARK: - Methods for Protocol Conformance

    func targets() -> [XCTarget]! {
        calledMethods.insert(.targetsCalled)
        return targetsReturnValue
    }

    func traverse(filteredBy filter: String, monitoredBy: CancelMonitoring) -> ProjectTraversalResult {
        calledMethods.insert(.traverseFilteredByFilterMonitoredByCalled)
        self.filter = filter
        assignedParameters.insert(.filter)
        self.monitoredBy = monitoredBy
        assignedParameters.insert(.monitoredBy)
        return traverseFilteredByFilterMonitoredByReturnValue
    }

    func file(withKey key: String!) -> XCSourceFile! {
        calledMethods.insert(.fileWithKeyKeyCalled)
        self.key = key
        assignedParameters.insert(.key)
        return fileWithKeyKeyReturnValue
    }

    func filePath() -> String! {
        calledMethods.insert(.filePathCalled)
        return filePathReturnValue
    }

    func groupWithPath(fromRoot: String!) -> XCGroup! {
        calledMethods.insert(.groupWithPathFromRootCalled)
        self.fromRoot = fromRoot
        assignedParameters.insert(.fromRoot)
        return groupWithPathFromRootReturnValue
    }

    func target(withName name: String!) -> XCTarget! {
        calledMethods.insert(.targetWithNameNameCalled)
        self.name = name
        assignedParameters.insert(.name)
        return targetWithNameNameReturnValue
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
        if self.contains(.targetsCalled) {
            handleFirst()
            value += ".targetsCalled"
        }
        if self.contains(.traverseFilteredByFilterMonitoredByCalled) {
            handleFirst()
            value += ".traverseFilteredByFilterMonitoredByCalled"
        }
        if self.contains(.fileWithKeyKeyCalled) {
            handleFirst()
            value += ".fileWithKeyKeyCalled"
        }
        if self.contains(.filePathCalled) {
            handleFirst()
            value += ".filePathCalled"
        }
        if self.contains(.groupWithPathFromRootCalled) {
            handleFirst()
            value += ".groupWithPathFromRootCalled"
        }
        if self.contains(.targetWithNameNameCalled) {
            handleFirst()
            value += ".targetWithNameNameCalled"
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
        if self.contains(.key) {
            handleFirst()
            value += ".key"
        }
        if self.contains(.fromRoot) {
            handleFirst()
            value += ".fromRoot"
        }
        if self.contains(.name) {
            handleFirst()
            value += ".name"
        }

        value += "]"
        return value
    }
}
