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

    struct Method: OptionSet {
        let rawValue: Int
        static let setParametersPrefixStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityCalled = Method(rawValue: 1)
        static let setNameNameCalled = Method(rawValue: 2)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let prefix = MethodParameter(rawValue: 1 << 0)
        static let stripTrailingProtocol = MethodParameter(rawValue: 1 << 1)
        static let swiftlintAware = MethodParameter(rawValue: 1 << 2)
        static let includeTestableImport = MethodParameter(rawValue: 1 << 3)
        static let trackPropertyActivity = MethodParameter(rawValue: 1 << 4)
        static let name = MethodParameter(rawValue: 1 << 5)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var prefix: String?
    private(set) var stripTrailingProtocol: Bool?
    private(set) var swiftlintAware: Bool?
    private(set) var includeTestableImport: Bool?
    private(set) var trackPropertyActivity: Bool?
    private(set) var name: String?

    func reset() {
        calledMethods = []
        assignedParameters = []
        prefix = nil
        stripTrailingProtocol = nil
        includeTestableImport = nil
        trackPropertyActivity = nil
        name = nil
    }

    func setParameters(prefix: String,
                       stripTrailingProtocol: Bool,
                       swiftlintAware: Bool,
                       includeTestableImport: Bool,
                       trackPropertyActivity: Bool) {
        calledMethods.insert(.setParametersPrefixStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityCalled)
        self.prefix = prefix
        assignedParameters.insert(.prefix)
        self.stripTrailingProtocol = stripTrailingProtocol
        assignedParameters.insert(.stripTrailingProtocol)
        self.swiftlintAware = swiftlintAware
        assignedParameters.insert(.swiftlintAware)
        self.includeTestableImport = includeTestableImport
        assignedParameters.insert(.includeTestableImport)
        self.trackPropertyActivity = trackPropertyActivity
        assignedParameters.insert(.trackPropertyActivity)
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

        if self.contains(.setParametersPrefixStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityCalled) {
            handleFirst()
            value += ".setParametersPrefixStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityCalled"
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
        if self.contains(.stripTrailingProtocol) {
            handleFirst()
            value += ".stripTrailingProtocol"
        }
        if self.contains(.swiftlintAware) {
            handleFirst()
            value += ".swiftlintAware"
        }
        if self.contains(.includeTestableImport) {
            handleFirst()
            value += ".includeTestableImport"
        }
        if self.contains(.trackPropertyActivity) {
            handleFirst()
            value += ".trackPropertyActivity"
        }
        if self.contains(.name) {
            handleFirst()
            value += ".name"
        }

        value += "]"
        return value
    }
}

//swiftlint:enable identifier_name
