//swiftlint:disable identifier_name
//
//  MockMockFileParametersInteractorInput.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit
import SwiftSyntax
import XcodeEditor

class MockMockFileParametersInteractorInput: MockFileParametersInteractorInputProtocol {

    var presenter: MockFileParametersInteractorOutputProtocol?

    struct Method: OptionSet {
        let rawValue: Int
        static let setProtocolNameProtocolNameCalled = Method(rawValue: 1 << 0)
        static let prefixUpdatedToPrefixCalled = Method(rawValue: 1 << 1)
        static let includeHeaderFlagUpdatedToFlagCalled = Method(rawValue: 1 << 2)
        static let stripTrailingProtocolFlagUpdatedToFlagCalled = Method(rawValue: 1 << 3)
        static let swiftlintAwareFlagUpdatedToFlagCalled = Method(rawValue: 1 << 4)
        static let includeTestableImportFlagUpdatedToFlagCalled = Method(rawValue: 1 << 5)
        static let trackPropertyActivityFlagUpdatedToFlagCalled = Method(rawValue: 1 << 6)
        static let publicFlagUpdatedToFlagCalled = Method(rawValue: 1 << 7)
        static let viewHasLoadedCalled = Method(rawValue: 1 << 8)
     }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let protocolName = MethodParameter(rawValue: 1)
        static let prefix = MethodParameter(rawValue: 2)
        static let flag = MethodParameter(rawValue: 4)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var protocolName: String?
    private(set) var prefix: String?
    private(set) var flag: Bool?

    func reset() {
        calledMethods = []
        assignedParameters = []
        protocolName = nil
        prefix = nil
        flag = nil
    }

    func setProtocolName(_ protocolName: String) {
        calledMethods.insert(.setProtocolNameProtocolNameCalled)
        self.protocolName = protocolName
        assignedParameters.insert(.protocolName)
    }

    func prefixUpdated(to prefix: String) {
        calledMethods.insert(.prefixUpdatedToPrefixCalled)
        self.prefix = prefix
        assignedParameters.insert(.prefix)
    }

    func includeHeaderFlagUpdated(to flag: Bool) {
        calledMethods.insert(.includeHeaderFlagUpdatedToFlagCalled)
        self.flag = flag
        assignedParameters.insert(.flag)
    }

    func stripTrailingProtocolFlagUpdated(to flag: Bool) {
        calledMethods.insert(.stripTrailingProtocolFlagUpdatedToFlagCalled)
        self.flag = flag
        assignedParameters.insert(.flag)
    }

    func swiftlintAwareFlagUpdated(to flag: Bool) {
        calledMethods.insert(.swiftlintAwareFlagUpdatedToFlagCalled)
        self.flag = flag
        assignedParameters.insert(.flag)
    }
    
    func includeTestableImportFlagUpdated(to flag: Bool) {
        calledMethods.insert(.includeTestableImportFlagUpdatedToFlagCalled)
        self.flag = flag
        assignedParameters.insert(.flag)
    }

    func trackPropertyActivityFlagUpdated(to flag: Bool) {
        calledMethods.insert(.trackPropertyActivityFlagUpdatedToFlagCalled)
        self.flag = flag
        assignedParameters.insert(.flag)
    }

    func publicFlagUpdated(to flag: Bool) {
        calledMethods.insert(.publicFlagUpdatedToFlagCalled)
        self.flag = flag
        assignedParameters.insert(.flag)
    }

    func viewHasLoaded() {
        calledMethods.insert(.viewHasLoadedCalled)
    }

}

extension MockMockFileParametersInteractorInput.Method: CustomStringConvertible {
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

        if self.contains(.setProtocolNameProtocolNameCalled) {
            handleFirst()
            value += ".setProtocolNameProtocolNameCalled"
        }
        if self.contains(.prefixUpdatedToPrefixCalled) {
            handleFirst()
            value += ".prefixUpdatedToPrefixCalled"
        }
        if self.contains(.includeHeaderFlagUpdatedToFlagCalled) {
            handleFirst()
            value += ".includeHeaderFlagUpdatedToFlagCalled"
        }
        if self.contains(.stripTrailingProtocolFlagUpdatedToFlagCalled) {
            handleFirst()
            value += ".stripTrailingProtocolFlagUpdatedToFlagCalled"
        }
        if self.contains(.swiftlintAwareFlagUpdatedToFlagCalled) {
            handleFirst()
            value += ".swiftlintAwareFlagUpdatedToFlagCalled"
        }
        if self.contains(.includeTestableImportFlagUpdatedToFlagCalled) {
            handleFirst()
            value += ".includeTestableImportFlagUpdatedToFlagCalled"
        }
        if self.contains(.trackPropertyActivityFlagUpdatedToFlagCalled) {
            handleFirst()
            value += ".trackPropertyActivityFlagUpdatedToFlagCalled"
        }
        if self.contains(.publicFlagUpdatedToFlagCalled) {
            handleFirst()
            value += ".publicFlagUpdatedToFlagCalled"
        }
        if self.contains(.viewHasLoadedCalled) {
            handleFirst()
            value += ".viewHasLoadedCalled"
        }

        value += "]"
        return value
    }
}

extension MockMockFileParametersInteractorInput.MethodParameter: CustomStringConvertible {
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

        if self.contains(.protocolName) {
            handleFirst()
            value += ".protocolName"
        }
        if self.contains(.prefix) {
            handleFirst()
            value += ".prefix"
        }
        if self.contains(.flag) {
            handleFirst()
            value += ".flag"
        }

        value += "]"
        return value
    }
}

extension MockMockFileParametersInteractorInput: CustomReflectable {
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
