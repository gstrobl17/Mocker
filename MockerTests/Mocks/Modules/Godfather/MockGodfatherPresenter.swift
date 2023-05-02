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
        static let generateButtonPressedCalled = Method(rawValue: 1 << 4)
        static let viewHasAppearedCalled = Method(rawValue: 1 << 5)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let choice = MethodParameter(rawValue: 1 << 0)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var choice: DisplayChoice?

    var canReloadProjectReturnValue: Bool!

    func reset() {
        calledMethods = []
        assignedParameters = []
        choice = nil
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

    func generateButtonPressed() {
        calledMethods.insert(.generateButtonPressedCalled)
    }

    func viewHasAppeared() {
        calledMethods.insert(.viewHasAppearedCalled)
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
        if self.contains(.generateButtonPressedCalled) {
            handleFirst()
            value += ".generateButtonPressedCalled"
        }
        if self.contains(.viewHasAppearedCalled) {
            handleFirst()
            value += ".viewHasAppearedCalled"
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

        value += "]"
        return value
    }
}
