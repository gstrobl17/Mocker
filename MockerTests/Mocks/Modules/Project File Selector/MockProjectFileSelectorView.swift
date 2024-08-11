//swiftlint:disable weak_delegate identifier_name
//
//  MockProjectFileSelectorView.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit

class MockProjectFileSelectorView: NSViewController, ProjectFileSelectorViewProtocol, ProjectFileSelectorInterfaceProtocol {

    var presenter: (any ProjectFileSelectorPresenterProtocol)?
    var delegate: (any ProjectFileSelectorInterfaceDelegate)?

    struct Method: OptionSet {
        let rawValue: Int
        static let showSelectedFileUrlCalled = Method(rawValue: 1 << 0)
        static let openModalSheetWithOpenPanelCompletionHandlerHandlerCalled = Method(rawValue: 1 << 1)
        static let selectProjectCalled = Method(rawValue: 1 << 2)
        static let canReloadProjectCalled = Method(rawValue: 1 << 3)
        static let reloadProjectCalled = Method(rawValue: 1 << 4)
        static let renderURLOfSelectedFileUrlCalled = Method(rawValue: 1 << 5)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let url = MethodParameter(rawValue: 1 << 0)
        static let openPanel = MethodParameter(rawValue: 1 << 1)
        static let handler = MethodParameter(rawValue: 1 << 2)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var url: URL?
    private(set) var openPanel: (any OpenPanel)?
    private(set) var handler: ((NSApplication.ModalResponse) -> Swift.Void)?

    var canReloadProjectReturnValue: Bool!

    func reset() {
        calledMethods = []
        assignedParameters = []
        url = nil
        openPanel = nil
        handler = nil
    }

    func showSelectedFile(_ url: URL) {
        calledMethods.insert(.showSelectedFileUrlCalled)
        self.url = url
        assignedParameters.insert(.url)
    }

    func openModalSheet(with openPanel: any OpenPanel, completionHandler handler: @escaping (NSApplication.ModalResponse) -> Swift.Void) {
        calledMethods.insert(.openModalSheetWithOpenPanelCompletionHandlerHandlerCalled)
        self.openPanel = openPanel
        assignedParameters.insert(.openPanel)
        self.handler = handler
        assignedParameters.insert(.handler)
    }

    func selectProject() {
        calledMethods.insert(.selectProjectCalled)
    }
    
    func canReloadProject() -> Bool {
        calledMethods.insert(.canReloadProjectCalled)
        return canReloadProjectReturnValue
    }
    
    func reloadProject() {
        calledMethods.insert(.reloadProjectCalled)
    }

    func renderURLOfSelectedFile(_ url: URL) {
        calledMethods.insert(.renderURLOfSelectedFileUrlCalled)
        self.url = url
        assignedParameters.insert(.url)
    }

}

extension MockProjectFileSelectorView.Method: CustomStringConvertible {
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

        if self.contains(.showSelectedFileUrlCalled) {
            handleFirst()
            value += ".showSelectedFileUrlCalled"
        }
        if self.contains(.openModalSheetWithOpenPanelCompletionHandlerHandlerCalled) {
            handleFirst()
            value += ".openModalSheetWithOpenPanelCompletionHandlerHandlerCalled"
        }
        if self.contains(.canReloadProjectCalled) {
            handleFirst()
            value += ".canReloadProjectCalled"
        }
        if self.contains(.reloadProjectCalled) {
            handleFirst()
            value += ".reloadProjectCalled"
        }
        if self.contains(.showSelectedFileUrlCalled) {
            handleFirst()
            value += ".showSelectedFileUrlCalled"
        }
        if self.contains(.renderURLOfSelectedFileUrlCalled) {
            handleFirst()
            value += ".renderURLOfSelectedFileUrlCalled"
        }

        value += "]"
        return value
    }
}

extension MockProjectFileSelectorView.MethodParameter: CustomStringConvertible {
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
        if self.contains(.openPanel) {
            handleFirst()
            value += ".openPanel"
        }
        if self.contains(.handler) {
            handleFirst()
            value += ".handler"
        }

        value += "]"
        return value
    }
}

extension MockProjectFileSelectorView: CustomReflectable {
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

//swiftlint:enable weak_delegate identifier_name
