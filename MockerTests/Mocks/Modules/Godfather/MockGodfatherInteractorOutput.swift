//
//  MockGodfatherInteractorOutput.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit

@MainActor
class MockGodfatherInteractorOutput: GodfatherInteractorOutputProtocol {

    struct Method: OptionSet, Sendable {
        let rawValue: Int
        static let installProjectFileSelectorSourceFileSelectorSourceFileFilterProtocolSelectorMockFileParametersContentPresenterCalled = Method(rawValue: 1 << 0)
        static let reportErrorErrorCalled = Method(rawValue: 1 << 1)
        static let reportErrorConditionWithMessageTextAndInformativeTextCalled = Method(rawValue: 1 << 2)
        static let showAsBusyWithMessageCalled = Method(rawValue: 1 << 3)
        static let clearBusyMessageCalled = Method(rawValue: 1 << 4)
        static let canChooseDisplayFlagCalled = Method(rawValue: 1 << 5)
        static let setDisplayChoiceChoiceCalled = Method(rawValue: 1 << 6)
        static let mockCopiedToClipboardCalled = Method(rawValue: 1 << 7)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
        let rawValue: Int
        static let projectFileSelector = MethodParameter(rawValue: 1 << 0)
        static let sourceFileSelector = MethodParameter(rawValue: 1 << 1)
        static let sourceFileFilter = MethodParameter(rawValue: 1 << 2)
        static let protocolSelector = MethodParameter(rawValue: 1 << 3)
        static let mockFileParameters = MethodParameter(rawValue: 1 << 4)
        static let contentPresenter = MethodParameter(rawValue: 1 << 5)
        static let error = MethodParameter(rawValue: 1 << 6)
        static let messageText = MethodParameter(rawValue: 1 << 7)
        static let informativeText = MethodParameter(rawValue: 1 << 8)
        static let message = MethodParameter(rawValue: 1 << 9)
        static let flag = MethodParameter(rawValue: 1 << 10)
        static let choice = MethodParameter(rawValue: 1 << 11)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var projectFileSelector: NSViewController?
    private(set) var sourceFileSelector: NSViewController?
    private(set) var sourceFileFilter: NSViewController?
    private(set) var protocolSelector: NSViewController?
    private(set) var mockFileParameters: NSViewController?
    private(set) var contentPresenter: NSViewController?
    private(set) var error: (any Error)?
    private(set) var messageText: String?
    private(set) var informativeText: String?
    private(set) var message: String?
    private(set) var flag: Bool?
    private(set) var choice: DisplayChoice?

    func reset() {
        calledMethods = []
        assignedParameters = []
        projectFileSelector = nil
        sourceFileSelector = nil
        sourceFileFilter = nil
        protocolSelector = nil
        mockFileParameters = nil
        contentPresenter = nil
        error = nil
        messageText = nil
        informativeText = nil
        message = nil
        flag = nil
        choice = nil
    }

    //swiftlint:disable:next function_parameter_count
    func install(projectFileSelector: NSViewController, sourceFileSelector: NSViewController, sourceFileFilter: NSViewController, protocolSelector: NSViewController, mockFileParameters: NSViewController, contentPresenter: NSViewController) {
        calledMethods.insert(.installProjectFileSelectorSourceFileSelectorSourceFileFilterProtocolSelectorMockFileParametersContentPresenterCalled)
        self.projectFileSelector = projectFileSelector
        assignedParameters.insert(.projectFileSelector)
        self.sourceFileSelector = sourceFileSelector
        assignedParameters.insert(.sourceFileSelector)
        self.sourceFileFilter = sourceFileFilter
        assignedParameters.insert(.sourceFileFilter)
        self.protocolSelector = protocolSelector
        assignedParameters.insert(.protocolSelector)
        self.mockFileParameters = mockFileParameters
        assignedParameters.insert(.mockFileParameters)
        self.contentPresenter = contentPresenter
        assignedParameters.insert(.contentPresenter)
    }

    func reportError(_ error: any Error) {
        calledMethods.insert(.reportErrorErrorCalled)
        self.error = error
        assignedParameters.insert(.error)
    }

    func reportErrorCondition(with messageText: String, and informativeText: String) {
        calledMethods.insert(.reportErrorConditionWithMessageTextAndInformativeTextCalled)
        self.messageText = messageText
        assignedParameters.insert(.messageText)
        self.informativeText = informativeText
        assignedParameters.insert(.informativeText)
    }

    func showAsBusy(with message: String) {
        calledMethods.insert(.showAsBusyWithMessageCalled)
        self.message = message
        assignedParameters.insert(.message)
    }

    func clearBusyMessage() {
        calledMethods.insert(.clearBusyMessageCalled)
    }

    func canChooseDisplay(_ flag: Bool) {
        calledMethods.insert(.canChooseDisplayFlagCalled)
        self.flag = flag
        assignedParameters.insert(.flag)
    }

    func setDisplayChoice(_ choice: DisplayChoice) {
        calledMethods.insert(.setDisplayChoiceChoiceCalled)
        self.choice = choice
        assignedParameters.insert(.choice)
    }

    func mockCopiedToClipboard() {
        calledMethods.insert(.mockCopiedToClipboardCalled)
    }

}

extension MockGodfatherInteractorOutput.Method: CustomStringConvertible {
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

        if self.contains(.installProjectFileSelectorSourceFileSelectorSourceFileFilterProtocolSelectorMockFileParametersContentPresenterCalled) {
            handleFirst()
            value += ".installProjectFileSelectorSourceFileSelectorSourceFileFilterProtocolSelectorMockFileParametersContentPresenterCalled"
        }
        if self.contains(.reportErrorErrorCalled) {
            handleFirst()
            value += ".reportErrorErrorCalled"
        }
        if self.contains(.reportErrorConditionWithMessageTextAndInformativeTextCalled) {
            handleFirst()
            value += ".reportErrorConditionWithMessageTextAndInformativeTextCalled"
        }
        if self.contains(.showAsBusyWithMessageCalled) {
            handleFirst()
            value += ".showAsBusyWithMessageCalled"
        }
        if self.contains(.clearBusyMessageCalled) {
            handleFirst()
            value += ".clearBusyMessageCalled"
        }
        if self.contains(.canChooseDisplayFlagCalled) {
            handleFirst()
            value += ".canChooseDisplayFlagCalled"
        }
        if self.contains(.setDisplayChoiceChoiceCalled) {
            handleFirst()
            value += ".setDisplayChoiceChoiceCalled"
        }
        if self.contains(.mockCopiedToClipboardCalled) {
            handleFirst()
            value += ".mockCopiedToClipboardCalled"
        }

        value += "]"
        return value
    }
}

extension MockGodfatherInteractorOutput.MethodParameter: CustomStringConvertible {
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

        if self.contains(.projectFileSelector) {
            handleFirst()
            value += ".projectFileSelector"
        }
        if self.contains(.sourceFileSelector) {
            handleFirst()
            value += ".sourceFileSelector"
        }
        if self.contains(.sourceFileFilter) {
            handleFirst()
            value += ".sourceFileFilter"
        }
        if self.contains(.protocolSelector) {
            handleFirst()
            value += ".protocolSelector"
        }
        if self.contains(.mockFileParameters) {
            handleFirst()
            value += ".mockFileParameters"
        }
        if self.contains(.contentPresenter) {
            handleFirst()
            value += ".contentPresenter"
        }
        if self.contains(.error) {
            handleFirst()
            value += ".error"
        }
        if self.contains(.messageText) {
            handleFirst()
            value += ".messageText"
        }
        if self.contains(.informativeText) {
            handleFirst()
            value += ".informativeText"
        }
        if self.contains(.message) {
            handleFirst()
            value += ".message"
        }
        if self.contains(.flag) {
            handleFirst()
            value += ".flag"
        }
        if self.contains(.choice) {
            handleFirst()
            value += ".choice"
        }

        value += "]"
        return value
    }
}

extension MockGodfatherInteractorOutput: @preconcurrency CustomReflectable {
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
