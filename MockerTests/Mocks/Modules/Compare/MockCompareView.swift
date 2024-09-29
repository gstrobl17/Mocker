//
//  MockCompareView.swift
//  Mocker
//
//  Created by Greg Strobl on 9/28/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import AppKit

@MainActor
class MockCompareView: NSViewController, CompareViewProtocol, CompareInterfaceProtocol {

    // MARK: - Variables for Protocol Conformance

    var presenter: (any ComparePresenterProtocol)?
    var delegate: (any CompareInterfaceDelegate)?

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet, Sendable {
        let rawValue: UInt
        static let showButtonFlagCalled = Method(rawValue: 1 << 0)
        static let openModalSheetWithOpenPanelCompletionHandlerHandlerCalled = Method(rawValue: 1 << 1)
        static let reportErrorConditionWithMessageTextAndInformativeTextCalled = Method(rawValue: 1 << 2)
        static let mockCodeForCompareCalled = Method(rawValue: 1 << 3)
        static let enableCompareFlagCalled = Method(rawValue: 1 << 4)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
        let rawValue: UInt
        static let flag = MethodParameter(rawValue: 1 << 0)
        static let openPanel = MethodParameter(rawValue: 1 << 1)
        static let handler = MethodParameter(rawValue: 1 << 2)
        static let messageText = MethodParameter(rawValue: 1 << 3)
        static let informativeText = MethodParameter(rawValue: 1 << 4)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var flag: Bool?
    private(set) var openPanel: (any OpenPanel)?
    private(set) var handler: ((NSApplication.ModalResponse) -> Swift.Void)?
    private(set) var messageText: String?
    private(set) var informativeText: String?

    // MARK: - Variables to Use as Method Return Values

    var mockCodeForCompareReturnValue: String = ""

    // MARK: - Variables to Use to Control Completion Handlers

    var shouldCallHandler = false
    var openModelSheetResponse: NSApplication.ModalResponse = .OK

    func reset() {
        calledMethods = []
        assignedParameters = []
        flag = nil
        openPanel = nil
        handler = nil
        messageText = nil
        informativeText = nil
    }

    // MARK: - Methods for Protocol Conformance

    func showButton(_ flag: Bool) {
        calledMethods.insert(.showButtonFlagCalled)
        self.flag = flag
        assignedParameters.insert(.flag)
    }

    func openModalSheet(with openPanel: any OpenPanel, completionHandler handler: @escaping (NSApplication.ModalResponse) -> Swift.Void) {
        calledMethods.insert(.openModalSheetWithOpenPanelCompletionHandlerHandlerCalled)
        self.openPanel = openPanel
        assignedParameters.insert(.openPanel)
        self.handler = handler
        assignedParameters.insert(.handler)
        if shouldCallHandler {
            handler(openModelSheetResponse)
        }
    }

    func reportErrorCondition(with messageText: String, and informativeText: String) {
        calledMethods.insert(.reportErrorConditionWithMessageTextAndInformativeTextCalled)
        self.messageText = messageText
        assignedParameters.insert(.messageText)
        self.informativeText = informativeText
        assignedParameters.insert(.informativeText)
    }

    func mockCodeForCompare() -> String {
        calledMethods.insert(.mockCodeForCompareCalled)
        return mockCodeForCompareReturnValue
    }

    func enableCompare(_ flag: Bool) {
        calledMethods.insert(.enableCompareFlagCalled)
        self.flag = flag
        assignedParameters.insert(.flag)
    }

}

extension MockCompareView.Method: CustomStringConvertible {
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

        if self.contains(.showButtonFlagCalled) {
            handleFirst()
            value += ".showButtonFlagCalled"
        }
        if self.contains(.openModalSheetWithOpenPanelCompletionHandlerHandlerCalled) {
            handleFirst()
            value += ".openModalSheetWithOpenPanelCompletionHandlerHandlerCalled"
        }
        if self.contains(.reportErrorConditionWithMessageTextAndInformativeTextCalled) {
            handleFirst()
            value += ".reportErrorConditionWithMessageTextAndInformativeTextCalled"
        }
        if self.contains(.mockCodeForCompareCalled) {
            handleFirst()
            value += ".mockCodeForCompareCalled"
        }
        if self.contains(.enableCompareFlagCalled) {
            handleFirst()
            value += ".enableCompareFlagCalled"
        }

        value += "]"
        return value
    }
}

extension MockCompareView.MethodParameter: CustomStringConvertible {
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

        if self.contains(.flag) {
            handleFirst()
            value += ".flag"
        }
        if self.contains(.openPanel) {
            handleFirst()
            value += ".openPanel"
        }
        if self.contains(.handler) {
            handleFirst()
            value += ".handler"
        }
        if self.contains(.messageText) {
            handleFirst()
            value += ".messageText"
        }
        if self.contains(.informativeText) {
            handleFirst()
            value += ".informativeText"
        }

        value += "]"
        return value
    }
}

extension MockCompareView: @preconcurrency CustomReflectable {
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
