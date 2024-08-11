//
//  MockFilterInterface.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit

class MockFilterInterface: FilterInterfaceProtocol {

    var delegate: (any FilterInterfaceDelegate)?  //swiftlint:disable:this weak_delegate

    struct Method: OptionSet {
        let rawValue: Int
        static let clearCalled = Method(rawValue: 1)
    }
    private(set) var calledMethods = Method()

    func reset() {
        calledMethods = []
    }

    func clear() {
        calledMethods.insert(.clearCalled)
    }

}

extension MockFilterInterface.Method: CustomStringConvertible {
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

        if self.contains(.clearCalled) {
            handleFirst()
            value += ".clearCalled"
        }

        value += "]"
        return value
    }
}

extension MockFilterInterface: CustomReflectable {
    var customMirror: Mirror {
        Mirror(self,
               children: [
                "calledMethods": calledMethods
               ],
               displayStyle: .none
        )
    }
}
