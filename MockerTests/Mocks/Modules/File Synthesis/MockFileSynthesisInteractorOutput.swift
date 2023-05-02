//swiftlint:disable identifier_name
//
//  MockFileSynthesisInteractorOutput.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit
import XcodeEditor

class MockFileSynthesisInteractorOutput: FileSynthesisInteractorOutputProtocol {

    struct Method: OptionSet {
        let rawValue: Int
        static let installDestinationGroupSelectorCalled = Method(rawValue: 1)
        static let groupWasSelectedCalled = Method(rawValue: 2)
        static let setAddNewFileToProjectCheckboxFlagCalled = Method(rawValue: 4)
        static let mockFileWasCreatedCalled = Method(rawValue: 8)
        static let mockFileCreationFailedErrorCalled = Method(rawValue: 16)
        static let shouldOverwriteExistingFileNameCalled = Method(rawValue: 32)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let destinationGroupSelector = MethodParameter(rawValue: 1)
        static let flag = MethodParameter(rawValue: 2)
        static let error = MethodParameter(rawValue: 4)
        static let name = MethodParameter(rawValue: 8)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var destinationGroupSelector: NSViewController?
    private(set) var flag: Bool?
    private(set) var error: Error?
    private(set) var name: String?

    var shouldOverwriteExistingFileNameReturnValue: Bool!

    func reset() {
        calledMethods = []
        assignedParameters = []
        destinationGroupSelector = nil
        flag = nil
        error = nil
        name = nil
    }

    func install(destinationGroupSelector: NSViewController) {
        calledMethods.insert(.installDestinationGroupSelectorCalled)
        self.destinationGroupSelector = destinationGroupSelector
        assignedParameters.insert(.destinationGroupSelector)
    }

    func groupWasSelected() {
        calledMethods.insert(.groupWasSelectedCalled)
    }

    func setAddNewFileToProjectCheckbox(_ flag: Bool) {
        calledMethods.insert(.setAddNewFileToProjectCheckboxFlagCalled)
        self.flag = flag
        assignedParameters.insert(.flag)
    }

    func mockFileWasCreated() {
        calledMethods.insert(.mockFileWasCreatedCalled)
    }

    func mockFileCreationFailed(_ error: Error) {
        calledMethods.insert(.mockFileCreationFailedErrorCalled)
        self.error = error
        assignedParameters.insert(.error)
    }

    func shouldOverwrite(existingFile name: String) -> Bool {
        calledMethods.insert(.shouldOverwriteExistingFileNameCalled)
        self.name = name
        assignedParameters.insert(.name)
        return shouldOverwriteExistingFileNameReturnValue
    }

}

extension MockFileSynthesisInteractorOutput.Method: CustomStringConvertible {
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

        if self.contains(.installDestinationGroupSelectorCalled) {
            handleFirst()
            value += ".installDestinationGroupSelectorCalled"
        }
        if self.contains(.groupWasSelectedCalled) {
            handleFirst()
            value += ".groupWasSelectedCalled"
        }
        if self.contains(.setAddNewFileToProjectCheckboxFlagCalled) {
            handleFirst()
            value += ".setAddNewFileToProjectCheckboxFlagCalled"
        }
        if self.contains(.mockFileWasCreatedCalled) {
            handleFirst()
            value += ".mockFileWasCreatedCalled"
        }
        if self.contains(.mockFileCreationFailedErrorCalled) {
            handleFirst()
            value += ".mockFileCreationFailedErrorCalled"
        }
        if self.contains(.shouldOverwriteExistingFileNameCalled) {
            handleFirst()
            value += ".shouldOverwriteExistingFileNameCalled"
        }

        value += "]"
        return value
    }
}

extension MockFileSynthesisInteractorOutput.MethodParameter: CustomStringConvertible {
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

        if self.contains(.destinationGroupSelector) {
            handleFirst()
            value += ".destinationGroupSelector"
        }
        if self.contains(.flag) {
            handleFirst()
            value += ".flag"
        }
        if self.contains(.error) {
            handleFirst()
            value += ".error"
        }
        if self.contains(.name) {
            handleFirst()
            value += ".name"
        }

        value += "]"
        return value
    }
}
