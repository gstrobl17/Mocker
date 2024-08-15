//
//  MockProjectFileSelectorInteractorInput.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit

@MainActor
class MockProjectFileSelectorInteractorInput: ProjectFileSelectorInteractorInputProtocol {

    var presenter: (any ProjectFileSelectorInteractorOutputProtocol)?
    var url: URL?

    struct Method: OptionSet, Sendable {
        let rawValue: Int
        static let setURLUrlCalled = Method(rawValue: 1)
        static let projectFileSelectedUrlCalled = Method(rawValue: 2)
        static let viewHasLoadedCalled = Method(rawValue: 4)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
        let rawValue: Int
        static let url = MethodParameter(rawValue: 1)
    }
    private(set) var assignedParameters = MethodParameter()

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

    func projectFileSelected(_ url: URL) {
        calledMethods.insert(.projectFileSelectedUrlCalled)
        self.url = url
        assignedParameters.insert(.url)
    }

    func viewHasLoaded() {
        calledMethods.insert(.viewHasLoadedCalled)
    }

}

extension MockProjectFileSelectorInteractorInput.Method: CustomStringConvertible {
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
        if self.contains(.projectFileSelectedUrlCalled) {
            handleFirst()
            value += ".projectFileSelectedUrlCalled"
        }
        if self.contains(.viewHasLoadedCalled) {
            handleFirst()
            value += ".viewHasLoadedCalled"
        }

        value += "]"
        return value
    }
}

extension MockProjectFileSelectorInteractorInput.MethodParameter: CustomStringConvertible {
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

extension MockProjectFileSelectorInteractorInput: @preconcurrency CustomReflectable {
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
