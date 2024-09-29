//
//  MockTemporaryFileHandling.swift
//  Mocker
//
//  Created by Greg Strobl on 9/29/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import Foundation

class MockTemporaryFileHandling: TemporaryFileHandling {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet, Sendable {
        let rawValue: UInt
        static let saveToTemporaryFileStringCalled = Method(rawValue: 1 << 0)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
        let rawValue: UInt
        static let string = MethodParameter(rawValue: 1 << 0)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var string: String?

    // MARK: - Variables to Use as Method Return Values

    var saveToTemporaryFileStringReturnValue: URL = URL(fileURLWithPath: "temporaryFile")

    var errorToThrow: (any Error)!
    var saveToTemporaryFileStringShouldThrowError = false

    func reset() {
        calledMethods = []
        assignedParameters = []
        string = nil
    }

    // MARK: - Methods for Protocol Conformance

    func saveToTemporaryFile(_ string: String) throws -> URL {
        calledMethods.insert(.saveToTemporaryFileStringCalled)
        self.string = string
        assignedParameters.insert(.string)
        if saveToTemporaryFileStringShouldThrowError && errorToThrow != nil {
            throw errorToThrow
        }
        return saveToTemporaryFileStringReturnValue
    }

}

extension MockTemporaryFileHandling.Method: CustomStringConvertible {
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

        if self.contains(.saveToTemporaryFileStringCalled) {
            handleFirst()
            value += ".saveToTemporaryFileStringCalled"
        }

        value += "]"
        return value
    }
}

extension MockTemporaryFileHandling.MethodParameter: CustomStringConvertible {
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

        if self.contains(.string) {
            handleFirst()
            value += ".string"
        }

        value += "]"
        return value
    }
}

extension MockTemporaryFileHandling: CustomReflectable {
    var customMirror: Mirror {
        Mirror(self,
               children: [
                "calledMethods": calledMethods,
                "assignedParameters": assignedParameters,
               ],
               displayStyle: .none
        )
    }
}
