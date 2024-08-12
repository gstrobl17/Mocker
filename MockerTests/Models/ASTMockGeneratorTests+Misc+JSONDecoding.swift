//swiftlint:disable function_body_length file_length
//
//  ASTMockGeneratorTests+Misc+JSONDecoding.swift
//  MockerTests
//
//  Created by Greg Strobl on 1/25/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import XCTest
import SwiftSyntax

extension ASTMockGeneratorTests {
    
    var jsonDecodingProtocol: String {
        """
        protocol JSONDecoding {
         
            func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : any Decodable

        }
        """
    }
    
    func testCodeGeneration_jsonDecodingProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: jsonDecodingProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           class MockTest: JSONDecoding {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let decodeTypeFromDataCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let type = MethodParameter(rawValue: 1 << 0)
                                   static let data = MethodParameter(rawValue: 1 << 1)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var type: T.Type?
                               private(set) var data: Data?

                               // MARK: - Variables to Use as Method Return Values

                               var decodeTypeFromDataReturnValue: T!

                               var errorToThrow: Error!
                               var decodeTypeFromDataShouldThrowError = false


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   type = nil
                                   data = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : any Decodable {
                                   calledMethods.insert(.decodeTypeFromDataCalled)
                                   self.type = type
                                   assignedParameters.insert(.type)
                                   self.data = data
                                   assignedParameters.insert(.data)
                                   if decodeTypeFromDataShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return decodeTypeFromDataReturnValue
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

                                   if self.contains(.decodeTypeFromDataCalled) {
                                       handleFirst()
                                       value += ".decodeTypeFromDataCalled"
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

                                   if self.contains(.type) {
                                       handleFirst()
                                       value += ".type"
                                   }
                                   if self.contains(.data) {
                                       handleFirst()
                                       value += ".data"
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
    
    func testCodeGeneration_jsonDecodingProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: jsonDecodingProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public class MockTest: JSONDecoding {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let decodeTypeFromDataCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let type = MethodParameter(rawValue: 1 << 0)
                                   public static let data = MethodParameter(rawValue: 1 << 1)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var type: T.Type?
                               private(set) public var data: Data?

                               // MARK: - Variables to Use as Method Return Values

                               public var decodeTypeFromDataReturnValue: T!

                               public var errorToThrow: Error!
                               public var decodeTypeFromDataShouldThrowError = false


                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   type = nil
                                   data = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : any Decodable {
                                   calledMethods.insert(.decodeTypeFromDataCalled)
                                   self.type = type
                                   assignedParameters.insert(.type)
                                   self.data = data
                                   assignedParameters.insert(.data)
                                   if decodeTypeFromDataShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return decodeTypeFromDataReturnValue
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

                                   if self.contains(.decodeTypeFromDataCalled) {
                                       handleFirst()
                                       value += ".decodeTypeFromDataCalled"
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

                                   if self.contains(.type) {
                                       handleFirst()
                                       value += ".type"
                                   }
                                   if self.contains(.data) {
                                       handleFirst()
                                       value += ".data"
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

    func testCodeGeneration_jsonDecodingProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: jsonDecodingProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: true)
        createGenerator(swiftlintAware: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           class MockTest: JSONDecoding {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let decodeTypeFromDataCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let type = MethodParameter(rawValue: 1 << 0)
                                   static let data = MethodParameter(rawValue: 1 << 1)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var type: T.Type?
                               private(set) var data: Data?

                               // MARK: - Variables to Use as Method Return Values

                               //swiftlint:disable implicitly_unwrapped_optional
                               var decodeTypeFromDataReturnValue: T!
                               //swiftlint:enable implicitly_unwrapped_optional

                               var errorToThrow: Error!
                               var decodeTypeFromDataShouldThrowError = false


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   type = nil
                                   data = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : any Decodable {
                                   calledMethods.insert(.decodeTypeFromDataCalled)
                                   self.type = type
                                   assignedParameters.insert(.type)
                                   self.data = data
                                   assignedParameters.insert(.data)
                                   if decodeTypeFromDataShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return decodeTypeFromDataReturnValue
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

                                   if self.contains(.decodeTypeFromDataCalled) {
                                       handleFirst()
                                       value += ".decodeTypeFromDataCalled"
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

                                   if self.contains(.type) {
                                       handleFirst()
                                       value += ".type"
                                   }
                                   if self.contains(.data) {
                                       handleFirst()
                                       value += ".data"
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

    func testCodeGeneration_jsonDecodingProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: jsonDecodingProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: true, public: true)
        createGenerator(swiftlintAware: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public class MockTest: JSONDecoding {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let decodeTypeFromDataCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let type = MethodParameter(rawValue: 1 << 0)
                                   public static let data = MethodParameter(rawValue: 1 << 1)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var type: T.Type?
                               private(set) public var data: Data?

                               // MARK: - Variables to Use as Method Return Values

                               //swiftlint:disable implicitly_unwrapped_optional
                               public var decodeTypeFromDataReturnValue: T!
                               //swiftlint:enable implicitly_unwrapped_optional

                               public var errorToThrow: Error!
                               public var decodeTypeFromDataShouldThrowError = false


                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   type = nil
                                   data = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : any Decodable {
                                   calledMethods.insert(.decodeTypeFromDataCalled)
                                   self.type = type
                                   assignedParameters.insert(.type)
                                   self.data = data
                                   assignedParameters.insert(.data)
                                   if decodeTypeFromDataShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return decodeTypeFromDataReturnValue
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

                                   if self.contains(.decodeTypeFromDataCalled) {
                                       handleFirst()
                                       value += ".decodeTypeFromDataCalled"
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

                                   if self.contains(.type) {
                                       handleFirst()
                                       value += ".type"
                                   }
                                   if self.contains(.data) {
                                       handleFirst()
                                       value += ".data"
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
