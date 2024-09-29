//
//  MockComparePresenter.swift
//  Mocker
//
//  Created by Greg Strobl on 9/28/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import AppKit

@MainActor
class MockComparePresenter: ComparePresenterProtocol {

    // MARK: - Variables for Protocol Conformance

    var interactor: (any CompareInteractorInputProtocol)?

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet, Sendable {
        let rawValue: UInt
        static let compareButtonPressedCalled = Method(rawValue: 1 << 0)
    }
    private(set) var calledMethods = Method()

    func reset() {
        calledMethods = []
    }

    // MARK: - Methods for Protocol Conformance

    func compareButtonPressed() {
        calledMethods.insert(.compareButtonPressedCalled)
    }

}

extension MockComparePresenter.Method: CustomStringConvertible {
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

        if self.contains(.compareButtonPressedCalled) {
            handleFirst()
            value += ".compareButtonPressedCalled"
        }

        value += "]"
        return value
    }
}

extension MockComparePresenter: @preconcurrency CustomReflectable {
    var customMirror: Mirror {
        Mirror(self,
               children: [
                "calledMethods": calledMethods
               ],
               displayStyle: .none
        )
    }
}
