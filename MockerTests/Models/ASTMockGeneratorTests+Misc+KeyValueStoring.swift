//swiftlint:disable function_body_length file_length
//
//  ASTMockGeneratorTests+Misc+KeyValueStoring.swift
//  MockerTests
//
//  Created by Greg Strobl on 1/25/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import XCTest
import SwiftSyntax

extension ASTMockGeneratorTests {
    
    var keyValueStoringProtocol: String {
        """
        protocol KeyValueStoring {
            func object(forKey defaultName: String) -> Any?
            func set(_ value: Any?, forKey defaultName: String)
            func removeObject(forKey defaultName: String)
            func string(forKey defaultName: String) -> String?
            func array(forKey defaultName: String) -> [Any]?
            func dictionary(forKey defaultName: String) -> [String: Any]?
            func data(forKey defaultName: String) -> Data?
            func stringArray(forKey defaultName: String) -> [String]?
            func integer(forKey defaultName: String) -> Int
            func float(forKey defaultName: String) -> Float
            func double(forKey defaultName: String) -> Double
            func bool(forKey defaultName: String) -> Bool
            func url(forKey defaultName: String) -> URL?
            func set(_ value: Int, forKey defaultName: String)
            func set(_ value: Float, forKey defaultName: String)
            func set(_ value: Double, forKey defaultName: String)
            func set(_ value: Bool, forKey defaultName: String)
            func set(_ url: URL?, forKey defaultName: String)
            func register(defaults registrationDictionary: [String: Any])
            func synchronize() -> Bool
        }
        """
    }
    
    func testCodeGeneration_keyValueStoringProtocol_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: keyValueStoringProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           class MockTest: KeyValueStoring {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
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

                               struct MethodParameter: OptionSet, Sendable {
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
                               var integerForKeyDefaultNameReturnValue: Int!
                               var floatForKeyDefaultNameReturnValue: Float!
                               var doubleForKeyDefaultNameReturnValue: Double!
                               var boolForKeyDefaultNameReturnValue: Bool!
                               var urlForKeyDefaultNameReturnValue: URL?
                               var synchronizeReturnValue: Bool!


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

                           extension MockTest.Method: CustomStringConvertible {
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

                           extension MockTest.MethodParameter: CustomStringConvertible {
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

                           \(expectedCustomReflectableWithCalledMethodsAndAssignedParameters)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_keyValueStoringProtocol_trackPropertyActivityFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: keyValueStoringProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public class MockTest: KeyValueStoring {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let objectForKeyDefaultNameCalled = Method(rawValue: 1 << 0)
                                   public static let setValueForKeyDefaultNameCalled = Method(rawValue: 1 << 1)
                                   public static let removeObjectForKeyDefaultNameCalled = Method(rawValue: 1 << 2)
                                   public static let stringForKeyDefaultNameCalled = Method(rawValue: 1 << 3)
                                   public static let arrayForKeyDefaultNameCalled = Method(rawValue: 1 << 4)
                                   public static let dictionaryForKeyDefaultNameCalled = Method(rawValue: 1 << 5)
                                   public static let dataForKeyDefaultNameCalled = Method(rawValue: 1 << 6)
                                   public static let stringArrayForKeyDefaultNameCalled = Method(rawValue: 1 << 7)
                                   public static let integerForKeyDefaultNameCalled = Method(rawValue: 1 << 8)
                                   public static let floatForKeyDefaultNameCalled = Method(rawValue: 1 << 9)
                                   public static let doubleForKeyDefaultNameCalled = Method(rawValue: 1 << 10)
                                   public static let boolForKeyDefaultNameCalled = Method(rawValue: 1 << 11)
                                   public static let urlForKeyDefaultNameCalled = Method(rawValue: 1 << 12)
                                   public static let setValueForKeyDefaultNameCalled1 = Method(rawValue: 1 << 13)
                                   public static let setValueForKeyDefaultNameCalled2 = Method(rawValue: 1 << 14)
                                   public static let setValueForKeyDefaultNameCalled3 = Method(rawValue: 1 << 15)
                                   public static let setValueForKeyDefaultNameCalled4 = Method(rawValue: 1 << 16)
                                   public static let setUrlForKeyDefaultNameCalled = Method(rawValue: 1 << 17)
                                   public static let registerDefaultsRegistrationDictionaryCalled = Method(rawValue: 1 << 18)
                                   public static let synchronizeCalled = Method(rawValue: 1 << 19)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let defaultName = MethodParameter(rawValue: 1 << 0)
                                   public static let value = MethodParameter(rawValue: 1 << 1)
                                   public static let value1 = MethodParameter(rawValue: 1 << 2)
                                   public static let value2 = MethodParameter(rawValue: 1 << 3)
                                   public static let value3 = MethodParameter(rawValue: 1 << 4)
                                   public static let value4 = MethodParameter(rawValue: 1 << 5)
                                   public static let url = MethodParameter(rawValue: 1 << 6)
                                   public static let registrationDictionary = MethodParameter(rawValue: 1 << 7)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var defaultName: String?
                               private(set) public var value: Any?
                               private(set) public var value1: Int?
                               private(set) public var value2: Float?
                               private(set) public var value3: Double?
                               private(set) public var value4: Bool?
                               private(set) public var url: URL?
                               private(set) public var registrationDictionary: [String: Any]?

                               // MARK: - Variables to Use as Method Return Values

                               public var objectForKeyDefaultNameReturnValue: Any?
                               public var stringForKeyDefaultNameReturnValue: String?
                               public var arrayForKeyDefaultNameReturnValue: [Any]?
                               public var dictionaryForKeyDefaultNameReturnValue: [String: Any]?
                               public var dataForKeyDefaultNameReturnValue: Data?
                               public var stringArrayForKeyDefaultNameReturnValue: [String]?
                               public var integerForKeyDefaultNameReturnValue: Int!
                               public var floatForKeyDefaultNameReturnValue: Float!
                               public var doubleForKeyDefaultNameReturnValue: Double!
                               public var boolForKeyDefaultNameReturnValue: Bool!
                               public var urlForKeyDefaultNameReturnValue: URL?
                               public var synchronizeReturnValue: Bool!


                               public func reset() {
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

                               public func object(forKey defaultName: String) -> Any? {
                                   calledMethods.insert(.objectForKeyDefaultNameCalled)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                                   return objectForKeyDefaultNameReturnValue
                               }

                               public func set(_ value: Any?, forKey defaultName: String) {
                                   calledMethods.insert(.setValueForKeyDefaultNameCalled)
                                   self.value = value
                                   assignedParameters.insert(.value)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                               }

                               public func removeObject(forKey defaultName: String) {
                                   calledMethods.insert(.removeObjectForKeyDefaultNameCalled)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                               }

                               public func string(forKey defaultName: String) -> String? {
                                   calledMethods.insert(.stringForKeyDefaultNameCalled)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                                   return stringForKeyDefaultNameReturnValue
                               }

                               public func array(forKey defaultName: String) -> [Any]? {
                                   calledMethods.insert(.arrayForKeyDefaultNameCalled)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                                   return arrayForKeyDefaultNameReturnValue
                               }

                               public func dictionary(forKey defaultName: String) -> [String: Any]? {
                                   calledMethods.insert(.dictionaryForKeyDefaultNameCalled)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                                   return dictionaryForKeyDefaultNameReturnValue
                               }

                               public func data(forKey defaultName: String) -> Data? {
                                   calledMethods.insert(.dataForKeyDefaultNameCalled)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                                   return dataForKeyDefaultNameReturnValue
                               }

                               public func stringArray(forKey defaultName: String) -> [String]? {
                                   calledMethods.insert(.stringArrayForKeyDefaultNameCalled)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                                   return stringArrayForKeyDefaultNameReturnValue
                               }

                               public func integer(forKey defaultName: String) -> Int {
                                   calledMethods.insert(.integerForKeyDefaultNameCalled)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                                   return integerForKeyDefaultNameReturnValue
                               }

                               public func float(forKey defaultName: String) -> Float {
                                   calledMethods.insert(.floatForKeyDefaultNameCalled)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                                   return floatForKeyDefaultNameReturnValue
                               }

                               public func double(forKey defaultName: String) -> Double {
                                   calledMethods.insert(.doubleForKeyDefaultNameCalled)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                                   return doubleForKeyDefaultNameReturnValue
                               }

                               public func bool(forKey defaultName: String) -> Bool {
                                   calledMethods.insert(.boolForKeyDefaultNameCalled)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                                   return boolForKeyDefaultNameReturnValue
                               }

                               public func url(forKey defaultName: String) -> URL? {
                                   calledMethods.insert(.urlForKeyDefaultNameCalled)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                                   return urlForKeyDefaultNameReturnValue
                               }

                               public func set(_ value: Int, forKey defaultName: String) {
                                   calledMethods.insert(.setValueForKeyDefaultNameCalled1)
                                   self.value1 = value
                                   assignedParameters.insert(.value1)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                               }

                               public func set(_ value: Float, forKey defaultName: String) {
                                   calledMethods.insert(.setValueForKeyDefaultNameCalled2)
                                   self.value2 = value
                                   assignedParameters.insert(.value2)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                               }

                               public func set(_ value: Double, forKey defaultName: String) {
                                   calledMethods.insert(.setValueForKeyDefaultNameCalled3)
                                   self.value3 = value
                                   assignedParameters.insert(.value3)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                               }

                               public func set(_ value: Bool, forKey defaultName: String) {
                                   calledMethods.insert(.setValueForKeyDefaultNameCalled4)
                                   self.value4 = value
                                   assignedParameters.insert(.value4)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                               }

                               public func set(_ url: URL?, forKey defaultName: String) {
                                   calledMethods.insert(.setUrlForKeyDefaultNameCalled)
                                   self.url = url
                                   assignedParameters.insert(.url)
                                   self.defaultName = defaultName
                                   assignedParameters.insert(.defaultName)
                               }

                               public func register(defaults registrationDictionary: [String: Any]) {
                                   calledMethods.insert(.registerDefaultsRegistrationDictionaryCalled)
                                   self.registrationDictionary = registrationDictionary
                                   assignedParameters.insert(.registrationDictionary)
                               }

                               public func synchronize() -> Bool {
                                   calledMethods.insert(.synchronizeCalled)
                                   return synchronizeReturnValue
                               }

                           }

                           extension MockTest.Method: CustomStringConvertible {
                               public var description: String {
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

                           extension MockTest.MethodParameter: CustomStringConvertible {
                               public var description: String {
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

                           \(expectedPublicCustomReflectableWithCalledMethodsAndAssignedParameters)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
}
//swiftlint:enable function_body_length file_length
