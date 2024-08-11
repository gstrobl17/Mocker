//
//  MockSourceFileSelectorInteractorInput.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit
import XcodeEditor

class MockSourceFileSelectorInteractorInput: SourceFileSelectorInteractorInputProtocol {

    var presenter: (any SourceFileSelectorInteractorOutputProtocol)?

    struct Method: OptionSet, Sendable {
        let rawValue: Int
        static let viewHasLoadedCalled = Method(rawValue: 1)
    }
    private(set) var calledMethods = Method()

    func reset() {
        calledMethods = []
    }

    func viewHasLoaded() {
        calledMethods.insert(.viewHasLoadedCalled)
    }

}

extension MockSourceFileSelectorInteractorInput.Method: CustomStringConvertible {
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

        if self.contains(.viewHasLoadedCalled) {
            handleFirst()
            value += ".viewHasLoadedCalled"
        }

        value += "]"
        return value
    }
}

extension MockSourceFileSelectorInteractorInput: CustomReflectable {
    var customMirror: Mirror {
        Mirror(self,
               children: [
                "calledMethods": calledMethods
               ],
               displayStyle: .none
        )
    }
}
