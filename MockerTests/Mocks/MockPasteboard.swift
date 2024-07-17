//
//  MockPasteboard.swift
//  MockerTests
//
//  Created by Greg Strobl on 5/11/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import AppKit

class MockPasteboard: Mocker.Pasteboard {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: UInt
        static let declareTypesNewTypesOwnerNewOwnerCalled = Method(rawValue: 1 << 0)
        static let setStringStringForTypeDataTypeCalled = Method(rawValue: 1 << 1)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: UInt
        static let newTypes = MethodParameter(rawValue: 1 << 0)
        static let newOwner = MethodParameter(rawValue: 1 << 1)
        static let string = MethodParameter(rawValue: 1 << 2)
        static let dataType = MethodParameter(rawValue: 1 << 3)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var newTypes: [NSPasteboard.PasteboardType]?
    private(set) var newOwner: Any?
    private(set) var string: String?
    private(set) var dataType: NSPasteboard.PasteboardType?

    // MARK: - Variables to Use as Method Return Values

    var declareTypesNewTypesOwnerNewOwnerReturnValue = 0
    var setStringStringForTypeDataTypeReturnValue = true

    func reset() {
        calledMethods = []
        assignedParameters = []
        newTypes = nil
        newOwner = nil
        string = nil
        dataType = nil
    }

    // MARK: - Methods for Protocol Conformance

    @discardableResult
    func declareTypes(_ newTypes: [NSPasteboard.PasteboardType], owner newOwner: Any?) -> Int {
        calledMethods.insert(.declareTypesNewTypesOwnerNewOwnerCalled)
        self.newTypes = newTypes
        assignedParameters.insert(.newTypes)
        self.newOwner = newOwner
        assignedParameters.insert(.newOwner)
        return declareTypesNewTypesOwnerNewOwnerReturnValue
    }

    @discardableResult
    func setString(_ string: String, forType dataType: NSPasteboard.PasteboardType) -> Bool {
        calledMethods.insert(.setStringStringForTypeDataTypeCalled)
        self.string = string
        assignedParameters.insert(.string)
        self.dataType = dataType
        assignedParameters.insert(.dataType)
        return setStringStringForTypeDataTypeReturnValue
    }

}

extension MockPasteboard.Method: CustomStringConvertible {
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

        if self.contains(.declareTypesNewTypesOwnerNewOwnerCalled) {
            handleFirst()
            value += ".declareTypesNewTypesOwnerNewOwnerCalled"
        }
        if self.contains(.setStringStringForTypeDataTypeCalled) {
            handleFirst()
            value += ".setStringStringForTypeDataTypeCalled"
        }

        value += "]"
        return value
    }
}

extension MockPasteboard.MethodParameter: CustomStringConvertible {
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

        if self.contains(.newTypes) {
            handleFirst()
            value += ".newTypes"
        }
        if self.contains(.newOwner) {
            handleFirst()
            value += ".newOwner"
        }
        if self.contains(.string) {
            handleFirst()
            value += ".string"
        }
        if self.contains(.dataType) {
            handleFirst()
            value += ".dataType"
        }

        value += "]"
        return value
    }
}

extension MockPasteboard: CustomReflectable {
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
