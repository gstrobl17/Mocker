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
    private(set) public var synchronizeCalled = false
    
    func reset() {
        store = [:]
        synchronizeCalled = false
    }
    
    func object(forKey defaultName: String) -> Any? {
        store[defaultName]
    }
    
    func set(_ value: Any?, forKey defaultName: String) {
        store[defaultName] = value
    }
    
    func removeObject(forKey defaultName: String) {
        store[defaultName] = nil
    }
    
    func string(forKey defaultName: String) -> String? {
        guard let value = store[defaultName] as? String else {
            return nil
            
        }
        return value
    }
    
    func array(forKey defaultName: String) -> [Any]? {
        guard let value = store[defaultName] as? [Any] else {
            return nil
        }
        return value
    }
    
    func dictionary(forKey defaultName: String) -> [String: Any]? {
        guard let value = store[defaultName] as? [String: Any] else {
            return nil
        }
        return value
    }
    
    func data(forKey defaultName: String) -> Data? {
        guard let value = store[defaultName] as? Data else {
            return nil
        }
        return value
    }
    
    func stringArray(forKey defaultName: String) -> [String]? {
        guard let value = store[defaultName] as? [String] else {
            return nil
        }
        return value
    }
    
    func integer(forKey defaultName: String) -> Int {
        guard let value = store[defaultName] as? Int else {
            return 0
        }
        return value
    }
    
    func float(forKey defaultName: String) -> Float {
        guard let value = store[defaultName] as? Float else {
            return 0
        }
        return value
    }
    
    func double(forKey defaultName: String) -> Double {
        guard let value = store[defaultName] as? Double else {
            return 0
        }
        return value
    }
    
    func bool(forKey defaultName: String) -> Bool {
        guard let value = store[defaultName] as? Bool else {
            return false
        }
        return value
    }
    
    func url(forKey defaultName: String) -> URL? {
        guard let value = store[defaultName] as? URL else {
            return nil
        }
        return value
    }
    
    func set(_ value: Int, forKey defaultName: String) {
        store[defaultName] = value
    }
    
    func set(_ value: Float, forKey defaultName: String) {
        store[defaultName] = value
    }
    
    func set(_ value: Double, forKey defaultName: String) {
        store[defaultName] = value
    }
    
    func set(_ value: Bool, forKey defaultName: String) {
        store[defaultName] = value
    }
    
    func set(_ url: URL?, forKey defaultName: String) {
        store[defaultName] = url
    }
    
    func register(defaults registrationDictionary: [String: Any]) {
        for (key, value) in registrationDictionary {
            set(value, forKey: key)
        }
    }
    
    func synchronize() -> Bool {
        synchronizeCalled = true
        return true
    }
}

