//
//  MockKeyValueStoring.swift
//  MockerTests
//
//  Created by Greg Strobl on 2/3/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import Foundation

class MockKeyValueStoring: KeyValueStoring {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet {
        let rawValue: UInt
        static let objectForKeyDefaultNameCalled = Method(rawValue: 1 << 0)
        static let setValueForKeyDefaultNameCalled = Method(rawValue: 1 << 1)
        static let removeObjectForKeyDefaultNameCalled = Method(rawValue: 1 << 2)
        static let stringForKeyDefaultNameCalled = Method(rawValue: 1 << 3)
        static let arrayForKeyDefaultNameCalled = Method(rawValue: 1 << 4)
        static let dictionaryForKeyDefaultNameCalled = Method(rawValue: 1 << 5)
        static let dataForKeyDefaultNameCalled = Method(rawValue: 1 << 6)
        static let stringArrayForKeyDefaultNameCalled = Method(rawValue: 1 << 7)
        static let integerForKeyDefaultNameCalled = Method(rawValue: 1 << 8)
        static let floatForKeyDefaultNameCalled = Method(rawValue: 1 << 9)
        static let doubleForKeyDefaultNameCalled = Method(rawValue: 1 << 10)
        static let boolForKeyDefaultNameCalled = Method(rawValue: 1 << 11)
        static let urlForKeyDefaultNameCalled = Method(rawValue: 1 << 12)
        static let setValueForKeyDefaultNameCalled1 = Method(rawValue: 1 << 13)
        static let setValueForKeyDefaultNameCalled2 = Method(rawValue: 1 << 14)
        static let setValueForKeyDefaultNameCalled3 = Method(rawValue: 1 << 15)
        static let setValueForKeyDefaultNameCalled4 = Method(rawValue: 1 << 16)
        static let setUrlForKeyDefaultNameCalled = Method(rawValue: 1 << 17)
        static let registerDefaultsRegistrationDictionaryCalled = Method(rawValue: 1 << 18)
        static let synchronizeCalled = Method(rawValue: 1 << 19)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: UInt
        static let defaultName = MethodParameter(rawValue: 1 << 0)
        static let value = MethodParameter(rawValue: 1 << 1)
        static let value1 = MethodParameter(rawValue: 1 << 2)
        static let value2 = MethodParameter(rawValue: 1 << 3)
        static let value3 = MethodParameter(rawValue: 1 << 4)
        static let value4 = MethodParameter(rawValue: 1 << 5)
        static let url = MethodParameter(rawValue: 1 << 6)
        static let registrationDictionary = MethodParameter(rawValue: 1 << 7)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var defaultName: String?
    private(set) var value: Any?
    private(set) var value1: Int?
    private(set) var value2: Float?
    private(set) var value3: Double?
    private(set) var value4: Bool?
    private(set) var url: URL?
    private(set) var registrationDictionary: [String: Any]?

    // MARK: - Variables to Use as Method Return Values

    var objectForKeyDefaultNameReturnValue: Any?
    var stringForKeyDefaultNameReturnValue: String?
    var arrayForKeyDefaultNameReturnValue: [Any]?
    var dictionaryForKeyDefaultNameReturnValue: [String: Any]?
    var dataForKeyDefaultNameReturnValue: Data?
    var stringArrayForKeyDefaultNameReturnValue: [String]?
    var integerForKeyDefaultNameReturnValue: Int = 0
    var floatForKeyDefaultNameReturnValue: Float = 0
    var doubleForKeyDefaultNameReturnValue: Double = 0
    var boolForKeyDefaultNameReturnValue: Bool = false
    var urlForKeyDefaultNameReturnValue: URL?
    var synchronizeReturnValue: Bool = true

    func reset() {
        calledMethods = []
        assignedParameters = []
        defaultName = nil
        value = nil
        value1 = nil
        value2 = nil
        value3 = nil
        value4 = nil
        url = nil
        registrationDictionary = nil
    }

    // MARK: - Methods for Protocol Conformance

    func object(forKey defaultName: String) -> Any? {
        calledMethods.insert(.objectForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        return objectForKeyDefaultNameReturnValue
    }

    func set(_ value: Any?, forKey defaultName: String) {
        calledMethods.insert(.setValueForKeyDefaultNameCalled)
        self.value = value
        assignedParameters.insert(.value)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
    }

    func removeObject(forKey defaultName: String) {
        calledMethods.insert(.removeObjectForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
    }

    func string(forKey defaultName: String) -> String? {
        calledMethods.insert(.stringForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        return stringForKeyDefaultNameReturnValue
    }

    func array(forKey defaultName: String) -> [Any]? {
        calledMethods.insert(.arrayForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        return arrayForKeyDefaultNameReturnValue
    }

    func dictionary(forKey defaultName: String) -> [String: Any]? {
        calledMethods.insert(.dictionaryForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        return dictionaryForKeyDefaultNameReturnValue
    }

    func data(forKey defaultName: String) -> Data? {
        calledMethods.insert(.dataForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        return dataForKeyDefaultNameReturnValue
    }

    func stringArray(forKey defaultName: String) -> [String]? {
        calledMethods.insert(.stringArrayForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        return stringArrayForKeyDefaultNameReturnValue
    }

    func integer(forKey defaultName: String) -> Int {
        calledMethods.insert(.integerForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        return integerForKeyDefaultNameReturnValue
    }

    func float(forKey defaultName: String) -> Float {
        calledMethods.insert(.floatForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        return floatForKeyDefaultNameReturnValue
    }

    func double(forKey defaultName: String) -> Double {
        calledMethods.insert(.doubleForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        return doubleForKeyDefaultNameReturnValue
    }

    func bool(forKey defaultName: String) -> Bool {
        calledMethods.insert(.boolForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        return boolForKeyDefaultNameReturnValue
    }

    func url(forKey defaultName: String) -> URL? {
        calledMethods.insert(.urlForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        return urlForKeyDefaultNameReturnValue
    }

    func set(_ value: Int, forKey defaultName: String) {
        calledMethods.insert(.setValueForKeyDefaultNameCalled1)
        self.value1 = value
        assignedParameters.insert(.value1)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
    }

    func set(_ value: Float, forKey defaultName: String) {
        calledMethods.insert(.setValueForKeyDefaultNameCalled2)
        self.value2 = value
        assignedParameters.insert(.value2)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
    }

    func set(_ value: Double, forKey defaultName: String) {
        calledMethods.insert(.setValueForKeyDefaultNameCalled3)
        self.value3 = value
        assignedParameters.insert(.value3)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
    }

    func set(_ value: Bool, forKey defaultName: String) {
        calledMethods.insert(.setValueForKeyDefaultNameCalled4)
        self.value4 = value
        assignedParameters.insert(.value4)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
    }

    func set(_ url: URL?, forKey defaultName: String) {
        calledMethods.insert(.setUrlForKeyDefaultNameCalled)
        self.url = url
        assignedParameters.insert(.url)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
    }

    func register(defaults registrationDictionary: [String: Any]) {
        calledMethods.insert(.registerDefaultsRegistrationDictionaryCalled)
        self.registrationDictionary = registrationDictionary
        assignedParameters.insert(.registrationDictionary)
    }

    func synchronize() -> Bool {
        calledMethods.insert(.synchronizeCalled)
        return synchronizeReturnValue
    }

}

extension MockKeyValueStoring.Method: CustomStringConvertible {
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

        if self.contains(.objectForKeyDefaultNameCalled) {
            handleFirst()
            value += ".objectForKeyDefaultNameCalled"
        }
        if self.contains(.setValueForKeyDefaultNameCalled) {
            handleFirst()
            value += ".setValueForKeyDefaultNameCalled"
        }
        if self.contains(.removeObjectForKeyDefaultNameCalled) {
            handleFirst()
            value += ".removeObjectForKeyDefaultNameCalled"
        }
        if self.contains(.stringForKeyDefaultNameCalled) {
            handleFirst()
            value += ".stringForKeyDefaultNameCalled"
        }
        if self.contains(.arrayForKeyDefaultNameCalled) {
            handleFirst()
            value += ".arrayForKeyDefaultNameCalled"
        }
        if self.contains(.dictionaryForKeyDefaultNameCalled) {
            handleFirst()
            value += ".dictionaryForKeyDefaultNameCalled"
        }
        if self.contains(.dataForKeyDefaultNameCalled) {
            handleFirst()
            value += ".dataForKeyDefaultNameCalled"
        }
        if self.contains(.stringArrayForKeyDefaultNameCalled) {
            handleFirst()
            value += ".stringArrayForKeyDefaultNameCalled"
        }
        if self.contains(.integerForKeyDefaultNameCalled) {
            handleFirst()
            value += ".integerForKeyDefaultNameCalled"
        }
        if self.contains(.floatForKeyDefaultNameCalled) {
            handleFirst()
            value += ".floatForKeyDefaultNameCalled"
        }
        if self.contains(.doubleForKeyDefaultNameCalled) {
            handleFirst()
            value += ".doubleForKeyDefaultNameCalled"
        }
        if self.contains(.boolForKeyDefaultNameCalled) {
            handleFirst()
            value += ".boolForKeyDefaultNameCalled"
        }
        if self.contains(.urlForKeyDefaultNameCalled) {
            handleFirst()
            value += ".urlForKeyDefaultNameCalled"
        }
        if self.contains(.setValueForKeyDefaultNameCalled1) {
            handleFirst()
            value += ".setValueForKeyDefaultNameCalled1"
        }
        if self.contains(.setValueForKeyDefaultNameCalled2) {
            handleFirst()
            value += ".setValueForKeyDefaultNameCalled2"
        }
        if self.contains(.setValueForKeyDefaultNameCalled3) {
            handleFirst()
            value += ".setValueForKeyDefaultNameCalled3"
        }
        if self.contains(.setValueForKeyDefaultNameCalled4) {
            handleFirst()
            value += ".setValueForKeyDefaultNameCalled4"
        }
        if self.contains(.setUrlForKeyDefaultNameCalled) {
            handleFirst()
            value += ".setUrlForKeyDefaultNameCalled"
        }
        if self.contains(.registerDefaultsRegistrationDictionaryCalled) {
            handleFirst()
            value += ".registerDefaultsRegistrationDictionaryCalled"
        }
        if self.contains(.synchronizeCalled) {
            handleFirst()
            value += ".synchronizeCalled"
        }

        value += "]"
        return value
    }
}

extension MockKeyValueStoring.MethodParameter: CustomStringConvertible {
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

        if self.contains(.defaultName) {
            handleFirst()
            value += ".defaultName"
        }
        if self.contains(.value) {
            handleFirst()
            value += ".value"
        }
        if self.contains(.value1) {
            handleFirst()
            value += ".value1"
        }
        if self.contains(.value2) {
            handleFirst()
            value += ".value2"
        }
        if self.contains(.value3) {
            handleFirst()
            value += ".value3"
        }
        if self.contains(.value4) {
            handleFirst()
            value += ".value4"
        }
        if self.contains(.url) {
            handleFirst()
            value += ".url"
        }
        if self.contains(.registrationDictionary) {
            handleFirst()
            value += ".registrationDictionary"
        }

        value += "]"
        return value
    }
}
