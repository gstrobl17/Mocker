//
//  MockAsyncFilteringHandler.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import Foundation

class MockAsyncFilteringHandler: AsyncFilteringHandler {

    struct Method: OptionSet, Sendable {
        let rawValue: Int
        static let performFilteringOnDataSourceWithFilterCompletionHandlerCalled = Method(rawValue: 1)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
        let rawValue: Int
        static let dataSource = MethodParameter(rawValue: 1)
        static let filter = MethodParameter(rawValue: 2)
        static let completionHandler = MethodParameter(rawValue: 4)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var dataSource: SourceFileDataSource?
    private(set) var filter: String?
    private(set) var completionHandler: ((ProjectTraversalResult) -> Void)?

    func reset() {
        calledMethods = []
        assignedParameters = []
        dataSource = nil
        filter = nil
        completionHandler = nil
    }

    func performFiltering(on dataSource: SourceFileDataSource, with filter: String, completionHandler: @escaping (ProjectTraversalResult) -> Void) {
        calledMethods.insert(.performFilteringOnDataSourceWithFilterCompletionHandlerCalled)
        self.dataSource = dataSource
        assignedParameters.insert(.dataSource)
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

        if self.contains(.performFilteringOnDataSourceWithFilterCompletionHandlerCalled) {
            handleFirst()
            value += ".performFilteringOnDataSourceWithFilterCompletionHandlerCalled"
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

        if self.contains(.dataSource) {
            handleFirst()
            value += ".dataSource"
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

extension MockAsyncFilteringHandler: CustomReflectable {
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
