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
import SwiftSyntaxParser

extension ASTMockGeneratorTests {
    
    // MARK: Single Function Protocol, No Input Parameters, No Return Value
    
    var singleFunctionProtocolNoInputParametersNoReturnValue: String {
        """
        protocol SingleFunction {
           func foo()
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolNoInputParametersNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolNoInputParametersNoReturnValue))
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

                               struct Method: OptionSet {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolNoInputParametersNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolNoInputParametersNoReturnValue))
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

                               struct Method: OptionSet {
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

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    // MARK: Single Function Protocol, 3 Input Parameters, No Return Value
    
    var singleFunctionProtocol3InputParametersNoReturnValue: String {
        """
        protocol SingleFunction {
           func foo(_ a: String, b: Int, c: Bool)
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocol3InputParametersNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocol3InputParametersNoReturnValue))
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

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let fooABCCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocol3InputParametersNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocol3InputParametersNoReturnValue))
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

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let fooABCCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               //swiftlint:disable identifier_name
                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let a = MethodParameter(rawValue: 1 << 0)
                                   static let b = MethodParameter(rawValue: 1 << 1)
                                   static let c = MethodParameter(rawValue: 1 << 2)
                               }
                               //swiftlint:enable identifier_name
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    // MARK: Single Function Protocol, No Input Parameters, Int Return Value
    
    var singleFunctionProtocolNoInputParametersIntReturnValue: String {
        """
        protocol SingleFunction {
           func foo() -> Int
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolNoInputParametersIntReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolNoInputParametersIntReturnValue))
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

                               struct Method: OptionSet {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolNoInputParametersIntReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolNoInputParametersIntReturnValue))
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

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               // MARK: - Variables to Use as Method Return Values

                               //swiftlint:disable implicitly_unwrapped_optional
                               var fooReturnValue: Int!
                               //swiftlint:enable implicitly_unwrapped_optional


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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    // MARK: Single Function Protocol, Optional Void Completion Handler Input Parameter, No Return Value
    
    var singleFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue: String {
        """
        protocol SingleFunction {
            func foo(completion: (() -> Void)?)
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue))
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

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let fooCompletionCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolOptionalVoidCompletionHandlerInputParameterNoReturnValue))
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

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let fooCompletionCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    // MARK: Single Function Protocol, Escaping Result Completion Handler Input Parameter, No Return Value
    
    var singleFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue: String {
        """
        protocol SingleFunction {
            func foo(completionHandler: @escaping (Result<[Item], Error>) -> Void)
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue))
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

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let fooCompletionHandlerCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolEscapingResultVoidCompletionHandlerInputParameterNoReturnValue))
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

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let fooCompletionHandlerCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let itemsCompletionHandler = MethodParameter(rawValue: 1 << 0)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var itemsCompletionHandler: ((Result<[Item], Error>) -> Void)?

                               // MARK: - Variables to Use to Control Completion Handlers

                               //swiftlint:disable identifier_name
                               var shouldCallCompletionHandler = false
                               var itemsCompletionHandlerResult = .failure(MockError)

                               var shouldCallFooCompletionHandlerCompletionHander = false
                               var fooCompletionHandlerCompletionHanderResult: Result<[Item], Error> = .failure(MockError)
                               //swiftlint:enable identifier_name

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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    // MARK: Single Function Protocol, Aync, No Input Parameters, No Return Value
    
    var singleFunctionProtocolAsyncNoInputParametersNoReturnValue: String {
        """
        protocol SingleFunction {
           func foo() async
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolAsyncNoInputParametersNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolAsyncNoInputParametersNoReturnValue))
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

                               struct Method: OptionSet {
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

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolAsyncNoInputParametersNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolAsyncNoInputParametersNoReturnValue))
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

                               struct Method: OptionSet {
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

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    // MARK: Single Function Protocol, Aync, Throws, No Input Parameters, No Return Value
    
    var singleFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue: String {
        """
        protocol SingleFunction {
           func foo() async throws
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue))
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

                               struct Method: OptionSet {
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

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolAsyncThrowsNoInputParametersNoReturnValue))
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

                               struct Method: OptionSet {
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

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    // MARK: Single Function Protocol, Aync, Throws, No Input Parameters, SomeItem Return Value
    
    var singleFunctionProtocolAsyncThrowsNoInputParametersSomeItemNoReturnValue: String {
        """
        protocol SingleFunction {
           func foo() async throws -> SomeItem
        }
        """
    }
    
    func testCodeGeneration_singleFunctionProtocolAsyncThrowsNoInputParametersSomeItemNoReturnValue_swiftlintAwareFALSE_includeTestableImportFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolAsyncThrowsNoInputParametersSomeItemNoReturnValue))
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

                               struct Method: OptionSet {
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

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleFunctionProtocolAsyncThrowsNoInputParametersSomeItemNoReturnValue_swiftlintAwareTRUE_includeTestableImportTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleFunctionProtocolAsyncThrowsNoInputParametersSomeItemNoReturnValue))
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

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let fooCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               // MARK: - Variables to Use as Method Return Values

                               //swiftlint:disable implicitly_unwrapped_optional
                               var fooReturnValue: SomeItem!
                               //swiftlint:enable implicitly_unwrapped_optional

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
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

}
//swiftlint:enable function_body_length file_length
