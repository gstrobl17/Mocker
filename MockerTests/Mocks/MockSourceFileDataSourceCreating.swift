//
//  MockSourceFileDataSourceCreating.swift
//  Mocker
//
// Created by Greg Strobl on 5/13/24.
// Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import Foundation

class MockSourceFileDataSourceCreating: SourceFileDataSourceCreating {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: UInt
        static let createDataSourceForFileURLCalled = Method(rawValue: 1 << 0)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: UInt
        static let fileURL = MethodParameter(rawValue: 1 << 0)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var fileURL: URL?

    // MARK: - Variables to Use as Method Return Values

    var createDataSourceForFileURLReturnValue: SourceFileDataSource? = MockSourceFileDataSource()

    func reset() {
        calledMethods = []
        assignedParameters = []
        fileURL = nil
    }

    // MARK: - Methods for Protocol Conformance

    func createDataSource(for fileURL: URL) -> SourceFileDataSource? {
        calledMethods.insert(.createDataSourceForFileURLCalled)
        self.fileURL = fileURL
        assignedParameters.insert(.fileURL)
        return createDataSourceForFileURLReturnValue
    }

}

extension MockSourceFileDataSourceCreating.Method: CustomStringConvertible {
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

        if self.contains(.createDataSourceForFileURLCalled) {
            handleFirst()
            value += ".createDataSourceForFileURLCalled"
        }

        value += "]"
        return value
    }
}

extension MockSourceFileDataSourceCreating.MethodParameter: CustomStringConvertible {
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

        if self.contains(.fileURL) {
            handleFirst()
            value += ".fileURL"
        }

        value += "]"
        return value
    }
}

extension MockSourceFileDataSourceCreating: CustomReflectable {
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
