//
//  MockProject.swift
//  Mocker
//
// Created by Greg on 10/12/18.
//

@testable import Mocker
import Foundation
import XcodeEditor

class MockProject: Project {

    struct Method: OptionSet {
        let rawValue: Int
        static let targetsCalled = Method(rawValue: 1)
        static let objectsCalled = Method(rawValue: 2)
        static let traverseFilteredByFilterMonitoredByCalled = Method(rawValue: 4)
        static let fileWithKeyKeyCalled = Method(rawValue: 8)
        static let filePathCalled = Method(rawValue: 32)
        static let groupWithPathFromRootCalled = Method(rawValue: 64)
        static let targetWithNameNameCalled = Method(rawValue: 256)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let filter = MethodParameter(rawValue: 1)
        static let monitoredBy = MethodParameter(rawValue: 2)
        static let key = MethodParameter(rawValue: 4)
        static let name = MethodParameter(rawValue: 8)
        static let fromRoot = MethodParameter(rawValue: 16)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var filter: String?
    private(set) var monitoredBy: CancelMonitoring?
    private(set) var key: String?
    private(set) var name: String?
    private(set) var fromRoot: String?

    var targetsReturnValue: [XCTarget]!
    var objectsReturnValue: NSMutableDictionary!
    var traverseFilteredByFilterMonitoredByReturnValue: ProjectTraversalResult!
    var fileWithKeyKeyReturnValue: XCSourceFile!
    var fileWithNameNameReturnValue: XCSourceFile!
    var filePathReturnValue: String!
    var groupWithPathFromRootReturnValue: XCGroup!
    var targetWithNameNameReturnValue: XCTarget!

    func reset() {
        calledMethods = []
        assignedParameters = []
        filter = nil
        monitoredBy = nil
        key = nil
        name = nil
        fromRoot = nil
    }

    func targets() -> [XCTarget]! {
        calledMethods.insert(.targetsCalled)
        return targetsReturnValue
    }

    func objects() -> NSMutableDictionary! {
        calledMethods.insert(.objectsCalled)
        return objectsReturnValue
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

extension MockProject.Method: CustomStringConvertible {
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
        
        if self.contains(.targetsCalled) {
            handleFirst()
            value += ".targetsCalled"
        }
        if self.contains(.objectsCalled) {
            handleFirst()
            value += ".objectsCalled"
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

extension MockProject.MethodParameter: CustomStringConvertible {
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
        if self.contains(.name) {
            handleFirst()
            value += ".name"
        }
        if self.contains(.fromRoot) {
            handleFirst()
            value += ".fromRoot"
        }
        
        value += "]"
        return value
    }
}
