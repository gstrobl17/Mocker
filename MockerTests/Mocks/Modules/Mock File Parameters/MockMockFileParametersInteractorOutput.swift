//swiftlint:disable identifier_name
//
//  MockMockFileParametersInteractorOutput.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit
import SwiftSyntax
import XcodeEditor

class MockMockFileParametersInteractorOutput: MockFileParametersInteractorOutputProtocol {

    struct Method: OptionSet, Sendable {
        let rawValue: Int
        static let setParametersPrefixIncludeHeaderStripTrailingProtocolIncludeTestableImportTrackPropertyActivityPublicCalled = Method(rawValue: 1)
        static let setNameNameCalled = Method(rawValue: 2)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
        let rawValue: Int
        static let prefix = MethodParameter(rawValue: 1 << 0)
        static let includeHeader = MethodParameter(rawValue: 1 << 1)
        static let stripTrailingProtocol = MethodParameter(rawValue: 1 << 2)
        static let includeTestableImport = MethodParameter(rawValue: 1 << 4)
        static let trackPropertyActivity = MethodParameter(rawValue: 1 << 5)
        static let `public` = MethodParameter(rawValue: 1 << 6)
        static let name = MethodParameter(rawValue: 1 << 7)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var prefix: String?
    private(set) var includeHeader: Bool?
    private(set) var stripTrailingProtocol: Bool?
    private(set) var includeTestableImport: Bool?
    private(set) var trackPropertyActivity: Bool?
    private(set) var `public`: Bool?
    private(set) var name: String?

    func reset() {
        calledMethods = []
        assignedParameters = []
        prefix = nil
        includeHeader = nil
        stripTrailingProtocol = nil
        includeTestableImport = nil
        trackPropertyActivity = nil
        `public` = nil
        name = nil
    }

    //swiftlint:disable:next function_parameter_count
    func setParameters(prefix: String,
                       includeHeader: Bool,
                       stripTrailingProtocol: Bool,
                       includeTestableImport: Bool,
                       trackPropertyActivity: Bool,
                       public: Bool) {
        calledMethods.insert(.setParametersPrefixIncludeHeaderStripTrailingProtocolIncludeTestableImportTrackPropertyActivityPublicCalled)
        self.prefix = prefix
        assignedParameters.insert(.prefix)
        self.includeHeader = includeHeader
        assignedParameters.insert(.includeHeader)
        self.stripTrailingProtocol = stripTrailingProtocol
        assignedParameters.insert(.stripTrailingProtocol)
        self.includeTestableImport = includeTestableImport
        assignedParameters.insert(.includeTestableImport)
        self.trackPropertyActivity = trackPropertyActivity
        assignedParameters.insert(.trackPropertyActivity)
        self.public = `public`
        assignedParameters.insert(.public)
    }

    func setName(_ name: String) {
        calledMethods.insert(.setNameNameCalled)
        self.name = name
        assignedParameters.insert(.name)
    }

}

extension MockMockFileParametersInteractorOutput.Method: CustomStringConvertible {
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

        if self.contains(.setParametersPrefixIncludeHeaderStripTrailingProtocolIncludeTestableImportTrackPropertyActivityPublicCalled) {
            handleFirst()
            value += ".setParametersPrefixIncludeHeaderStripTrailingProtocolIncludeTestableImportTrackPropertyActivityPublicCalled"
        }
        if self.contains(.setNameNameCalled) {
            handleFirst()
            value += ".setNameNameCalled"
        }

        value += "]"
        return value
    }
}

extension MockMockFileParametersInteractorOutput.MethodParameter: CustomStringConvertible {
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

        if self.contains(.prefix) {
            handleFirst()
            value += ".prefix"
        }
        if self.contains(.includeHeader) {
            handleFirst()
            value += ".includeHeader"
        }
        if self.contains(.stripTrailingProtocol) {
            handleFirst()
            value += ".stripTrailingProtocol"
        }
        if self.contains(.includeTestableImport) {
            handleFirst()
            value += ".includeTestableImport"
        }
        if self.contains(.trackPropertyActivity) {
            handleFirst()
            value += ".trackPropertyActivity"
        }
        if self.contains(.public) {
            handleFirst()
            value += ".public"
        }
        if self.contains(.name) {
            handleFirst()
            value += ".name"
        }

        value += "]"
        return value
    }
}

extension MockMockFileParametersInteractorOutput: CustomReflectable {
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

//swiftlint:enable identifier_name
