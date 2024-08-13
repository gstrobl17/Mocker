//swiftlint:disable function_body_length file_length
//
//  ASTMockGeneratorTests+SingleFunctionProtocol.swift
//  MockerTests
//
//  Created by Greg Strobl on 1/25/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import XCTest
import SwiftSyntax

extension ASTMockGeneratorTests {
    
    // MARK: - Single Function Protocol, No Input Parameters, No Return Value
    
    var singleFunctionProtocolNoInputParametersNoReturnValue: String {
        """
        protocol SingleFunction {
           func foo()
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolNoInputParametersNoReturnValue_includeTestableImportFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()


                               func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo() {
                                   calledMethods.insert(.fooCalled)
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolNoInputParametersNoReturnValue_includeTestableImportFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           public class MockTest: SingleFunction {

                               public init() { }
                           
                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()


                               public func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo() {
                                   calledMethods.insert(.fooCalled)
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedPublicCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: - Single Function Protocol, 3 Input Parameters, No Return Value
    
    var singleFunctionProtocol3InputParametersNoReturnValue: String {
        """
        protocol SingleFunction {
           func foo(_ a: String, b: Int, c: Bool)
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocol3InputParametersNoReturnValue_includeTestableImportFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocol3InputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let fooABCCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let a = MethodParameter(rawValue: 1 << 0)
                                   static let b = MethodParameter(rawValue: 1 << 1)
                                   static let c = MethodParameter(rawValue: 1 << 2)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var a: String?
                               private(set) var b: Int?
                               private(set) var c: Bool?


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   a = nil
                                   b = nil
                                   c = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo(_ a: String, b: Int, c: Bool) {
                                   calledMethods.insert(.fooABCCalled)
                                   self.a = a
                                   assignedParameters.insert(.a)
                                   self.b = b
                                   assignedParameters.insert(.b)
                                   self.c = c
                                   assignedParameters.insert(.c)
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

                                   if self.contains(.fooABCCalled) {
                                       handleFirst()
                                       value += ".fooABCCalled"
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

                                   if self.contains(.a) {
                                       handleFirst()
                                       value += ".a"
                                   }
                                   if self.contains(.b) {
                                       handleFirst()
                                       value += ".b"
                                   }
                                   if self.contains(.c) {
                                       handleFirst()
                                       value += ".c"
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
    
    func testCodeGeneration_singleFunctionProtocol3InputParametersNoReturnValue_includeTestableImportFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocol3InputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooABCCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let a = MethodParameter(rawValue: 1 << 0)
                                   public static let b = MethodParameter(rawValue: 1 << 1)
                                   public static let c = MethodParameter(rawValue: 1 << 2)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var a: String?
                               private(set) public var b: Int?
                               private(set) public var c: Bool?


                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   a = nil
                                   b = nil
                                   c = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo(_ a: String, b: Int, c: Bool) {
                                   calledMethods.insert(.fooABCCalled)
                                   self.a = a
                                   assignedParameters.insert(.a)
                                   self.b = b
                                   assignedParameters.insert(.b)
                                   self.c = c
                                   assignedParameters.insert(.c)
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

                                   if self.contains(.fooABCCalled) {
                                       handleFirst()
                                       value += ".fooABCCalled"
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

                                   if self.contains(.a) {
                                       handleFirst()
                                       value += ".a"
                                   }
                                   if self.contains(.b) {
                                       handleFirst()
                                       value += ".b"
                                   }
                                   if self.contains(.c) {
                                       handleFirst()
                                       value += ".c"
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

    // MARK: - Single Function Protocol, 2 Input Parameters - one any, one optional any, No Return Value
    
    var singleFunctionProtocol2AnyInputParametersNoReturnValue: String {
        """
        protocol SingleFunction {
           func foo(_ a: any SomeType, b: (any SomeOptionalType)?)
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocol2AnyInputParametersNoReturnValue_includeTestableImportFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocol2AnyInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let fooABCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let a = MethodParameter(rawValue: 1 << 0)
                                   static let b = MethodParameter(rawValue: 1 << 1)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var a: (any SomeType)?
                               private(set) var b: (any SomeOptionalType)?


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   a = nil
                                   b = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo(_ a: any SomeType, b: (any SomeOptionalType)?) {
                                   calledMethods.insert(.fooABCalled)
                                   self.a = a
                                   assignedParameters.insert(.a)
                                   self.b = b
                                   assignedParameters.insert(.b)
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

                                   if self.contains(.fooABCalled) {
                                       handleFirst()
                                       value += ".fooABCalled"
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

                                   if self.contains(.a) {
                                       handleFirst()
                                       value += ".a"
                                   }
                                   if self.contains(.b) {
                                       handleFirst()
                                       value += ".b"
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
    
    func testCodeGeneration_singleFunctionProtocol2AnyInputParametersNoReturnValue_includeTestableImportFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocol2AnyInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooABCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let a = MethodParameter(rawValue: 1 << 0)
                                   public static let b = MethodParameter(rawValue: 1 << 1)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var a: (any SomeType)?
                               private(set) public var b: (any SomeOptionalType)?


                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   a = nil
                                   b = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo(_ a: any SomeType, b: (any SomeOptionalType)?) {
                                   calledMethods.insert(.fooABCalled)
                                   self.a = a
                                   assignedParameters.insert(.a)
                                   self.b = b
                                   assignedParameters.insert(.b)
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

                                   if self.contains(.fooABCalled) {
                                       handleFirst()
                                       value += ".fooABCalled"
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

                                   if self.contains(.a) {
                                       handleFirst()
                                       value += ".a"
                                   }
                                   if self.contains(.b) {
                                       handleFirst()
                                       value += ".b"
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

    // MARK: - Single Function Protocol, No Input Parameters, Int Return Value
    
    var singleFunctionProtocolNoInputParametersIntReturnValue: String {
        """
        protocol SingleFunction {
           func foo() -> Int
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolNoInputParametersIntReturnValue_includeTestableImportFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolNoInputParametersIntReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               // MARK: - Variables to Use as Method Return Values

                               var fooReturnValue: Int!


                               func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo() -> Int {
                                   calledMethods.insert(.fooCalled)
                                   return fooReturnValue
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolNoInputParametersIntReturnValue_includeTestableImportFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolNoInputParametersIntReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()

                               // MARK: - Variables to Use as Method Return Values

                               public var fooReturnValue: Int!


                               public func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo() -> Int {
                                   calledMethods.insert(.fooCalled)
                                   return fooReturnValue
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedPublicCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: - Single Function Protocol, No Input Parameters, Any SomeType Return Value
    
    var singleFunctionProtocolNoInputParametersAnySomeTypeReturnValue: String {
        """
        protocol SingleFunction {
           func foo() -> any SomeType
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolNoInputParametersAnySomeTypeReturnValue_includeTestableImportFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolNoInputParametersAnySomeTypeReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               // MARK: - Variables to Use as Method Return Values

                               var fooReturnValue: (any SomeType)!


                               func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo() -> any SomeType {
                                   calledMethods.insert(.fooCalled)
                                   return fooReturnValue
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolNoInputParametersAnySomeTypeReturnValue_includeTestableImportFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolNoInputParametersAnySomeTypeReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()

                               // MARK: - Variables to Use as Method Return Values

                               public var fooReturnValue: (any SomeType)!


                               public func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo() -> any SomeType {
                                   calledMethods.insert(.fooCalled)
                                   return fooReturnValue
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedPublicCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: - Single Function Protocol, No Input Parameters, Optional Any SomeType Return Value
    
    var singleFunctionProtocolNoInputParametersOptionalAnySomeTypeReturnValue: String {
        """
        protocol SingleFunction {
           func foo() -> (any SomeType)?
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolNoInputParametersOptionalAnySomeTypeReturnValue_includeTestableImportFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolNoInputParametersOptionalAnySomeTypeReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               // MARK: - Variables to Use as Method Return Values

                               var fooReturnValue: (any SomeType)?


                               func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo() -> (any SomeType)? {
                                   calledMethods.insert(.fooCalled)
                                   return fooReturnValue
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolNoInputParametersOptionalAnySomeTypeReturnValue_includeTestableImportFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolNoInputParametersOptionalAnySomeTypeReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()

                               // MARK: - Variables to Use as Method Return Values

                               public var fooReturnValue: (any SomeType)?


                               public func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo() -> (any SomeType)? {
                                   calledMethods.insert(.fooCalled)
                                   return fooReturnValue
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedPublicCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: - Single Function Protocol, Optional Void Completion Handler Input Parameter, No Return Value
    
    var singleFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue: String {
        """
        protocol SingleFunction {
            func foo(completion: (() -> Void)?)
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue_includeTestableImportFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let fooCompletionCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let completion = MethodParameter(rawValue: 1 << 0)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var completion: (() -> Void)?


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   completion = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo(completion: (() -> Void)?) {
                                   calledMethods.insert(.fooCompletionCalled)
                                   self.completion = completion
                                   assignedParameters.insert(.completion)
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

                                   if self.contains(.fooCompletionCalled) {
                                       handleFirst()
                                       value += ".fooCompletionCalled"
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

                                   if self.contains(.completion) {
                                       handleFirst()
                                       value += ".completion"
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
    
    func testCodeGeneration_singleFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue_includeTestableImportFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCompletionCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let completion = MethodParameter(rawValue: 1 << 0)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var completion: (() -> Void)?


                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   completion = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo(completion: (() -> Void)?) {
                                   calledMethods.insert(.fooCompletionCalled)
                                   self.completion = completion
                                   assignedParameters.insert(.completion)
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

                                   if self.contains(.fooCompletionCalled) {
                                       handleFirst()
                                       value += ".fooCompletionCalled"
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

                                   if self.contains(.completion) {
                                       handleFirst()
                                       value += ".completion"
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

    // MARK: - Single Function Protocol, Escaping Result Completion Handler Input Parameter, No Return Value
    
    var singleFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue: String {
        """
        protocol SingleFunction {
            func foo(completionHandler: @escaping (Result<[Item], Error>) -> Void)
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue_includeTestableImportFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let fooCompletionHandlerCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let itemsCompletionHandler = MethodParameter(rawValue: 1 << 0)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var itemsCompletionHandler: ((Result<[Item], Error>) -> Void)?

                               // MARK: - Variables to Use to Control Completion Handlers

                               var shouldCallCompletionHandler = false
                               var itemsCompletionHandlerResult = .failure(MockError)

                               var shouldCallFooCompletionHandlerCompletionHander = false
                               var fooCompletionHandlerCompletionHanderResult: Result<[Item], Error> = .failure(MockError)

                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   itemsCompletionHandler = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo(completionHandler: @escaping (Result<[Item], Error>) -> Void) {
                                   calledMethods.insert(.fooCompletionHandlerCalled)
                                   self.itemsCompletionHandler = completionHandler
                                   assignedParameters.insert(.itemsCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(itemsCompletionHandlerResult)
                                   }
                                   if shouldCallFooCompletionHandlerCompletionHander {
                                       completionHandler(fooCompletionHandlerCompletionHanderResult)
                                   }
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

                                   if self.contains(.fooCompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".fooCompletionHandlerCalled"
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

                                   if self.contains(.itemsCompletionHandler) {
                                       handleFirst()
                                       value += ".itemsCompletionHandler"
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
    
    func testCodeGeneration_singleFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue_includeTestableImportFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCompletionHandlerCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let itemsCompletionHandler = MethodParameter(rawValue: 1 << 0)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var itemsCompletionHandler: ((Result<[Item], Error>) -> Void)?

                               // MARK: - Variables to Use to Control Completion Handlers

                               public var shouldCallCompletionHandler = false
                               public var itemsCompletionHandlerResult = .failure(MockError)

                               public var shouldCallFooCompletionHandlerCompletionHander = false
                               public var fooCompletionHandlerCompletionHanderResult: Result<[Item], Error> = .failure(MockError)

                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   itemsCompletionHandler = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo(completionHandler: @escaping (Result<[Item], Error>) -> Void) {
                                   calledMethods.insert(.fooCompletionHandlerCalled)
                                   self.itemsCompletionHandler = completionHandler
                                   assignedParameters.insert(.itemsCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(itemsCompletionHandlerResult)
                                   }
                                   if shouldCallFooCompletionHandlerCompletionHander {
                                       completionHandler(fooCompletionHandlerCompletionHanderResult)
                                   }
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

                                   if self.contains(.fooCompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".fooCompletionHandlerCalled"
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

                                   if self.contains(.itemsCompletionHandler) {
                                       handleFirst()
                                       value += ".itemsCompletionHandler"
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

    // MARK: - Single Function Protocol, Aync, No Input Parameters, No Return Value
    
    var singleFunctionProtocolAsyncNoInputParametersNoReturnValue: String {
        """
        protocol SingleFunction {
           func foo() async
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolAsyncNoInputParametersNoReturnValue_includeTestableImportFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolAsyncNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()


                               func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo() async {
                                   calledMethods.insert(.fooCalled)
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolAsyncNoInputParametersNoReturnValue_includeTestableImportFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolAsyncNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()


                               public func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo() async {
                                   calledMethods.insert(.fooCalled)
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedPublicCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: - Single Function Protocol, Aync, Throws, No Input Parameters, No Return Value
    
    var singleFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue: String {
        """
        protocol SingleFunction {
           func foo() async throws
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue_includeTestableImportFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               var errorToThrow: Error!
                               var fooShouldThrowError = false


                               func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo() async throws {
                                   calledMethods.insert(.fooCalled)
                                   if fooShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue_includeTestableImportFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()

                               public var errorToThrow: Error!
                               public var fooShouldThrowError = false


                               public func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo() async throws {
                                   calledMethods.insert(.fooCalled)
                                   if fooShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedPublicCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: - Single Function Protocol, Aync, Throws, No Input Parameters, SomeItem Return Value
    
    var singleFunctionProtocolAsyncThrowsNoInputParametersSomeItemReturnValue: String {
        """
        protocol SingleFunction {
           func foo() async throws -> SomeItem
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolAsyncThrowsNoInputParametersSomeItemReturnValue_includeTestableImportFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolAsyncThrowsNoInputParametersSomeItemReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               // MARK: - Variables to Use as Method Return Values

                               var fooReturnValue: SomeItem!

                               var errorToThrow: Error!
                               var fooShouldThrowError = false


                               func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo() async throws -> SomeItem {
                                   calledMethods.insert(.fooCalled)
                                   if fooShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return fooReturnValue
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolAsyncThrowsNoInputParametersSomeItemReturnValue_includeTestableImportFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolAsyncThrowsNoInputParametersSomeItemReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()

                               // MARK: - Variables to Use as Method Return Values

                               public var fooReturnValue: SomeItem!

                               public var errorToThrow: Error!
                               public var fooShouldThrowError = false


                               public func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo() async throws -> SomeItem {
                                   calledMethods.insert(.fooCalled)
                                   if fooShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return fooReturnValue
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedPublicCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: - Single Function Protocol, No Input Parameters, Optional SomeItem Return Value
    
    var singleFunctionProtocolNoInputParametersOptionalSomeItemReturnValue: String {
        """
        protocol SingleFunction {
           func foo() -> SomeItem?
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolNoInputParametersOptionalSomeItemReturnValue_includeTestableImportFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolNoInputParametersOptionalSomeItemReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               // MARK: - Variables to Use as Method Return Values

                               var fooReturnValue: SomeItem?


                               func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo() -> SomeItem? {
                                   calledMethods.insert(.fooCalled)
                                   return fooReturnValue
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolNoInputParametersOptionalSomeItemReturnValue_includeTestableImportFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolNoInputParametersOptionalSomeItemReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()

                               // MARK: - Variables to Use as Method Return Values

                               public var fooReturnValue: SomeItem?


                               public func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo() -> SomeItem? {
                                   calledMethods.insert(.fooCalled)
                                   return fooReturnValue
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedPublicCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: - Single Function Protocol, Aync, Throws, No Input Parameters, Any SomeItem Return Value
    
    var singleFunctionProtocolAsyncThrowsNoInputParametersAnySomeItemReturnValue: String {
        """
        protocol SingleFunction {
           func foo() async throws -> any SomeItem
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolAsyncThrowsNoInputParametersAnySomeItemReturnValue_includeTestableImportFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolAsyncThrowsNoInputParametersAnySomeItemReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               // MARK: - Variables to Use as Method Return Values

                               var fooReturnValue: (any SomeItem)!

                               var errorToThrow: Error!
                               var fooShouldThrowError = false


                               func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo() async throws -> any SomeItem {
                                   calledMethods.insert(.fooCalled)
                                   if fooShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return fooReturnValue
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolAsyncThrowsNoInputParametersAnySomeItemReturnValue_includeTestableImportFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolAsyncThrowsNoInputParametersAnySomeItemReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()

                               // MARK: - Variables to Use as Method Return Values

                               public var fooReturnValue: (any SomeItem)!

                               public var errorToThrow: Error!
                               public var fooShouldThrowError = false


                               public func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo() async throws -> any SomeItem {
                                   calledMethods.insert(.fooCalled)
                                   if fooShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return fooReturnValue
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedPublicCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: - Single Function Protocol, Aync, Throws, No Input Parameters, Optional Any SomeItem Return Value
    
    var singleFunctionProtocolAsyncThrowsNoInputParametersOptionalAnySomeItemReturnValue: String {
        """
        protocol SingleFunction {
           func foo() async throws -> (any SomeItem)?
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolAsyncThrowsNoInputParametersOptionalAnySomeItemReturnValue_includeTestableImportFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolAsyncThrowsNoInputParametersOptionalAnySomeItemReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               // MARK: - Variables to Use as Method Return Values

                               var fooReturnValue: (any SomeItem)?

                               var errorToThrow: Error!
                               var fooShouldThrowError = false


                               func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo() async throws -> (any SomeItem)? {
                                   calledMethods.insert(.fooCalled)
                                   if fooShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return fooReturnValue
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolAsyncThrowsNoInputParametersOptionalAnySomeItemReturnValue_includeTestableImportFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolAsyncThrowsNoInputParametersOptionalAnySomeItemReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()

                               // MARK: - Variables to Use as Method Return Values

                               public var fooReturnValue: (any SomeItem)?

                               public var errorToThrow: Error!
                               public var fooShouldThrowError = false


                               public func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo() async throws -> (any SomeItem)? {
                                   calledMethods.insert(.fooCalled)
                                   if fooShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return fooReturnValue
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

                                   if self.contains(.fooCalled) {
                                       handleFirst()
                                       value += ".fooCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedPublicCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

}
//swiftlint:enable function_body_length file_length
