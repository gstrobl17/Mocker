//swiftlint:disable file_length
//
//  MockUserDefaults.swift
//  MockerTests
//
//  Created by Greg on 2/25/18.
//

import Foundation
@testable import Mocker

class MockUserDefaults: KeyValueStoring {
    
    var store: [String: Any] = [:]
    
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
        static let setIntValueForKeyDefaultNameCalled = Method(rawValue: 1 << 13)
        static let setFloatValueForKeyDefaultNameCalled = Method(rawValue: 1 << 14)
        static let setDoubleValueForKeyDefaultNameCalled = Method(rawValue: 1 << 15)
        static let setBoolValueForKeyDefaultNameCalled = Method(rawValue: 1 << 16)
        static let setUrlForKeyDefaultNameCalled = Method(rawValue: 1 << 17)
        static let registerDefaultsRegistrationDictionaryCalled = Method(rawValue: 1 << 18)
        static let synchronizeCalled = Method(rawValue: 1 << 19)
    }
    private(set) var calledMethods = Method()
    
    struct MethodParameter: OptionSet {
        let rawValue: UInt
        static let defaultName = MethodParameter(rawValue: 1 << 0)
        static let value = MethodParameter(rawValue: 1 << 1)
        static let intValue = MethodParameter(rawValue: 1 << 2)
        static let floatValue = MethodParameter(rawValue: 1 << 3)
        static let doubleValue = MethodParameter(rawValue: 1 << 4)
        static let boolValue = MethodParameter(rawValue: 1 << 5)
        static let url = MethodParameter(rawValue: 1 << 6)
        static let registrationDictionary = MethodParameter(rawValue: 1 << 7)
    }
    private(set) var assignedParameters = MethodParameter()
    
    // MARK: - Variables for Captured Parameter Values
    
    private(set) var defaultName: String?
    private(set) var value: Any?
    private(set) var intValue: Int?
    private(set) var floatValue: Float?
    private(set) var doubleValue: Double?
    private(set) var boolValue: Bool?
    private(set) var url: URL?
    private(set) var registrationDictionary: [String: Any]?
    
    private(set) var defaultNames = [String]()
    private(set) var values = [Any]()

    // MARK: - Variables to Use as Method Return Values
    
    var synchronizeReturnValue = false
    
    func reset() {
        calledMethods = []
        assignedParameters = []
        defaultName = nil
        value = nil
        intValue = nil
        floatValue = nil
        doubleValue = nil
        boolValue = nil
        url = nil
        registrationDictionary = nil
        defaultNames = []
        values = []
    }
    
    // MARK: - Methods for Protocol Conformance
    
    func object(forKey defaultName: String) -> Any? {
        calledMethods.insert(.objectForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        return store[defaultName]
    }
    
    func set(_ value: Any?, forKey defaultName: String) {
        calledMethods.insert(.setValueForKeyDefaultNameCalled)
        self.value = value
        assignedParameters.insert(.value)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        values.append(value ?? NSNull())
        store[defaultName] = value
    }
    
    func removeObject(forKey defaultName: String) {
        calledMethods.insert(.removeObjectForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        store[defaultName] = nil
    }
    
    func string(forKey defaultName: String) -> String? {
        calledMethods.insert(.stringForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        guard let value = store[defaultName] as? String else { return nil }
        return value
    }
    
    func array(forKey defaultName: String) -> [Any]? {
        calledMethods.insert(.arrayForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        guard let value = store[defaultName] as? [Any] else { return nil }
        return value
    }
    
    func dictionary(forKey defaultName: String) -> [String: Any]? {
        calledMethods.insert(.dictionaryForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        guard let value = store[defaultName] as? [String: Any] else { return nil }
        return value
    }
    
    func data(forKey defaultName: String) -> Data? {
        calledMethods.insert(.dataForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        guard let value = store[defaultName] as? Data else { return nil }
        return value
    }
    
    func stringArray(forKey defaultName: String) -> [String]? {
        calledMethods.insert(.stringArrayForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        guard let value = store[defaultName] as? [String] else { return nil }
        return value
    }
    
    func integer(forKey defaultName: String) -> Int {
        calledMethods.insert(.integerForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        guard let value = store[defaultName] as? Int else { return 0 }
        return value
    }
    
    func float(forKey defaultName: String) -> Float {
        calledMethods.insert(.floatForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        guard let value = store[defaultName] as? Float else { return 0 }
        return value
    }
    
    func double(forKey defaultName: String) -> Double {
        calledMethods.insert(.doubleForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        guard let value = store[defaultName] as? Double else { return 0 }
        return value
    }
    
    func bool(forKey defaultName: String) -> Bool {
        calledMethods.insert(.boolForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        guard let value = store[defaultName] as? Bool else { return false }
        return value
    }
    
    func url(forKey defaultName: String) -> URL? {
        calledMethods.insert(.urlForKeyDefaultNameCalled)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        guard let value = store[defaultName] as? URL else { return nil }
        return value
    }
    
    func set(_ value: Int, forKey defaultName: String) {
        calledMethods.insert(.setIntValueForKeyDefaultNameCalled)
        self.intValue = value
        assignedParameters.insert(.intValue)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        values.append(value)
        store[defaultName] = value
    }
    
    func set(_ value: Float, forKey defaultName: String) {
        calledMethods.insert(.setFloatValueForKeyDefaultNameCalled)
        self.floatValue = value
        assignedParameters.insert(.floatValue)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        values.append(value)
        store[defaultName] = value
    }
    
    func set(_ value: Double, forKey defaultName: String) {
        calledMethods.insert(.setDoubleValueForKeyDefaultNameCalled)
        self.doubleValue = value
        assignedParameters.insert(.doubleValue)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        values.append(value)
        store[defaultName] = value
    }
    
    func set(_ value: Bool, forKey defaultName: String) {
        calledMethods.insert(.setBoolValueForKeyDefaultNameCalled)
        self.boolValue = value
        assignedParameters.insert(.boolValue)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        values.append(value)
        store[defaultName] = value
    }
    
    func set(_ url: URL?, forKey defaultName: String) {
        calledMethods.insert(.setUrlForKeyDefaultNameCalled)
        self.url = url
        assignedParameters.insert(.url)
        self.defaultName = defaultName
        assignedParameters.insert(.defaultName)
        defaultNames.append(defaultName)
        values.append(url ?? NSNull())
        store[defaultName] = url
    }
    
    func register(defaults registrationDictionary: [String: Any]) {
        calledMethods.insert(.registerDefaultsRegistrationDictionaryCalled)
        self.registrationDictionary = registrationDictionary
        assignedParameters.insert(.registrationDictionary)
        for (key, value) in registrationDictionary {
            set(value, forKey: key)
        }
    }
    
    func synchronize() -> Bool {
        calledMethods.insert(.synchronizeCalled)
        return synchronizeReturnValue
    }
    
}

extension MockUserDefaults.Method: CustomStringConvertible {
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
        if self.contains(.setIntValueForKeyDefaultNameCalled) {
            handleFirst()
            value += ".setIntValueForKeyDefaultNameCalled"
        }
        if self.contains(.setFloatValueForKeyDefaultNameCalled) {
            handleFirst()
            value += ".setFloatValueForKeyDefaultNameCalled"
        }
        if self.contains(.setDoubleValueForKeyDefaultNameCalled) {
            handleFirst()
            value += ".setDoubleValueForKeyDefaultNameCalled"
        }
        if self.contains(.setBoolValueForKeyDefaultNameCalled) {
            handleFirst()
            value += ".setBoolValueForKeyDefaultNameCalled"
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

extension MockUserDefaults.MethodParameter: CustomStringConvertible {
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
        if self.contains(.intValue) {
            handleFirst()
            value += ".intValue"
        }
        if self.contains(.floatValue) {
            handleFirst()
            value += ".floatValue"
        }
        if self.contains(.doubleValue) {
            handleFirst()
            value += ".doubleValue"
        }
        if self.contains(.boolValue) {
            handleFirst()
            value += ".boolValue"
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

extension MockUserDefaults: CustomReflectable {
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
//swiftlint:enable file_length
