//swiftlint:disable function_body_length file_length
//
//  ASTMockGeneratorTests+SingleStaticFunctionProtocol.swift
//  MockerTests
//
//  Created by Greg Strobl on 1/25/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import XCTest
import SwiftSyntax
import SwiftSyntaxParser

extension ASTMockGeneratorTests {
    
    // MARK: Single Static Function Protocol, No Input Parameters, No Return Value
    
    var singleStaticFunctionProtocolNoInputParametersNoReturnValue: String {
        """
        protocol SingleFunction {
           static func foo()
        }
        """
    }
    
    func testCodeGeneration_singleStaticFunctionProtocolNoInputParametersNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()


                               func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo() {
                                   calledStaticMethods.insert(.fooCalled)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleStaticFunctionProtocolNoInputParametersNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct StaticMethod: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()


                               public func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public static func foo() {
                                   calledStaticMethods.insert(.fooCalled)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_singleStaticFunctionProtocolNoInputParametersNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true)
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

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()


                               func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo() {
                                   calledStaticMethods.insert(.fooCalled)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_singleStaticFunctionProtocolNoInputParametersNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true, public: true)
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

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct StaticMethod: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()


                               public func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public static func foo() {
                                   calledStaticMethods.insert(.fooCalled)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: Single Static Function Protocol, 3 Input Parameters, No Return Value
    
    var singleStaticFunctionProtocol3InputParametersNoReturnValue: String {
        """
        protocol SingleFunction {
             static func foo(_ a: String, b: Int, c: Bool)
        }
        """
    }
    
    func testCodeGeneration_singleStaticFunctionProtocol3InputParametersNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocol3InputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let fooABCCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               struct StaticMethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let a = StaticMethodParameter(rawValue: 1 << 0)
                                   static let b = StaticMethodParameter(rawValue: 1 << 1)
                                   static let c = StaticMethodParameter(rawValue: 1 << 2)
                               }
                               private(set) static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) static var a: String?
                               private(set) static var b: Int?
                               private(set) static var c: Bool?


                               func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.a = nil
                                   MockTest.b = nil
                                   MockTest.c = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo(_ a: String, b: Int, c: Bool) {
                                   calledStaticMethods.insert(.fooABCCalled)
                                   self.a = a
                                   assignedStaticParameters.insert(.a)
                                   self.b = b
                                   assignedStaticParameters.insert(.b)
                                   self.c = c
                                   assignedStaticParameters.insert(.c)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           extension MockTest.StaticMethodParameter: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleStaticFunctionProtocol3InputParametersNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocol3InputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct StaticMethod: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooABCCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()

                               public struct StaticMethodParameter: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let a = StaticMethodParameter(rawValue: 1 << 0)
                                   public static let b = StaticMethodParameter(rawValue: 1 << 1)
                                   public static let c = StaticMethodParameter(rawValue: 1 << 2)
                               }
                               private(set) public static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public static var a: String?
                               private(set) public static var b: Int?
                               private(set) public static var c: Bool?


                               public func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.a = nil
                                   MockTest.b = nil
                                   MockTest.c = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public static func foo(_ a: String, b: Int, c: Bool) {
                                   calledStaticMethods.insert(.fooABCCalled)
                                   self.a = a
                                   assignedStaticParameters.insert(.a)
                                   self.b = b
                                   assignedStaticParameters.insert(.b)
                                   self.c = c
                                   assignedStaticParameters.insert(.c)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           extension MockTest.StaticMethodParameter: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_singleStaticFunctionProtocol3InputParametersNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocol3InputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true)
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

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let fooABCCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               //swiftlint:disable identifier_name
                               struct StaticMethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let a = StaticMethodParameter(rawValue: 1 << 0)
                                   static let b = StaticMethodParameter(rawValue: 1 << 1)
                                   static let c = StaticMethodParameter(rawValue: 1 << 2)
                               }
                               //swiftlint:enable identifier_name
                               private(set) static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) static var a: String?
                               private(set) static var b: Int?
                               private(set) static var c: Bool?


                               func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.a = nil
                                   MockTest.b = nil
                                   MockTest.c = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo(_ a: String, b: Int, c: Bool) {
                                   calledStaticMethods.insert(.fooABCCalled)
                                   self.a = a
                                   assignedStaticParameters.insert(.a)
                                   self.b = b
                                   assignedStaticParameters.insert(.b)
                                   self.c = c
                                   assignedStaticParameters.insert(.c)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           extension MockTest.StaticMethodParameter: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_singleStaticFunctionProtocol3InputParametersNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocol3InputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true, public: true)
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

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct StaticMethod: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooABCCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()

                               //swiftlint:disable identifier_name
                               public struct StaticMethodParameter: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let a = StaticMethodParameter(rawValue: 1 << 0)
                                   public static let b = StaticMethodParameter(rawValue: 1 << 1)
                                   public static let c = StaticMethodParameter(rawValue: 1 << 2)
                               }
                               //swiftlint:enable identifier_name
                               private(set) public static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public static var a: String?
                               private(set) public static var b: Int?
                               private(set) public static var c: Bool?


                               public func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.a = nil
                                   MockTest.b = nil
                                   MockTest.c = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public static func foo(_ a: String, b: Int, c: Bool) {
                                   calledStaticMethods.insert(.fooABCCalled)
                                   self.a = a
                                   assignedStaticParameters.insert(.a)
                                   self.b = b
                                   assignedStaticParameters.insert(.b)
                                   self.c = c
                                   assignedStaticParameters.insert(.c)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           extension MockTest.StaticMethodParameter: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: Single Static Function Protocol, No Input Parameters, Int Return Value
    
    var singleStaticFunctionProtocolNoInputParametersIntReturnValue: String {
        """
        protocol SingleFunction {
            static func foo() -> Int
        }
        """
    }
    
    func testCodeGeneration_singleStaticFunctionProtocolNoInputParametersIntReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolNoInputParametersIntReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               // MARK: - Variables to Use as Method Return Values

                               static var fooReturnValue: Int!


                               func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo() -> Int {
                                   calledStaticMethods.insert(.fooCalled)
                                   return fooReturnValue
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleStaticFunctionProtocolNoInputParametersIntReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolNoInputParametersIntReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct StaticMethod: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()

                               // MARK: - Variables to Use as Method Return Values

                               public static var fooReturnValue: Int!


                               public func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public static func foo() -> Int {
                                   calledStaticMethods.insert(.fooCalled)
                                   return fooReturnValue
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
 
    func testCodeGeneration_singleStaticFunctionProtocolNoInputParametersIntReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolNoInputParametersIntReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true)
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

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               // MARK: - Variables to Use as Method Return Values

                               //swiftlint:disable implicitly_unwrapped_optional
                               static var fooReturnValue: Int!
                               //swiftlint:enable implicitly_unwrapped_optional


                               func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo() -> Int {
                                   calledStaticMethods.insert(.fooCalled)
                                   return fooReturnValue
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleStaticFunctionProtocolNoInputParametersIntReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolNoInputParametersIntReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true, public: true)
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
                           
                           public class MockTest: SingleFunction {
                           
                               public init() { }
                           
                               // MARK: - Variables for Trackings Method Invocation
                           
                               public struct StaticMethod: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()
                           
                               // MARK: - Variables to Use as Method Return Values
                           
                               //swiftlint:disable implicitly_unwrapped_optional
                               public static var fooReturnValue: Int!
                               //swiftlint:enable implicitly_unwrapped_optional
                           
                           
                               public func reset() {
                                   MockTest.calledStaticMethods = []
                               }
                           
                               // MARK: - Methods for Protocol Conformance
                           
                               public static func foo() -> Int {
                                   calledStaticMethods.insert(.fooCalled)
                                   return fooReturnValue
                               }
                           
                           }
                           
                           extension MockTest.StaticMethod: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: Single Static Function Protocol, Optional Void Completion Handler Input Parameter, No Return Value
    
    var singleStaticFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue: String {
        """
        protocol SingleFunction {
            static func foo(completion: (() -> Void)?)
        }
        """
    }
    
    func testCodeGeneration_singleStaticFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let fooCompletionCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               struct StaticMethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let completion = StaticMethodParameter(rawValue: 1 << 0)
                               }
                               private(set) static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) static var completion: (() -> Void)?


                               func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.completion = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo(completion: (() -> Void)?) {
                                   calledStaticMethods.insert(.fooCompletionCalled)
                                   self.completion = completion
                                   assignedStaticParameters.insert(.completion)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           extension MockTest.StaticMethodParameter: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleStaticFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct StaticMethod: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCompletionCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()

                               public struct StaticMethodParameter: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let completion = StaticMethodParameter(rawValue: 1 << 0)
                               }
                               private(set) public static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public static var completion: (() -> Void)?


                               public func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.completion = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public static func foo(completion: (() -> Void)?) {
                                   calledStaticMethods.insert(.fooCompletionCalled)
                                   self.completion = completion
                                   assignedStaticParameters.insert(.completion)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           extension MockTest.StaticMethodParameter: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_singleStaticFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true)
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
                           
                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let fooCompletionCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               struct StaticMethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let completion = StaticMethodParameter(rawValue: 1 << 0)
                               }
                               private(set) static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) static var completion: (() -> Void)?


                               func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.completion = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo(completion: (() -> Void)?) {
                                   calledStaticMethods.insert(.fooCompletionCalled)
                                   self.completion = completion
                                   assignedStaticParameters.insert(.completion)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           extension MockTest.StaticMethodParameter: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_singleStaticFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true, public: true)
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
                           
                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct StaticMethod: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCompletionCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()

                               public struct StaticMethodParameter: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let completion = StaticMethodParameter(rawValue: 1 << 0)
                               }
                               private(set) public static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public static var completion: (() -> Void)?


                               public func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.completion = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public static func foo(completion: (() -> Void)?) {
                                   calledStaticMethods.insert(.fooCompletionCalled)
                                   self.completion = completion
                                   assignedStaticParameters.insert(.completion)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           extension MockTest.StaticMethodParameter: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: Single Static Function Protocol, Escaping Result Completion Handler Input Parameter, No Return Value
    
    var singleStaticFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue: String {
        """
        protocol SingleFunction {
            static func foo(completionHandler: @escaping (Result<[Item], Error>) -> Void)
        }
        """
    }
    
    func testCodeGeneration_singleStaticFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core
                           
                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let fooCompletionHandlerCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               struct StaticMethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let itemsCompletionHandler = StaticMethodParameter(rawValue: 1 << 0)
                               }
                               private(set) static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) static var itemsCompletionHandler: ((Result<[Item], Error>) -> Void)?

                               // MARK: - Variables to Use to Control Completion Handlers

                               var shouldCallCompletionHandler = false
                               var itemsCompletionHandlerResult = .failure(MockError)

                               var shouldCallFooCompletionHandlerCompletionHander = false
                               var fooCompletionHandlerCompletionHanderResult: Result<[Item], Error> = .failure(MockError)

                               func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.itemsCompletionHandler = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo(completionHandler: @escaping (Result<[Item], Error>) -> Void) {
                                   calledStaticMethods.insert(.fooCompletionHandlerCalled)
                                   self.itemsCompletionHandler = completionHandler
                                   assignedStaticParameters.insert(.itemsCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(itemsCompletionHandlerResult)
                                   }
                                   if shouldCallFooCompletionHandlerCompletionHander {
                                       completionHandler(fooCompletionHandlerCompletionHanderResult)
                                   }
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           extension MockTest.StaticMethodParameter: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleStaticFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core
                           
                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct StaticMethod: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCompletionHandlerCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()

                               public struct StaticMethodParameter: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let itemsCompletionHandler = StaticMethodParameter(rawValue: 1 << 0)
                               }
                               private(set) public static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public static var itemsCompletionHandler: ((Result<[Item], Error>) -> Void)?

                               // MARK: - Variables to Use to Control Completion Handlers

                               public var shouldCallCompletionHandler = false
                               public var itemsCompletionHandlerResult = .failure(MockError)

                               public var shouldCallFooCompletionHandlerCompletionHander = false
                               public var fooCompletionHandlerCompletionHanderResult: Result<[Item], Error> = .failure(MockError)

                               public func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.itemsCompletionHandler = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public static func foo(completionHandler: @escaping (Result<[Item], Error>) -> Void) {
                                   calledStaticMethods.insert(.fooCompletionHandlerCalled)
                                   self.itemsCompletionHandler = completionHandler
                                   assignedStaticParameters.insert(.itemsCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(itemsCompletionHandlerResult)
                                   }
                                   if shouldCallFooCompletionHandlerCompletionHander {
                                       completionHandler(fooCompletionHandlerCompletionHanderResult)
                                   }
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           extension MockTest.StaticMethodParameter: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_singleStaticFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true)
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
                           
                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let fooCompletionHandlerCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               struct StaticMethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let itemsCompletionHandler = StaticMethodParameter(rawValue: 1 << 0)
                               }
                               private(set) static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) static var itemsCompletionHandler: ((Result<[Item], Error>) -> Void)?

                               // MARK: - Variables to Use to Control Completion Handlers

                               //swiftlint:disable identifier_name
                               var shouldCallCompletionHandler = false
                               var itemsCompletionHandlerResult = .failure(MockError)

                               var shouldCallFooCompletionHandlerCompletionHander = false
                               var fooCompletionHandlerCompletionHanderResult: Result<[Item], Error> = .failure(MockError)
                               //swiftlint:enable identifier_name

                               func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.itemsCompletionHandler = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo(completionHandler: @escaping (Result<[Item], Error>) -> Void) {
                                   calledStaticMethods.insert(.fooCompletionHandlerCalled)
                                   self.itemsCompletionHandler = completionHandler
                                   assignedStaticParameters.insert(.itemsCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(itemsCompletionHandlerResult)
                                   }
                                   if shouldCallFooCompletionHandlerCompletionHander {
                                       completionHandler(fooCompletionHandlerCompletionHanderResult)
                                   }
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           extension MockTest.StaticMethodParameter: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_singleStaticFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true, public: true)
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
                           
                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct StaticMethod: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCompletionHandlerCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()

                               public struct StaticMethodParameter: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let itemsCompletionHandler = StaticMethodParameter(rawValue: 1 << 0)
                               }
                               private(set) public static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public static var itemsCompletionHandler: ((Result<[Item], Error>) -> Void)?

                               // MARK: - Variables to Use to Control Completion Handlers

                               //swiftlint:disable identifier_name
                               public var shouldCallCompletionHandler = false
                               public var itemsCompletionHandlerResult = .failure(MockError)

                               public var shouldCallFooCompletionHandlerCompletionHander = false
                               public var fooCompletionHandlerCompletionHanderResult: Result<[Item], Error> = .failure(MockError)
                               //swiftlint:enable identifier_name

                               public func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.itemsCompletionHandler = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public static func foo(completionHandler: @escaping (Result<[Item], Error>) -> Void) {
                                   calledStaticMethods.insert(.fooCompletionHandlerCalled)
                                   self.itemsCompletionHandler = completionHandler
                                   assignedStaticParameters.insert(.itemsCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(itemsCompletionHandlerResult)
                                   }
                                   if shouldCallFooCompletionHandlerCompletionHander {
                                       completionHandler(fooCompletionHandlerCompletionHanderResult)
                                   }
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           extension MockTest.StaticMethodParameter: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: Single Static Function Protocol, Aync, No Input Parameters, No Return Value
    
    var singleStaticFunctionProtocolAsyncNoInputParametersNoReturnValue: String {
        """
        protocol SingleFunction {
           static func foo() async
        }
        """
    }
    
    func testCodeGeneration_singleStaticFunctionProtocolAsyncNoInputParametersNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolAsyncNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()


                               func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo() async {
                                   calledStaticMethods.insert(.fooCalled)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleStaticFunctionProtocolAsyncNoInputParametersNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolAsyncNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct StaticMethod: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()


                               public func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public static func foo() async {
                                   calledStaticMethods.insert(.fooCalled)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_singleStaticFunctionProtocolAsyncNoInputParametersNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolAsyncNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true)
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

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()


                               func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo() async {
                                   calledStaticMethods.insert(.fooCalled)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_singleStaticFunctionProtocolAsyncNoInputParametersNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolAsyncNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true, public: true)
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

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct StaticMethod: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()


                               public func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public static func foo() async {
                                   calledStaticMethods.insert(.fooCalled)
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: Single Static Function Protocol, Aync, Throws, No Input Parameters, No Return Value
    
    var singleStaticFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue: String {
        """
        protocol SingleFunction {
           static func foo() async throws
        }
        """
    }
    
    func testCodeGeneration_singleStaticFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core
                           
                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               static var errorToThrow: Error!
                               static var fooShouldThrowError = false


                               func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo() async throws {
                                   calledStaticMethods.insert(.fooCalled)
                                   if fooShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleStaticFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core
                           
                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct StaticMethod: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()

                               public static var errorToThrow: Error!
                               public static var fooShouldThrowError = false


                               public func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public static func foo() async throws {
                                   calledStaticMethods.insert(.fooCalled)
                                   if fooShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_singleStaticFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true)
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

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               static var errorToThrow: Error!
                               static var fooShouldThrowError = false


                               func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo() async throws {
                                   calledStaticMethods.insert(.fooCalled)
                                   if fooShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_singleStaticFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true, public: true)
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

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct StaticMethod: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()

                               public static var errorToThrow: Error!
                               public static var fooShouldThrowError = false


                               public func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public static func foo() async throws {
                                   calledStaticMethods.insert(.fooCalled)
                                   if fooShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: Single Static Function Protocol, Aync, Throws, No Input Parameters, SomeItem Return Value
    
    var singleStaticFunctionProtocolAsyncThrowsNoInputParametersSomeItemNoReturnValue: String {
        """
        protocol SingleFunction {
           static func foo() async throws -> SomeItem
        }
        """
    }
    
    func testCodeGeneration_singleStaticFunctionProtocolAsyncThrowsNoInputParametersSomeItemNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolAsyncThrowsNoInputParametersSomeItemNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core
                           
                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               // MARK: - Variables to Use as Method Return Values

                               static var fooReturnValue: SomeItem!

                               static var errorToThrow: Error!
                               static var fooShouldThrowError = false


                               func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo() async throws -> SomeItem {
                                   calledStaticMethods.insert(.fooCalled)
                                   if fooShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return fooReturnValue
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleStaticFunctionProtocolAsyncThrowsNoInputParametersSomeItemNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolAsyncThrowsNoInputParametersSomeItemNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core
                           
                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct StaticMethod: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()

                               // MARK: - Variables to Use as Method Return Values

                               public static var fooReturnValue: SomeItem!

                               public static var errorToThrow: Error!
                               public static var fooShouldThrowError = false


                               public func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public static func foo() async throws -> SomeItem {
                                   calledStaticMethods.insert(.fooCalled)
                                   if fooShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return fooReturnValue
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_singleStaticFunctionProtocolAsyncThrowsNoInputParametersSomeItemNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolAsyncThrowsNoInputParametersSomeItemNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true)
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

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               // MARK: - Variables to Use as Method Return Values

                               //swiftlint:disable implicitly_unwrapped_optional
                               static var fooReturnValue: SomeItem!
                               //swiftlint:enable implicitly_unwrapped_optional

                               static var errorToThrow: Error!
                               static var fooShouldThrowError = false


                               func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func foo() async throws -> SomeItem {
                                   calledStaticMethods.insert(.fooCalled)
                                   if fooShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return fooReturnValue
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_singleStaticFunctionProtocolAsyncThrowsNoInputParametersSomeItemNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticFunctionProtocolAsyncThrowsNoInputParametersSomeItemNoReturnValue))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true, public: true)
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

                           public class MockTest: SingleFunction {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct StaticMethod: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let fooCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()

                               // MARK: - Variables to Use as Method Return Values

                               //swiftlint:disable implicitly_unwrapped_optional
                               public static var fooReturnValue: SomeItem!
                               //swiftlint:enable implicitly_unwrapped_optional

                               public static var errorToThrow: Error!
                               public static var fooShouldThrowError = false


                               public func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public static func foo() async throws -> SomeItem {
                                   calledStaticMethods.insert(.fooCalled)
                                   if fooShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return fooReturnValue
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

}
//swiftlint:enable function_body_length file_length
