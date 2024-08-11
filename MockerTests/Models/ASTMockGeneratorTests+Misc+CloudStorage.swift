//TODO: evaluate any change and rework to use constants
//swiftlint:disable function_body_length file_length
//
//  ASTMockGeneratorTests+Misc+CloudStorage.swift
//  MockerTests
//
//  Created by Greg Strobl on 1/25/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import XCTest
import SwiftSyntax

extension ASTMockGeneratorTests {
    
    var cloudStorageProtocol: String {
        """
        protocol CloudStorage {
            func object(forKey aKey: String) -> Any?
            func set(_ anObject: Any?, forKey aKey: String)
            func removeObject(forKey aKey: String)
            func data(forKey aKey: String) -> Data?
            func set(_ aData: Data?, forKey aKey: String)
            func synchronize() -> Bool
        }
        """
    }
    
    func testCodeGeneration_cloudStorageProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: cloudStorageProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //
                           
                           @testable import Mocker
                           import Foundation
                           import UIKit
                           import Core

                           class MockTest: CloudStorage {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let objectForKeyAKeyCalled = Method(rawValue: 1 << 0)
                                   static let setAnObjectForKeyAKeyCalled = Method(rawValue: 1 << 1)
                                   static let removeObjectForKeyAKeyCalled = Method(rawValue: 1 << 2)
                                   static let dataForKeyAKeyCalled = Method(rawValue: 1 << 3)
                                   static let setADataForKeyAKeyCalled = Method(rawValue: 1 << 4)
                                   static let synchronizeCalled = Method(rawValue: 1 << 5)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let aKey = MethodParameter(rawValue: 1 << 0)
                                   static let anObject = MethodParameter(rawValue: 1 << 1)
                                   static let aData = MethodParameter(rawValue: 1 << 2)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var aKey: String?
                               private(set) var anObject: Any?
                               private(set) var aData: Data?

                               // MARK: - Variables to Use as Method Return Values

                               var objectForKeyAKeyReturnValue: Any?
                               var dataForKeyAKeyReturnValue: Data?
                               var synchronizeReturnValue: Bool!


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   aKey = nil
                                   anObject = nil
                                   aData = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func object(forKey aKey: String) -> Any? {
                                   calledMethods.insert(.objectForKeyAKeyCalled)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
                                   return objectForKeyAKeyReturnValue
                               }

                               func set(_ anObject: Any?, forKey aKey: String) {
                                   calledMethods.insert(.setAnObjectForKeyAKeyCalled)
                                   self.anObject = anObject
                                   assignedParameters.insert(.anObject)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
                               }

                               func removeObject(forKey aKey: String) {
                                   calledMethods.insert(.removeObjectForKeyAKeyCalled)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
                               }

                               func data(forKey aKey: String) -> Data? {
                                   calledMethods.insert(.dataForKeyAKeyCalled)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
                                   return dataForKeyAKeyReturnValue
                               }

                               func set(_ aData: Data?, forKey aKey: String) {
                                   calledMethods.insert(.setADataForKeyAKeyCalled)
                                   self.aData = aData
                                   assignedParameters.insert(.aData)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
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

                                   if self.contains(.objectForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".objectForKeyAKeyCalled"
                                   }
                                   if self.contains(.setAnObjectForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".setAnObjectForKeyAKeyCalled"
                                   }
                                   if self.contains(.removeObjectForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".removeObjectForKeyAKeyCalled"
                                   }
                                   if self.contains(.dataForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".dataForKeyAKeyCalled"
                                   }
                                   if self.contains(.setADataForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".setADataForKeyAKeyCalled"
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

                                   if self.contains(.aKey) {
                                       handleFirst()
                                       value += ".aKey"
                                   }
                                   if self.contains(.anObject) {
                                       handleFirst()
                                       value += ".anObject"
                                   }
                                   if self.contains(.aData) {
                                       handleFirst()
                                       value += ".aData"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           extension MockTest: CustomReflectable {
                               var customMirror: Mirror {
                                   Mirror(self,
                                          children: [
                                           "calledMethods": calledMethods,
                                           "assignedParameters": assignedParameters,
                                          ],
                                          displayStyle: .none
                                   )
                               }
                           }

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_cloudStorageProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: cloudStorageProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //
                           
                           @testable import Mocker
                           import Foundation
                           import UIKit
                           import Core

                           public class MockTest: CloudStorage {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let objectForKeyAKeyCalled = Method(rawValue: 1 << 0)
                                   public static let setAnObjectForKeyAKeyCalled = Method(rawValue: 1 << 1)
                                   public static let removeObjectForKeyAKeyCalled = Method(rawValue: 1 << 2)
                                   public static let dataForKeyAKeyCalled = Method(rawValue: 1 << 3)
                                   public static let setADataForKeyAKeyCalled = Method(rawValue: 1 << 4)
                                   public static let synchronizeCalled = Method(rawValue: 1 << 5)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let aKey = MethodParameter(rawValue: 1 << 0)
                                   public static let anObject = MethodParameter(rawValue: 1 << 1)
                                   public static let aData = MethodParameter(rawValue: 1 << 2)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var aKey: String?
                               private(set) public var anObject: Any?
                               private(set) public var aData: Data?

                               // MARK: - Variables to Use as Method Return Values

                               public var objectForKeyAKeyReturnValue: Any?
                               public var dataForKeyAKeyReturnValue: Data?
                               public var synchronizeReturnValue: Bool!


                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   aKey = nil
                                   anObject = nil
                                   aData = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func object(forKey aKey: String) -> Any? {
                                   calledMethods.insert(.objectForKeyAKeyCalled)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
                                   return objectForKeyAKeyReturnValue
                               }

                               public func set(_ anObject: Any?, forKey aKey: String) {
                                   calledMethods.insert(.setAnObjectForKeyAKeyCalled)
                                   self.anObject = anObject
                                   assignedParameters.insert(.anObject)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
                               }

                               public func removeObject(forKey aKey: String) {
                                   calledMethods.insert(.removeObjectForKeyAKeyCalled)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
                               }

                               public func data(forKey aKey: String) -> Data? {
                                   calledMethods.insert(.dataForKeyAKeyCalled)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
                                   return dataForKeyAKeyReturnValue
                               }

                               public func set(_ aData: Data?, forKey aKey: String) {
                                   calledMethods.insert(.setADataForKeyAKeyCalled)
                                   self.aData = aData
                                   assignedParameters.insert(.aData)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
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

                                   if self.contains(.objectForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".objectForKeyAKeyCalled"
                                   }
                                   if self.contains(.setAnObjectForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".setAnObjectForKeyAKeyCalled"
                                   }
                                   if self.contains(.removeObjectForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".removeObjectForKeyAKeyCalled"
                                   }
                                   if self.contains(.dataForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".dataForKeyAKeyCalled"
                                   }
                                   if self.contains(.setADataForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".setADataForKeyAKeyCalled"
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

                                   if self.contains(.aKey) {
                                       handleFirst()
                                       value += ".aKey"
                                   }
                                   if self.contains(.anObject) {
                                       handleFirst()
                                       value += ".anObject"
                                   }
                                   if self.contains(.aData) {
                                       handleFirst()
                                       value += ".aData"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           extension MockTest: CustomReflectable {
                               public var customMirror: Mirror {
                                   Mirror(self,
                                          children: [
                                           "calledMethods": calledMethods,
                                           "assignedParameters": assignedParameters,
                                          ],
                                          displayStyle: .none
                                   )
                               }
                           }

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_cloudStorageProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: cloudStorageProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: true)
        createGenerator(swiftlintAware: true)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //
                           
                           @testable import Mocker
                           import Foundation
                           import UIKit
                           import Core

                           class MockTest: CloudStorage {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let objectForKeyAKeyCalled = Method(rawValue: 1 << 0)
                                   static let setAnObjectForKeyAKeyCalled = Method(rawValue: 1 << 1)
                                   static let removeObjectForKeyAKeyCalled = Method(rawValue: 1 << 2)
                                   static let dataForKeyAKeyCalled = Method(rawValue: 1 << 3)
                                   static let setADataForKeyAKeyCalled = Method(rawValue: 1 << 4)
                                   static let synchronizeCalled = Method(rawValue: 1 << 5)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let aKey = MethodParameter(rawValue: 1 << 0)
                                   static let anObject = MethodParameter(rawValue: 1 << 1)
                                   static let aData = MethodParameter(rawValue: 1 << 2)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var aKey: String?
                               private(set) var anObject: Any?
                               private(set) var aData: Data?

                               // MARK: - Variables to Use as Method Return Values

                               //swiftlint:disable implicitly_unwrapped_optional
                               var objectForKeyAKeyReturnValue: Any?
                               var dataForKeyAKeyReturnValue: Data?
                               var synchronizeReturnValue: Bool!
                               //swiftlint:enable implicitly_unwrapped_optional


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   aKey = nil
                                   anObject = nil
                                   aData = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func object(forKey aKey: String) -> Any? {
                                   calledMethods.insert(.objectForKeyAKeyCalled)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
                                   return objectForKeyAKeyReturnValue
                               }

                               func set(_ anObject: Any?, forKey aKey: String) {
                                   calledMethods.insert(.setAnObjectForKeyAKeyCalled)
                                   self.anObject = anObject
                                   assignedParameters.insert(.anObject)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
                               }

                               func removeObject(forKey aKey: String) {
                                   calledMethods.insert(.removeObjectForKeyAKeyCalled)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
                               }

                               func data(forKey aKey: String) -> Data? {
                                   calledMethods.insert(.dataForKeyAKeyCalled)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
                                   return dataForKeyAKeyReturnValue
                               }

                               func set(_ aData: Data?, forKey aKey: String) {
                                   calledMethods.insert(.setADataForKeyAKeyCalled)
                                   self.aData = aData
                                   assignedParameters.insert(.aData)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
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

                                   if self.contains(.objectForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".objectForKeyAKeyCalled"
                                   }
                                   if self.contains(.setAnObjectForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".setAnObjectForKeyAKeyCalled"
                                   }
                                   if self.contains(.removeObjectForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".removeObjectForKeyAKeyCalled"
                                   }
                                   if self.contains(.dataForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".dataForKeyAKeyCalled"
                                   }
                                   if self.contains(.setADataForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".setADataForKeyAKeyCalled"
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

                                   if self.contains(.aKey) {
                                       handleFirst()
                                       value += ".aKey"
                                   }
                                   if self.contains(.anObject) {
                                       handleFirst()
                                       value += ".anObject"
                                   }
                                   if self.contains(.aData) {
                                       handleFirst()
                                       value += ".aData"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           extension MockTest: CustomReflectable {
                               var customMirror: Mirror {
                                   Mirror(self,
                                          children: [
                                           "calledMethods": calledMethods,
                                           "assignedParameters": assignedParameters,
                                          ],
                                          displayStyle: .none
                                   )
                               }
                           }

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_cloudStorageProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: cloudStorageProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: true, public: true)
        createGenerator(swiftlintAware: true)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //
                           
                           @testable import Mocker
                           import Foundation
                           import UIKit
                           import Core

                           public class MockTest: CloudStorage {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let objectForKeyAKeyCalled = Method(rawValue: 1 << 0)
                                   public static let setAnObjectForKeyAKeyCalled = Method(rawValue: 1 << 1)
                                   public static let removeObjectForKeyAKeyCalled = Method(rawValue: 1 << 2)
                                   public static let dataForKeyAKeyCalled = Method(rawValue: 1 << 3)
                                   public static let setADataForKeyAKeyCalled = Method(rawValue: 1 << 4)
                                   public static let synchronizeCalled = Method(rawValue: 1 << 5)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let aKey = MethodParameter(rawValue: 1 << 0)
                                   public static let anObject = MethodParameter(rawValue: 1 << 1)
                                   public static let aData = MethodParameter(rawValue: 1 << 2)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var aKey: String?
                               private(set) public var anObject: Any?
                               private(set) public var aData: Data?

                               // MARK: - Variables to Use as Method Return Values

                               //swiftlint:disable implicitly_unwrapped_optional
                               public var objectForKeyAKeyReturnValue: Any?
                               public var dataForKeyAKeyReturnValue: Data?
                               public var synchronizeReturnValue: Bool!
                               //swiftlint:enable implicitly_unwrapped_optional


                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   aKey = nil
                                   anObject = nil
                                   aData = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func object(forKey aKey: String) -> Any? {
                                   calledMethods.insert(.objectForKeyAKeyCalled)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
                                   return objectForKeyAKeyReturnValue
                               }

                               public func set(_ anObject: Any?, forKey aKey: String) {
                                   calledMethods.insert(.setAnObjectForKeyAKeyCalled)
                                   self.anObject = anObject
                                   assignedParameters.insert(.anObject)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
                               }

                               public func removeObject(forKey aKey: String) {
                                   calledMethods.insert(.removeObjectForKeyAKeyCalled)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
                               }

                               public func data(forKey aKey: String) -> Data? {
                                   calledMethods.insert(.dataForKeyAKeyCalled)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
                                   return dataForKeyAKeyReturnValue
                               }

                               public func set(_ aData: Data?, forKey aKey: String) {
                                   calledMethods.insert(.setADataForKeyAKeyCalled)
                                   self.aData = aData
                                   assignedParameters.insert(.aData)
                                   self.aKey = aKey
                                   assignedParameters.insert(.aKey)
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

                                   if self.contains(.objectForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".objectForKeyAKeyCalled"
                                   }
                                   if self.contains(.setAnObjectForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".setAnObjectForKeyAKeyCalled"
                                   }
                                   if self.contains(.removeObjectForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".removeObjectForKeyAKeyCalled"
                                   }
                                   if self.contains(.dataForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".dataForKeyAKeyCalled"
                                   }
                                   if self.contains(.setADataForKeyAKeyCalled) {
                                       handleFirst()
                                       value += ".setADataForKeyAKeyCalled"
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

                                   if self.contains(.aKey) {
                                       handleFirst()
                                       value += ".aKey"
                                   }
                                   if self.contains(.anObject) {
                                       handleFirst()
                                       value += ".anObject"
                                   }
                                   if self.contains(.aData) {
                                       handleFirst()
                                       value += ".aData"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           extension MockTest: CustomReflectable {
                               public var customMirror: Mirror {
                                   Mirror(self,
                                          children: [
                                           "calledMethods": calledMethods,
                                           "assignedParameters": assignedParameters,
                                          ],
                                          displayStyle: .none
                                   )
                               }
                           }

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
}
//swiftlint:enable function_body_length file_length
