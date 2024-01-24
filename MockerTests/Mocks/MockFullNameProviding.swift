//
//  MockFullNameProviding.swift
//  MockerTests
//
//  Created by Greg Strobl on 1/24/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import Foundation

class MockFullNameProviding: FullNameProviding {

    // MARK: - Variables for Properties Used for Protocol Conformance
    // Use these properties to get/set/initialize the properties without registering a method call

    var _name: String = "Chris X. Programmer"

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: UInt
        static let nameGetterCalled = Method(rawValue: 1 << 0)
    }
    private(set) var calledMethods = Method()

    func reset() {
        calledMethods = []
    }

    // MARK: - Properties for Protocol Conformance

    var name: String {
        calledMethods.insert(.nameGetterCalled)
        return _name
    }

}

extension MockFullNameProviding.Method: CustomStringConvertible {
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

        if self.contains(.nameGetterCalled) {
            handleFirst()
            value += ".nameGetterCalled"
        }

        value += "]"
        return value
    }
}
