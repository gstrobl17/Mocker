//
//  MockGodfatherInteractorInput.swift
//  Mocker
//
// Created by Greg on 10/12/18.
//

@testable import Mocker
import AppKit

class MockGodfatherInteractorInput: GodfatherInteractorInputProtocol {

    var presenter: GodfatherInteractorOutputProtocol?
    var userDefaults: KeyValueStoring = MockUserDefaults()
    var fileManager: FileManaging = MockFileManager()
    var currentProject: Project?
    var mockName: String = ""
    var mockCode: String = ""

    struct Method: OptionSet {
        let rawValue: Int
        static let selectProjectCalled = Method(rawValue: 1 << 0)
        static let canReloadProjectCalled = Method(rawValue: 1 << 1)
        static let reloadProjectCalled = Method(rawValue: 1 << 2)
        static let viewHasAppearedCalled = Method(rawValue: 1 << 3)
        static let displayChoiceChoiceCalled = Method(rawValue: 1 << 4)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let choice = MethodParameter(rawValue: 1 << 0)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var choice: DisplayChoice?

    var canReloadProjectReturnValue = false

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

    func viewHasAppeared() {
        calledMethods.insert(.viewHasAppearedCalled)
    }

    func displayChoice(_ choice: DisplayChoice) {
        calledMethods.insert(.displayChoiceChoiceCalled)
        self.choice = choice
        assignedParameters.insert(.choice)
    }

}

extension MockGodfatherInteractorInput.Method: CustomStringConvertible {
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
        if self.contains(.viewHasAppearedCalled) {
            handleFirst()
            value += ".viewHasAppearedCalled"
        }
        if self.contains(.displayChoiceChoiceCalled) {
            handleFirst()
            value += ".displayChoiceChoiceCalled"
        }

        value += "]"
        return value
    }
}

extension MockGodfatherInteractorInput.MethodParameter: CustomStringConvertible {
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