//swiftlint:disable function_body_length
//
//  ASTMockGeneratorTests+Misc+ActorProtocol.swift
//  Mocker
//
//  Created by Greg Strobl on 1/19/25.
//  Copyright © 2025 Goodman Productions. All rights reserved.
//

@testable import Mocker
import XCTest
import SwiftSyntax

extension ASTMockGeneratorTests {
    
    //NOTE: setters don't work on actors (you must create a set function) so { set } is ignored
    var actorProtocol: String {
        """
        protocol ValueManaging: Actor {
            var interval: Int { get set }
            var window: Int { get }
        
            func setInterval(_ value: Int)
            func setWindow(_ value: Int)
        
            func doSomethingSpecial() -> String
            func doSomethingLessSpecial(_ value: Int) -> (any Logger)?
        }
        """
    }
    
    func testCodeGeneration_actorProtocol_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: actorProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           actor MockTest: ValueManaging {

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get the properties without registering a method call

                               var _interval: Int
                               var _window: Int

                               // Use these methods to set the properties without registering a method call
                           
                               func set_interval(_ value: Int) { _interval = value }
                               func set_window(_ value: Int) { _window = value }

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let intervalGetterCalled = Method(rawValue: 1 << 0)
                                   static let windowGetterCalled = Method(rawValue: 1 << 1)
                                   static let setIntervalValueCalled = Method(rawValue: 1 << 2)
                                   static let setWindowValueCalled = Method(rawValue: 1 << 3)
                                   static let doSomethingSpecialCalled = Method(rawValue: 1 << 4)
                                   static let doSomethingLessSpecialValueCalled = Method(rawValue: 1 << 5)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let value = MethodParameter(rawValue: 1 << 0)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var value: Int?

                               // MARK: - Variables to Use as Method Return Values

                               var doSomethingSpecialReturnValue: String!
                               var doSomethingLessSpecialValueReturnValue: (any Logger)?

                               func setDoSomethingSpecialReturnValue(_ value: String) { doSomethingSpecialReturnValue = value }
                               func setDoSomethingLessSpecialValueReturnValue(_ value: (any Logger)?) { doSomethingLessSpecialValueReturnValue = value }

                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   value = nil
                               }

                               // MARK: - Properties for Protocol Conformance

                               var interval: Int {
                                   calledMethods.insert(.intervalGetterCalled)
                                   return _interval
                               }

                               var window: Int {
                                   calledMethods.insert(.windowGetterCalled)
                                   return _window
                               }

                               // MARK: - Methods for Protocol Conformance

                               func setInterval(_ value: Int) {
                                   calledMethods.insert(.setIntervalValueCalled)
                                   self.value = value
                                   assignedParameters.insert(.value)
                               }

                               func setWindow(_ value: Int) {
                                   calledMethods.insert(.setWindowValueCalled)
                                   self.value = value
                                   assignedParameters.insert(.value)
                               }

                               func doSomethingSpecial() -> String {
                                   calledMethods.insert(.doSomethingSpecialCalled)
                                   return doSomethingSpecialReturnValue
                               }

                               func doSomethingLessSpecial(_ value: Int) -> (any Logger)? {
                                   calledMethods.insert(.doSomethingLessSpecialValueCalled)
                                   self.value = value
                                   assignedParameters.insert(.value)
                                   return doSomethingLessSpecialValueReturnValue
                               }

                               // Parameter used by MacrosForStroblMocks to detect an actor
                               let isMockActor = true
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

                                   if self.contains(.intervalGetterCalled) {
                                       handleFirst()
                                       value += ".intervalGetterCalled"
                                   }
                                   if self.contains(.windowGetterCalled) {
                                       handleFirst()
                                       value += ".windowGetterCalled"
                                   }
                                   if self.contains(.setIntervalValueCalled) {
                                       handleFirst()
                                       value += ".setIntervalValueCalled"
                                   }
                                   if self.contains(.setWindowValueCalled) {
                                       handleFirst()
                                       value += ".setWindowValueCalled"
                                   }
                                   if self.contains(.doSomethingSpecialCalled) {
                                       handleFirst()
                                       value += ".doSomethingSpecialCalled"
                                   }
                                   if self.contains(.doSomethingLessSpecialValueCalled) {
                                       handleFirst()
                                       value += ".doSomethingLessSpecialValueCalled"
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

                                   if self.contains(.value) {
                                       handleFirst()
                                       value += ".value"
                                   }

                                   value += "]"
                                   return value
                               }
                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_actorProtocol_trackPropertyActivityFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: actorProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public actor MockTest: ValueManaging {

                               public init() { }

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get the properties without registering a method call

                               public var _interval: Int
                               public var _window: Int

                               // Use these methods to set the properties without registering a method call
                           
                               public func set_interval(_ value: Int) { _interval = value }
                               public func set_window(_ value: Int) { _window = value }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let intervalGetterCalled = Method(rawValue: 1 << 0)
                                   public static let windowGetterCalled = Method(rawValue: 1 << 1)
                                   public static let setIntervalValueCalled = Method(rawValue: 1 << 2)
                                   public static let setWindowValueCalled = Method(rawValue: 1 << 3)
                                   public static let doSomethingSpecialCalled = Method(rawValue: 1 << 4)
                                   public static let doSomethingLessSpecialValueCalled = Method(rawValue: 1 << 5)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let value = MethodParameter(rawValue: 1 << 0)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var value: Int?

                               // MARK: - Variables to Use as Method Return Values

                               public var doSomethingSpecialReturnValue: String!
                               public var doSomethingLessSpecialValueReturnValue: (any Logger)?

                               public func setDoSomethingSpecialReturnValue(_ value: String) { doSomethingSpecialReturnValue = value }
                               public func setDoSomethingLessSpecialValueReturnValue(_ value: (any Logger)?) { doSomethingLessSpecialValueReturnValue = value }

                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   value = nil
                               }

                               // MARK: - Properties for Protocol Conformance

                               public var interval: Int {
                                   calledMethods.insert(.intervalGetterCalled)
                                   return _interval
                               }

                               public var window: Int {
                                   calledMethods.insert(.windowGetterCalled)
                                   return _window
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func setInterval(_ value: Int) {
                                   calledMethods.insert(.setIntervalValueCalled)
                                   self.value = value
                                   assignedParameters.insert(.value)
                               }

                               public func setWindow(_ value: Int) {
                                   calledMethods.insert(.setWindowValueCalled)
                                   self.value = value
                                   assignedParameters.insert(.value)
                               }

                               public func doSomethingSpecial() -> String {
                                   calledMethods.insert(.doSomethingSpecialCalled)
                                   return doSomethingSpecialReturnValue
                               }
                           
                               public func doSomethingLessSpecial(_ value: Int) -> (any Logger)? {
                                   calledMethods.insert(.doSomethingLessSpecialValueCalled)
                                   self.value = value
                                   assignedParameters.insert(.value)
                                   return doSomethingLessSpecialValueReturnValue
                               }

                               // Parameter used by MacrosForStroblMocks to detect an actor
                               public let isMockActor = true
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

                                   if self.contains(.intervalGetterCalled) {
                                       handleFirst()
                                       value += ".intervalGetterCalled"
                                   }
                                   if self.contains(.windowGetterCalled) {
                                       handleFirst()
                                       value += ".windowGetterCalled"
                                   }
                                   if self.contains(.setIntervalValueCalled) {
                                       handleFirst()
                                       value += ".setIntervalValueCalled"
                                   }
                                   if self.contains(.setWindowValueCalled) {
                                       handleFirst()
                                       value += ".setWindowValueCalled"
                                   }
                                   if self.contains(.doSomethingSpecialCalled) {
                                       handleFirst()
                                       value += ".doSomethingSpecialCalled"
                                   }
                                   if self.contains(.doSomethingLessSpecialValueCalled) {
                                       handleFirst()
                                       value += ".doSomethingLessSpecialValueCalled"
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

                                   if self.contains(.value) {
                                       handleFirst()
                                       value += ".value"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
}

//swiftlint:enable function_body_length
