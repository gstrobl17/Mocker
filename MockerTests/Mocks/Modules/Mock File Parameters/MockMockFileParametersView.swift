//swiftlint:disable identifier_name
//
//  MockMockFileParametersView.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit
import SwiftSyntax
import XcodeEditor

class MockMockFileParametersView: NSViewController, MockFileParametersViewProtocol, MockFileParametersInterfaceProtocol {

    var presenter: MockFileParametersPresenterProtocol?
    var delegate: MockFileParametersInterfaceDelegate?  //swiftlint:disable:this weak_delegate

    struct Method: OptionSet {
        let rawValue: Int
        static let setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityPublicCalled = Method(rawValue: 1)
        static let setNameNameCalled = Method(rawValue: 2)
        static let setupForProtocolDeclarationCalled = Method(rawValue: 4)
        static let setupForDataSourceCalled = Method(rawValue: 8)
        static let setupForTargetCalled = Method(rawValue: 16)
        static let clearProtocolCalled = Method(rawValue: 32)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let prefix = MethodParameter(rawValue: 1 << 0)
        static let includeHeader = MethodParameter(rawValue: 1 << 1)
        static let stripTrailingProtocol = MethodParameter(rawValue: 1 << 2)
        static let swiftlintAware = MethodParameter(rawValue: 1 << 3)
        static let includeTestableImport = MethodParameter(rawValue: 1 << 4)
        static let trackPropertyActivity = MethodParameter(rawValue: 1 << 5)
        static let `public` = MethodParameter(rawValue: 1 << 6)
        static let name = MethodParameter(rawValue: 1 << 7)
        static let protocolDeclaration = MethodParameter(rawValue: 1 << 8)
        static let dataSource = MethodParameter(rawValue: 1 << 9)
        static let target = MethodParameter(rawValue: 1 << 10)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var prefix: String?
    private(set) var includeHeader: Bool?
    private(set) var stripTrailingProtocol: Bool?
    private(set) var swiftlintAware: Bool?
    private(set) var includeTestableImport: Bool?
    private(set) var trackPropertyActivity: Bool?
    private(set) var `public`: Bool?
    private(set) var name: String?
    private(set) var protocolDeclaration: ProtocolDeclSyntax?
    private(set) var dataSource: SourceFileDataSource?
    private(set) var target: String?

    func reset() {
        calledMethods = []
        assignedParameters = []
        prefix = nil
        includeHeader = nil
        stripTrailingProtocol = nil
        swiftlintAware = nil
        includeTestableImport = nil
        trackPropertyActivity = nil
        `public` = nil
        name = nil
        protocolDeclaration = nil
        dataSource = nil
        target = nil
    }

    //swiftlint:disable:next function_parameter_count
    func setParameters(prefix: String,
                       includeHeader: Bool,
                       stripTrailingProtocol: Bool,
                       swiftlintAware: Bool,
                       includeTestableImport: Bool,
                       trackPropertyActivity: Bool,
                       public: Bool) {
        calledMethods.insert(.setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityPublicCalled)
        self.prefix = prefix
        assignedParameters.insert(.prefix)
        self.includeHeader = includeHeader
        assignedParameters.insert(.includeHeader)
        self.stripTrailingProtocol = stripTrailingProtocol
        assignedParameters.insert(.stripTrailingProtocol)
        self.swiftlintAware = swiftlintAware
        assignedParameters.insert(.swiftlintAware)
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

    func setup(for protocolDeclaration: ProtocolDeclSyntax) {
        calledMethods.insert(.setupForProtocolDeclarationCalled)
        self.protocolDeclaration = protocolDeclaration
        assignedParameters.insert(.protocolDeclaration)
    }
    
    func setup(for dataSource: SourceFileDataSource) {
        calledMethods.insert(.setupForDataSourceCalled)
        self.dataSource = dataSource
        assignedParameters.insert(.dataSource)
    }
    
    func setup(for target: String) {
        calledMethods.insert(.setupForTargetCalled)
        self.target = target
        assignedParameters.insert(.target)
    }
    
    func clearProtocol() {
        calledMethods.insert(.clearProtocolCalled)
    }

}

extension MockMockFileParametersView.Method: CustomStringConvertible {
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

        if self.contains(.setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityPublicCalled) {
            handleFirst()
            value += ".setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityPublicCalled"
        }
        if self.contains(.setNameNameCalled) {
            handleFirst()
            value += ".setNameNameCalled"
        }
        if self.contains(.setupForProtocolDeclarationCalled) {
            handleFirst()
            value += ".setupForProtocolDeclarationCalled"
        }
        if self.contains(.setupForDataSourceCalled) {
            handleFirst()
            value += ".setupForDataSourceCalled"
        }
        if self.contains(.setupForTargetCalled) {
            handleFirst()
            value += ".setupForTargetCalled"
        }
        if self.contains(.clearProtocolCalled) {
            handleFirst()
            value += ".clearProtocolCalled"
        }

        value += "]"
        return value
    }
}

extension MockMockFileParametersView.MethodParameter: CustomStringConvertible {
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
        if self.contains(.public) {
            handleFirst()
            value += ".public"
        }
        if self.contains(.name) {
            handleFirst()
            value += ".name"
        }
        if self.contains(.protocolDeclaration) {
            handleFirst()
            value += ".protocolDeclaration"
        }
        if self.contains(.dataSource) {
            handleFirst()
            value += ".dataSource"
        }
        if self.contains(.target) {
            handleFirst()
            value += ".target"
        }

        value += "]"
        return value
    }
}

//swiftlint:enable identifier_name
