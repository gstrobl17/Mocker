//
//  MockAsyncFilteringHandler.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import Foundation

class MockAsyncFilteringHandler: AsyncFilteringHandler {

    struct Method: OptionSet {
        let rawValue: Int
        static let performFilteringOnProjectWithFilterCompletionHandlerCalled = Method(rawValue: 1)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let project = MethodParameter(rawValue: 1)
        static let filter = MethodParameter(rawValue: 2)
        static let completionHandler = MethodParameter(rawValue: 4)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var project: Project?
    private(set) var filter: String?
    private(set) var completionHandler: ((ProjectTraversalResult) -> Void)?

    func reset() {
        calledMethods = []
        assignedParameters = []
        project = nil
        filter = nil
        completionHandler = nil
    }

    func performFiltering(on project: Project, with filter: String, completionHandler: @escaping (ProjectTraversalResult) -> Void) {
        calledMethods.insert(.performFilteringOnProjectWithFilterCompletionHandlerCalled)
        self.project = project
        assignedParameters.insert(.project)
        self.filter = filter
        assignedParameters.insert(.filter)
        self.completionHandler = completionHandler
        assignedParameters.insert(.completionHandler)
    }

}

extension MockAsyncFilteringHandler.Method: CustomStringConvertible {
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

        if self.contains(.performFilteringOnProjectWithFilterCompletionHandlerCalled) {
            handleFirst()
            value += ".performFilteringOnProjectWithFilterCompletionHandlerCalled"
        }

        value += "]"
        return value
    }
}

extension MockAsyncFilteringHandler.MethodParameter: CustomStringConvertible {
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

        if self.contains(.project) {
            handleFirst()
            value += ".project"
        }
        if self.contains(.filter) {
            handleFirst()
            value += ".filter"
        }
        if self.contains(.completionHandler) {
            handleFirst()
            value += ".completionHandler"
        }

        value += "]"
        return value
    }
}
