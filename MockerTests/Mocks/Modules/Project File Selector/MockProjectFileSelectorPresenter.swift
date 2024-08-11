//
//  MockProjectFileSelectorPresenter.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit

class MockProjectFileSelectorPresenter: ProjectFileSelectorPresenterProtocol {

    var interactor: ProjectFileSelectorInteractorInputProtocol?

    struct Method: OptionSet, Sendable {
        let rawValue: Int
        static let setURLUrlCalled = Method(rawValue: 1)
        static let selectPressedCalled = Method(rawValue: 2)
        static let reloadPressedCalled = Method(rawValue: 4)
        static let canReloadProjectCalled = Method(rawValue: 8)
        static let viewHasLoadedCalled = Method(rawValue: 16)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
        let rawValue: Int
        static let url = MethodParameter(rawValue: 1)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var url: URL?

    var canReloadProjectReturnValue: Bool!

    func reset() {
        calledMethods = []
        assignedParameters = []
        url = nil
    }

    func setURL(_ url: URL) {
        calledMethods.insert(.setURLUrlCalled)
        self.url = url
        assignedParameters.insert(.url)
    }

    func selectPressed() {
        calledMethods.insert(.selectPressedCalled)
    }

    func reloadPressed() {
        calledMethods.insert(.reloadPressedCalled)
    }

    func canReloadProject() -> Bool {
        calledMethods.insert(.canReloadProjectCalled)
        return canReloadProjectReturnValue
    }

    func viewHasLoaded() {
        calledMethods.insert(.viewHasLoadedCalled)
    }

}

extension MockProjectFileSelectorPresenter.Method: CustomStringConvertible {
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

        if self.contains(.setURLUrlCalled) {
            handleFirst()
            value += ".setURLUrlCalled"
        }
        if self.contains(.selectPressedCalled) {
            handleFirst()
            value += ".selectPressedCalled"
        }
        if self.contains(.reloadPressedCalled) {
            handleFirst()
            value += ".reloadPressedCalled"
        }
        if self.contains(.canReloadProjectCalled) {
            handleFirst()
            value += ".canReloadProjectCalled"
        }
        if self.contains(.viewHasLoadedCalled) {
            handleFirst()
            value += ".viewHasLoadedCalled"
        }

        value += "]"
        return value
    }
}

extension MockProjectFileSelectorPresenter.MethodParameter: CustomStringConvertible {
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

        value += "]"
        return value
    }
}

extension MockProjectFileSelectorPresenter: CustomReflectable {
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
