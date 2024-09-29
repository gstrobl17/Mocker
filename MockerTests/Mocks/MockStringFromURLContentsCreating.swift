//
//  MockStringFromURLContentsCreating.swift
//  Mocker
//
//  Created by Greg Strobl on 9/29/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import Foundation

class MockStringFromURLContentsCreating: StringFromURLContentsCreating {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet, Sendable {
        let rawValue: UInt
        static let stringFromContentsOfUrlEncodingCalled = Method(rawValue: 1 << 0)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
        let rawValue: UInt
        static let url = MethodParameter(rawValue: 1 << 0)
        static let encoding = MethodParameter(rawValue: 1 << 1)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var url: URL?
    private(set) var encoding: String.Encoding?

    // MARK: - Variables to Use as Method Return Values

    var stringFromContentsOfUrlEncodingReturnValue: String = ""

    var errorToThrow: (any Error)!
    var stringFromContentsOfUrlEncodingShouldThrowError = false

    func reset() {
        calledMethods = []
        assignedParameters = []
        url = nil
        encoding = nil
    }

    // MARK: - Methods for Protocol Conformance

    func string(fromContentsOf url: URL, encoding: String.Encoding) throws -> String {
        calledMethods.insert(.stringFromContentsOfUrlEncodingCalled)
        self.url = url
        assignedParameters.insert(.url)
        self.encoding = encoding
        assignedParameters.insert(.encoding)
        if stringFromContentsOfUrlEncodingShouldThrowError && errorToThrow != nil {
            throw errorToThrow
        }
        return stringFromContentsOfUrlEncodingReturnValue
    }

}

extension MockStringFromURLContentsCreating.Method: CustomStringConvertible {
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

        if self.contains(.stringFromContentsOfUrlEncodingCalled) {
            handleFirst()
            value += ".stringFromContentsOfUrlEncodingCalled"
        }

        value += "]"
        return value
    }
}

extension MockStringFromURLContentsCreating.MethodParameter: CustomStringConvertible {
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
        if self.contains(.encoding) {
            handleFirst()
            value += ".encoding"
        }

        value += "]"
        return value
    }
}

extension MockStringFromURLContentsCreating: CustomReflectable {
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

