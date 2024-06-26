//
//  MockGodfatherPresenter.swift
//  Mocker
//
// Created by Greg on 10/12/18.
//

@testable import Mocker
import AppKit

class MockGodfatherPresenter: GodfatherPresenterProtocol {

    var interactor: GodfatherInteractorInputProtocol?

    struct Method: OptionSet {
        let rawValue: Int
        static let selectProjectCalled = Method(rawValue: 1 << 0)
        static let canReloadProjectCalled = Method(rawValue: 1 << 1)
        static let reloadProjectCalled = Method(rawValue: 1 << 2)
        static let displayChoiceChoiceCalled = Method(rawValue: 1 << 3)
        static let copyMockToClipboardCalled = Method(rawValue: 1 << 4)
        static let viewHasAppearedCalled = Method(rawValue: 1 << 5)
        static let openRecentProjectFileUrlCalled = Method(rawValue: 1 << 6)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let choice = MethodParameter(rawValue: 1 << 0)
        static let url = MethodParameter(rawValue: 1 << 1)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var choice: DisplayChoice?
    private(set) var url: URL?

    // MARK: - Variables to Use as Method Return Values

    var canReloadProjectReturnValue: Bool!

    func reset() {
        calledMethods = []
        assignedParameters = []
        choice = nil
        url = nil
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

    func displayChoice(_ choice: DisplayChoice) {
        calledMethods.insert(.displayChoiceChoiceCalled)
        self.choice = choice
        assignedParameters.insert(.choice)
    }

    func copyMockToClipboard() {
        calledMethods.insert(.copyMockToClipboardCalled)
    }

    func viewHasAppeared() {
        calledMethods.insert(.viewHasAppearedCalled)
    }

    func openRecentProjectFile(_ url: URL) {
        calledMethods.insert(.openRecentProjectFileUrlCalled)
        self.url = url
        assignedParameters.insert(.url)
    }

}

extension MockGodfatherPresenter.Method: CustomStringConvertible {
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

        if self.contains(.selectProjectCalled) {
            handleFirst()
            value += ".selectProjectCalled"
        }
        if self.contains(.canReloadProjectCalled) {
            handleFirst()
            value += ".canReloadProjectCalled"
        }
        if self.contains(.reloadProjectCalled) {
            handleFirst()
            value += ".reloadProjectCalled"
        }
        if self.contains(.displayChoiceChoiceCalled) {
            handleFirst()
            value += ".displayChoiceChoiceCalled"
        }
        if self.contains(.viewHasAppearedCalled) {
            handleFirst()
            value += ".viewHasAppearedCalled"
        }
        if self.contains(.openRecentProjectFileUrlCalled) {
            handleFirst()
            value += ".openRecentProjectFileUrlCalled"
        }
        
        value += "]"
        return value
    }
}

extension MockGodfatherPresenter.MethodParameter: CustomStringConvertible {
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

        if self.contains(.choice) {
            handleFirst()
            value += ".choice"
        }
        if self.contains(.url) {
            handleFirst()
            value += ".url"
        }

        value += "]"
        return value
    }
}
