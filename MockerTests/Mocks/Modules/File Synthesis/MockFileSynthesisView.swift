//swiftlint:disable identifier_name
//
//  MockFileSynthesisView.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit
import XcodeEditor

class MockFileSynthesisView: NSViewController, FileSynthesisViewProtocol {

    var presenter: FileSynthesisPresenterProtocol?

    struct Method: OptionSet {
        let rawValue: Int
        static let installDestinationGroupSelectorCalled = Method(rawValue: 1)
        static let enableCreateButtonFlagCalled = Method(rawValue: 2)
        static let setAddNewFileToProjectCheckboxFlagCalled = Method(rawValue: 4)
        static let closeCalled = Method(rawValue: 8)
        static let shouldOverwriteExistingFileNameCalled = Method(rawValue: 16)
        static let displayAlertCalled = Method(rawValue: 32)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let destinationGroupSelector = MethodParameter(rawValue: 1)
        static let flag = MethodParameter(rawValue: 2)
        static let name = MethodParameter(rawValue: 4)
        static let alert = MethodParameter(rawValue: 8)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var destinationGroupSelector: NSViewController?
    private(set) var flag: Bool?
    private(set) var name: String?
    private(set) var alert: NSAlert?

    var shouldOverwriteExistingFileNameReturnValue: Bool!

    func reset() {
        calledMethods = []
        assignedParameters = []
        destinationGroupSelector = nil
        flag = nil
        name = nil
        alert = nil
    }

    func install(destinationGroupSelector: NSViewController) {
        calledMethods.insert(.installDestinationGroupSelectorCalled)
        self.destinationGroupSelector = destinationGroupSelector
        assignedParameters.insert(.destinationGroupSelector)
    }

    func enableCreateButton(_ flag: Bool) {
        calledMethods.insert(.enableCreateButtonFlagCalled)
        self.flag = flag
        assignedParameters.insert(.flag)
    }

    func setAddNewFileToProjectCheckbox(_ flag: Bool) {
        calledMethods.insert(.setAddNewFileToProjectCheckboxFlagCalled)
        self.flag = flag
        assignedParameters.insert(.flag)
    }

    func close() {
        calledMethods.insert(.closeCalled)
    }

    func shouldOverwrite(existingFile name: String) -> Bool {
        calledMethods.insert(.shouldOverwriteExistingFileNameCalled)
        self.name = name
        assignedParameters.insert(.name)
        return shouldOverwriteExistingFileNameReturnValue
    }

    func display(_ alert: NSAlert) {
        calledMethods.insert(.displayAlertCalled)
        self.alert = alert
        assignedParameters.insert(.alert)
    }

}

extension MockFileSynthesisView.Method: CustomStringConvertible {
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
        if self.contains(.enableCreateButtonFlagCalled) {
            handleFirst()
            value += ".enableCreateButtonFlagCalled"
        }
        if self.contains(.setAddNewFileToProjectCheckboxFlagCalled) {
            handleFirst()
            value += ".setAddNewFileToProjectCheckboxFlagCalled"
        }
        if self.contains(.closeCalled) {
            handleFirst()
            value += ".closeCalled"
        }
        if self.contains(.shouldOverwriteExistingFileNameCalled) {
            handleFirst()
            value += ".shouldOverwriteExistingFileNameCalled"
        }
        if self.contains(.displayAlertCalled) {
            handleFirst()
            value += ".displayAlertCalled"
        }

        value += "]"
        return value
    }
}

extension MockFileSynthesisView.MethodParameter: CustomStringConvertible {
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
        if self.contains(.name) {
            handleFirst()
            value += ".name"
        }
        if self.contains(.alert) {
            handleFirst()
            value += ".alert"
        }

        value += "]"
        return value
    }
}
