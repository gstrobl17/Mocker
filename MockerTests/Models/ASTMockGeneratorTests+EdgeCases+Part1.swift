//swiftlint:disable function_body_length file_length
//
//  ASTMockGeneratorTests+EdgeCases+Part1.swift
//  MockerTests
//
//  Created by Greg Strobl on 1/26/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import XCTest
import SwiftSyntax
import SwiftSyntaxParser

extension ASTMockGeneratorTests {
    
    // MARK: Result Completion Handers
    
    var resultCompletionHandersProtocol: String {
        """
        protocol ResultCompletionHandersProtocol {
            func foo1(completionHandler: @escaping (Result<String, Error>) -> Void)
            func foo2(completionHandler: @escaping (Result<[String], Error>) -> Void)
            func foo3(completionHandler: @escaping (Result<[Class], Error>) -> Void)
            func foo4(completionHandler: @escaping (Result<Bool?, Error>) -> Void)
            func foo5(completionHandler: @escaping (Result<(Int, Double, Bool, String), Error>) -> Void)
            func foo6(completionHandler: @escaping (Result<(String, String), Error>) -> Void)
        }
        """
    }
    
    func testCodeGeneration_resultCompletionHandersProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: resultCompletionHandersProtocol))
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

                           class MockTest: ResultCompletionHandersProtocol {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let foo1CompletionHandlerCalled = Method(rawValue: 1 << 0)
                                   static let foo2CompletionHandlerCalled = Method(rawValue: 1 << 1)
                                   static let foo3CompletionHandlerCalled = Method(rawValue: 1 << 2)
                                   static let foo4CompletionHandlerCalled = Method(rawValue: 1 << 3)
                                   static let foo5CompletionHandlerCalled = Method(rawValue: 1 << 4)
                                   static let foo6CompletionHandlerCalled = Method(rawValue: 1 << 5)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let stringCompletionHandler = MethodParameter(rawValue: 1 << 0)
                                   static let stringsCompletionHandler = MethodParameter(rawValue: 1 << 1)
                                   static let classesCompletionHandler = MethodParameter(rawValue: 1 << 2)
                                   static let optionalBoolCompletionHandler = MethodParameter(rawValue: 1 << 3)
                                   static let UNDETERMINED TUPLE NAMETupleCompletionHandler = MethodParameter(rawValue: 1 << 4)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var stringCompletionHandler: ((Result<String, Error>) -> Void)?
                               private(set) var stringsCompletionHandler: ((Result<[String], Error>) -> Void)?
                               private(set) var classesCompletionHandler: ((Result<[Class], Error>) -> Void)?
                               private(set) var optionalBoolCompletionHandler: ((Result<Bool?, Error>) -> Void)?
                               private(set) var UNDETERMINED TUPLE NAMETupleCompletionHandler: ((Result<(Int, Double, Bool, String), Error>) -> Void)?

                               // MARK: - Variables to Use to Control Completion Handlers

                               var shouldCallCompletionHandler = false
                               var stringCompletionHandlerResult = .failure(MockError)
                               var stringsCompletionHandlerResult = .failure(MockError)
                               var classesCompletionHandlerResult = .failure(MockError)
                               var optionalBoolCompletionHandlerResult = .failure(MockError)
                               var UNDETERMINED TUPLE NAMETupleCompletionHandlerResult = .failure(MockError)

                               var shouldCallFoo1CompletionHandlerCompletionHander = false
                               var foo1CompletionHandlerCompletionHanderResult: Result<String, Error> = .failure(MockError)
                               var shouldCallFoo2CompletionHandlerCompletionHander = false
                               var foo2CompletionHandlerCompletionHanderResult: Result<[String], Error> = .failure(MockError)
                               var shouldCallFoo3CompletionHandlerCompletionHander = false
                               var foo3CompletionHandlerCompletionHanderResult: Result<[Class], Error> = .failure(MockError)
                               var shouldCallFoo4CompletionHandlerCompletionHander = false
                               var foo4CompletionHandlerCompletionHanderResult: Result<Bool?, Error> = .failure(MockError)
                               var shouldCallFoo5CompletionHandlerCompletionHander = false
                               var foo5CompletionHandlerCompletionHanderResult: Result<(Int, Double, Bool, String), Error> = .failure(MockError)
                               var shouldCallFoo6CompletionHandlerCompletionHander = false
                               var foo6CompletionHandlerCompletionHanderResult: Result<(String, String), Error> = .failure(MockError)

                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   stringCompletionHandler = nil
                                   stringsCompletionHandler = nil
                                   classesCompletionHandler = nil
                                   optionalBoolCompletionHandler = nil
                                   UNDETERMINED TUPLE NAMETupleCompletionHandler = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo1(completionHandler: @escaping (Result<String, Error>) -> Void) {
                                   calledMethods.insert(.foo1CompletionHandlerCalled)
                                   self.stringCompletionHandler = completionHandler
                                   assignedParameters.insert(.stringCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(stringCompletionHandlerResult)
                                   }
                                   if shouldCallFoo1CompletionHandlerCompletionHander {
                                       completionHandler(foo1CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               func foo2(completionHandler: @escaping (Result<[String], Error>) -> Void) {
                                   calledMethods.insert(.foo2CompletionHandlerCalled)
                                   self.stringsCompletionHandler = completionHandler
                                   assignedParameters.insert(.stringsCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(stringsCompletionHandlerResult)
                                   }
                                   if shouldCallFoo2CompletionHandlerCompletionHander {
                                       completionHandler(foo2CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               func foo3(completionHandler: @escaping (Result<[Class], Error>) -> Void) {
                                   calledMethods.insert(.foo3CompletionHandlerCalled)
                                   self.classesCompletionHandler = completionHandler
                                   assignedParameters.insert(.classesCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(classesCompletionHandlerResult)
                                   }
                                   if shouldCallFoo3CompletionHandlerCompletionHander {
                                       completionHandler(foo3CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               func foo4(completionHandler: @escaping (Result<Bool?, Error>) -> Void) {
                                   calledMethods.insert(.foo4CompletionHandlerCalled)
                                   self.optionalBoolCompletionHandler = completionHandler
                                   assignedParameters.insert(.optionalBoolCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(optionalBoolCompletionHandlerResult)
                                   }
                                   if shouldCallFoo4CompletionHandlerCompletionHander {
                                       completionHandler(foo4CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               func foo5(completionHandler: @escaping (Result<(Int, Double, Bool, String), Error>) -> Void) {
                                   calledMethods.insert(.foo5CompletionHandlerCalled)
                                   self.UNDETERMINED TUPLE NAMETupleCompletionHandler = completionHandler
                                   assignedParameters.insert(.UNDETERMINED TUPLE NAMETupleCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(UNDETERMINED TUPLE NAMETupleCompletionHandlerResult)
                                   }
                                   if shouldCallFoo5CompletionHandlerCompletionHander {
                                       completionHandler(foo5CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               func foo6(completionHandler: @escaping (Result<(String, String), Error>) -> Void) {
                                   calledMethods.insert(.foo6CompletionHandlerCalled)
                                   self.UNDETERMINED TUPLE NAMETupleCompletionHandler = completionHandler
                                   assignedParameters.insert(.UNDETERMINED TUPLE NAMETupleCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(UNDETERMINED TUPLE NAMETupleCompletionHandlerResult)
                                   }
                                   if shouldCallFoo6CompletionHandlerCompletionHander {
                                       completionHandler(foo6CompletionHandlerCompletionHanderResult)
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

                                   if self.contains(.foo1CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo1CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo2CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo2CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo3CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo3CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo4CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo4CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo5CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo5CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo6CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo6CompletionHandlerCalled"
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

                                   if self.contains(.stringCompletionHandler) {
                                       handleFirst()
                                       value += ".stringCompletionHandler"
                                   }
                                   if self.contains(.stringsCompletionHandler) {
                                       handleFirst()
                                       value += ".stringsCompletionHandler"
                                   }
                                   if self.contains(.classesCompletionHandler) {
                                       handleFirst()
                                       value += ".classesCompletionHandler"
                                   }
                                   if self.contains(.optionalBoolCompletionHandler) {
                                       handleFirst()
                                       value += ".optionalBoolCompletionHandler"
                                   }
                                   if self.contains(.UNDETERMINED TUPLE NAMETupleCompletionHandler) {
                                       handleFirst()
                                       value += ".UNDETERMINED TUPLE NAMETupleCompletionHandler"
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
    
    func testCodeGeneration_resultCompletionHandersProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: resultCompletionHandersProtocol))
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

                           class MockTest: ResultCompletionHandersProtocol {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let foo1CompletionHandlerCalled = Method(rawValue: 1 << 0)
                                   static let foo2CompletionHandlerCalled = Method(rawValue: 1 << 1)
                                   static let foo3CompletionHandlerCalled = Method(rawValue: 1 << 2)
                                   static let foo4CompletionHandlerCalled = Method(rawValue: 1 << 3)
                                   static let foo5CompletionHandlerCalled = Method(rawValue: 1 << 4)
                                   static let foo6CompletionHandlerCalled = Method(rawValue: 1 << 5)
                               }
                               private(set) var calledMethods = Method()

                               //swiftlint:disable identifier_name
                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let stringCompletionHandler = MethodParameter(rawValue: 1 << 0)
                                   static let stringsCompletionHandler = MethodParameter(rawValue: 1 << 1)
                                   static let classesCompletionHandler = MethodParameter(rawValue: 1 << 2)
                                   static let optionalBoolCompletionHandler = MethodParameter(rawValue: 1 << 3)
                                   static let UNDETERMINED TUPLE NAMETupleCompletionHandler = MethodParameter(rawValue: 1 << 4)
                               }
                               //swiftlint:enable identifier_name
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var stringCompletionHandler: ((Result<String, Error>) -> Void)?
                               private(set) var stringsCompletionHandler: ((Result<[String], Error>) -> Void)?
                               private(set) var classesCompletionHandler: ((Result<[Class], Error>) -> Void)?
                               private(set) var optionalBoolCompletionHandler: ((Result<Bool?, Error>) -> Void)?
                               private(set) var UNDETERMINED TUPLE NAMETupleCompletionHandler: ((Result<(Int, Double, Bool, String), Error>) -> Void)?

                               // MARK: - Variables to Use to Control Completion Handlers

                               //swiftlint:disable identifier_name
                               var shouldCallCompletionHandler = false
                               var stringCompletionHandlerResult = .failure(MockError)
                               var stringsCompletionHandlerResult = .failure(MockError)
                               var classesCompletionHandlerResult = .failure(MockError)
                               var optionalBoolCompletionHandlerResult = .failure(MockError)
                               var UNDETERMINED TUPLE NAMETupleCompletionHandlerResult = .failure(MockError)

                               var shouldCallFoo1CompletionHandlerCompletionHander = false
                               var foo1CompletionHandlerCompletionHanderResult: Result<String, Error> = .failure(MockError)
                               var shouldCallFoo2CompletionHandlerCompletionHander = false
                               var foo2CompletionHandlerCompletionHanderResult: Result<[String], Error> = .failure(MockError)
                               var shouldCallFoo3CompletionHandlerCompletionHander = false
                               var foo3CompletionHandlerCompletionHanderResult: Result<[Class], Error> = .failure(MockError)
                               var shouldCallFoo4CompletionHandlerCompletionHander = false
                               var foo4CompletionHandlerCompletionHanderResult: Result<Bool?, Error> = .failure(MockError)
                               var shouldCallFoo5CompletionHandlerCompletionHander = false
                               var foo5CompletionHandlerCompletionHanderResult: Result<(Int, Double, Bool, String), Error> = .failure(MockError)
                               var shouldCallFoo6CompletionHandlerCompletionHander = false
                               var foo6CompletionHandlerCompletionHanderResult: Result<(String, String), Error> = .failure(MockError)
                               //swiftlint:enable identifier_name

                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   stringCompletionHandler = nil
                                   stringsCompletionHandler = nil
                                   classesCompletionHandler = nil
                                   optionalBoolCompletionHandler = nil
                                   UNDETERMINED TUPLE NAMETupleCompletionHandler = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo1(completionHandler: @escaping (Result<String, Error>) -> Void) {
                                   calledMethods.insert(.foo1CompletionHandlerCalled)
                                   self.stringCompletionHandler = completionHandler
                                   assignedParameters.insert(.stringCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(stringCompletionHandlerResult)
                                   }
                                   if shouldCallFoo1CompletionHandlerCompletionHander {
                                       completionHandler(foo1CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               func foo2(completionHandler: @escaping (Result<[String], Error>) -> Void) {
                                   calledMethods.insert(.foo2CompletionHandlerCalled)
                                   self.stringsCompletionHandler = completionHandler
                                   assignedParameters.insert(.stringsCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(stringsCompletionHandlerResult)
                                   }
                                   if shouldCallFoo2CompletionHandlerCompletionHander {
                                       completionHandler(foo2CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               func foo3(completionHandler: @escaping (Result<[Class], Error>) -> Void) {
                                   calledMethods.insert(.foo3CompletionHandlerCalled)
                                   self.classesCompletionHandler = completionHandler
                                   assignedParameters.insert(.classesCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(classesCompletionHandlerResult)
                                   }
                                   if shouldCallFoo3CompletionHandlerCompletionHander {
                                       completionHandler(foo3CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               func foo4(completionHandler: @escaping (Result<Bool?, Error>) -> Void) {
                                   calledMethods.insert(.foo4CompletionHandlerCalled)
                                   self.optionalBoolCompletionHandler = completionHandler
                                   assignedParameters.insert(.optionalBoolCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(optionalBoolCompletionHandlerResult)
                                   }
                                   if shouldCallFoo4CompletionHandlerCompletionHander {
                                       completionHandler(foo4CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               func foo5(completionHandler: @escaping (Result<(Int, Double, Bool, String), Error>) -> Void) {
                                   calledMethods.insert(.foo5CompletionHandlerCalled)
                                   self.UNDETERMINED TUPLE NAMETupleCompletionHandler = completionHandler
                                   assignedParameters.insert(.UNDETERMINED TUPLE NAMETupleCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(UNDETERMINED TUPLE NAMETupleCompletionHandlerResult)
                                   }
                                   if shouldCallFoo5CompletionHandlerCompletionHander {
                                       completionHandler(foo5CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               func foo6(completionHandler: @escaping (Result<(String, String), Error>) -> Void) {
                                   calledMethods.insert(.foo6CompletionHandlerCalled)
                                   self.UNDETERMINED TUPLE NAMETupleCompletionHandler = completionHandler
                                   assignedParameters.insert(.UNDETERMINED TUPLE NAMETupleCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(UNDETERMINED TUPLE NAMETupleCompletionHandlerResult)
                                   }
                                   if shouldCallFoo6CompletionHandlerCompletionHander {
                                       completionHandler(foo6CompletionHandlerCompletionHanderResult)
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

                                   if self.contains(.foo1CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo1CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo2CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo2CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo3CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo3CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo4CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo4CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo5CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo5CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo6CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo6CompletionHandlerCalled"
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

                                   if self.contains(.stringCompletionHandler) {
                                       handleFirst()
                                       value += ".stringCompletionHandler"
                                   }
                                   if self.contains(.stringsCompletionHandler) {
                                       handleFirst()
                                       value += ".stringsCompletionHandler"
                                   }
                                   if self.contains(.classesCompletionHandler) {
                                       handleFirst()
                                       value += ".classesCompletionHandler"
                                   }
                                   if self.contains(.optionalBoolCompletionHandler) {
                                       handleFirst()
                                       value += ".optionalBoolCompletionHandler"
                                   }
                                   if self.contains(.UNDETERMINED TUPLE NAMETupleCompletionHandler) {
                                       handleFirst()
                                       value += ".UNDETERMINED TUPLE NAMETupleCompletionHandler"
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
    
    // MARK: Protocol with Throwing Methods
    
    var throwingMethodsProtocol: String {
        """
        protocol ThrowingMethodsProtocol {
            func foo1() throws
            func foo2()
            static func foo3() throws
            static func foo4()
        }
        """
    }
    
    func testCodeGeneration_throwingMethodsProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: throwingMethodsProtocol))
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

                           class MockTest: ThrowingMethodsProtocol {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let foo1Called = Method(rawValue: 1 << 0)
                                   static let foo2Called = Method(rawValue: 1 << 1)
                               }
                               private(set) var calledMethods = Method()

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let foo3Called = StaticMethod(rawValue: 1 << 0)
                                   static let foo4Called = StaticMethod(rawValue: 1 << 1)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               static var errorToThrow: Error!
                               var errorToThrow: Error!
                               var foo1ShouldThrowError = false
                               static var foo3ShouldThrowError = false


                               func reset() {
                                   calledMethods = []
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo1() throws {
                                   calledMethods.insert(.foo1Called)
                                   if foo1ShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                               }

                               func foo2() {
                                   calledMethods.insert(.foo2Called)
                               }

                               static func foo3() throws {
                                   calledStaticMethods.insert(.foo3Called)
                                   if foo3ShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                               }

                               static func foo4() {
                                   calledStaticMethods.insert(.foo4Called)
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

                                   if self.contains(.foo1Called) {
                                       handleFirst()
                                       value += ".foo1Called"
                                   }
                                   if self.contains(.foo2Called) {
                                       handleFirst()
                                       value += ".foo2Called"
                                   }

                                   value += "]"
                                   return value
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

                                   if self.contains(.foo3Called) {
                                       handleFirst()
                                       value += ".foo3Called"
                                   }
                                   if self.contains(.foo4Called) {
                                       handleFirst()
                                       value += ".foo4Called"
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
    
    func testCodeGeneration_throwingMethodsProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: throwingMethodsProtocol))
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

                           class MockTest: ThrowingMethodsProtocol {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let foo1Called = Method(rawValue: 1 << 0)
                                   static let foo2Called = Method(rawValue: 1 << 1)
                               }
                               private(set) var calledMethods = Method()

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let foo3Called = StaticMethod(rawValue: 1 << 0)
                                   static let foo4Called = StaticMethod(rawValue: 1 << 1)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               static var errorToThrow: Error!
                               var errorToThrow: Error!
                               var foo1ShouldThrowError = false
                               static var foo3ShouldThrowError = false


                               func reset() {
                                   calledMethods = []
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo1() throws {
                                   calledMethods.insert(.foo1Called)
                                   if foo1ShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                               }

                               func foo2() {
                                   calledMethods.insert(.foo2Called)
                               }

                               static func foo3() throws {
                                   calledStaticMethods.insert(.foo3Called)
                                   if foo3ShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                               }

                               static func foo4() {
                                   calledStaticMethods.insert(.foo4Called)
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

                                   if self.contains(.foo1Called) {
                                       handleFirst()
                                       value += ".foo1Called"
                                   }
                                   if self.contains(.foo2Called) {
                                       handleFirst()
                                       value += ".foo2Called"
                                   }

                                   value += "]"
                                   return value
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

                                   if self.contains(.foo3Called) {
                                       handleFirst()
                                       value += ".foo3Called"
                                   }
                                   if self.contains(.foo4Called) {
                                       handleFirst()
                                       value += ".foo4Called"
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
    
    // MARK: Protocol with Delegate
    
    var protocolWithDelegate: String {
        """
        protocol ProtocolWithDelegate {
            var delegate: SomeDelegate? { get set }
        }
        """
    }
    
    func testCodeGeneration_protocolWithDelegate_swiftlintAwareFALSE_trackPropertyActivityFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithDelegate))
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

                           class MockTest: ProtocolWithDelegate {

                               // MARK: - Variables for Protocol Conformance

                               var delegate: SomeDelegate?


                               func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_protocolWithDelegate_swiftlintAwareTRUE_trackPropertyActivityFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithDelegate))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
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

                           class MockTest: ProtocolWithDelegate {

                               // MARK: - Variables for Protocol Conformance

                               var delegate: SomeDelegate? //swiftlint:disable:this weak_delegate


                               func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_protocolWithDelegate_swiftlintAwareTRUE_trackPropertyActivityTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithDelegate))
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

                           class MockTest: ProtocolWithDelegate {

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get/set/initialize the properties without registering a method call

                               var _delegate: SomeDelegate? //swiftlint:disable:this weak_delegate

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let delegateGetterCalled = Method(rawValue: 1 << 0)
                                   static let delegateSetterCalled = Method(rawValue: 1 << 1)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let delegateInSetter = MethodParameter(rawValue: 1 << 0)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var delegateInSetter: SomeDelegate?


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   delegateInSetter = nil
                               }

                               // MARK: - Properties for Protocol Conformance

                               var delegate: SomeDelegate? {
                                   get {
                                       calledMethods.insert(.delegateGetterCalled)
                                       return _delegate
                                   }
                                   set {
                                       calledMethods.insert(.delegateSetterCalled)
                                       _delegate = newValue
                                       self.delegateInSetter = newValue
                                       assignedParameters.insert(.delegateInSetter)
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

                                   if self.contains(.delegateGetterCalled) {
                                       handleFirst()
                                       value += ".delegateGetterCalled"
                                   }
                                   if self.contains(.delegateSetterCalled) {
                                       handleFirst()
                                       value += ".delegateSetterCalled"
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

                                   if self.contains(.delegateInSetter) {
                                       handleFirst()
                                       value += ".delegateInSetter"
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
    
    // MARK: Protocol with Long Static Method Name
    
    var protocolWithLongStaticMethodName: String {
        """
        protocol ProtocolWithLongStaticMethodName {
            static func thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarning(_ flag: bool)
        }
        """
    }
    
    func testCodeGeneration_protocolWithLongStaticMethodName_swiftlintAwareFALSE_trackPropertyActivityFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithLongStaticMethodName))
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

                           class MockTest: ProtocolWithLongStaticMethodName {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarningFlagCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               struct StaticMethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let flag = StaticMethodParameter(rawValue: 1 << 0)
                               }
                               private(set) static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) static var flag: bool?


                               func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.flag = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarning(_ flag: bool) {
                                   calledStaticMethods.insert(.thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarningFlagCalled)
                                   self.flag = flag
                                   assignedStaticParameters.insert(.flag)
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

                                   if self.contains(.thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarningFlagCalled) {
                                       handleFirst()
                                       value += ".thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarningFlagCalled"
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

                                   if self.contains(.flag) {
                                       handleFirst()
                                       value += ".flag"
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

    func testCodeGeneration_protocolWithLongStaticMethodName_swiftlintAwareTRUE_trackPropertyActivityTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithLongStaticMethodName))
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

                           class MockTest: ProtocolWithLongStaticMethodName {

                               // MARK: - Variables for Trackings Method Invocation

                               //swiftlint:disable identifier_name
                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarningFlagCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               //swiftlint:enable identifier_name
                               private(set) static var calledStaticMethods = StaticMethod()

                               struct StaticMethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let flag = StaticMethodParameter(rawValue: 1 << 0)
                               }
                               private(set) static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) static var flag: bool?


                               func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.flag = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               static func thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarning(_ flag: bool) {
                                   calledStaticMethods.insert(.thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarningFlagCalled)
                                   self.flag = flag
                                   assignedStaticParameters.insert(.flag)
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

                                   if self.contains(.thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarningFlagCalled) {
                                       handleFirst()
                                       value += ".thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarningFlagCalled"
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

                                   if self.contains(.flag) {
                                       handleFirst()
                                       value += ".flag"
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
    
    // MARK: Protocol with Function with a Lot of Parameters
    
    var protocolWithFunctionWithManyParameters: String {
        """
        protocol ProtocolWithFunctionWithManyParameters {
            func foo1(a: Int, b: Double, c: Bool, d: String, e: [String], f: [Int], g: [Double])
            static func foo2(a: Int, b: Double, c: Bool, d: String, e: [String], f: [Int], g: [Double])
        }
        """
    }
    
    func testCodeGeneration_protocolWithFunctionWithManyParameters_swiftlintAwareFALSE_trackPropertyActivityFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithFunctionWithManyParameters))
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

                           class MockTest: ProtocolWithFunctionWithManyParameters {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let foo1ABCDEFGCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let foo2ABCDEFGCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let a = MethodParameter(rawValue: 1 << 0)
                                   static let b = MethodParameter(rawValue: 1 << 1)
                                   static let c = MethodParameter(rawValue: 1 << 2)
                                   static let d = MethodParameter(rawValue: 1 << 3)
                                   static let e = MethodParameter(rawValue: 1 << 4)
                                   static let f = MethodParameter(rawValue: 1 << 5)
                                   static let g = MethodParameter(rawValue: 1 << 6)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               struct StaticMethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let a = StaticMethodParameter(rawValue: 1 << 0)
                                   static let b = StaticMethodParameter(rawValue: 1 << 1)
                                   static let c = StaticMethodParameter(rawValue: 1 << 2)
                                   static let d = StaticMethodParameter(rawValue: 1 << 3)
                                   static let e = StaticMethodParameter(rawValue: 1 << 4)
                                   static let f = StaticMethodParameter(rawValue: 1 << 5)
                                   static let g = StaticMethodParameter(rawValue: 1 << 6)
                               }
                               private(set) static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var a: Int?
                               private(set) var b: Double?
                               private(set) var c: Bool?
                               private(set) var d: String?
                               private(set) var e: [String]?
                               private(set) var f: [Int]?
                               private(set) var g: [Double]?


                               func reset() {
                                   calledMethods = []
                                   MockTest.calledStaticMethods = []
                                   assignedParameters = []
                                   MockTest.assignedStaticParameters = []
                                   a = nil
                                   b = nil
                                   c = nil
                                   d = nil
                                   e = nil
                                   f = nil
                                   g = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo1(a: Int, b: Double, c: Bool, d: String, e: [String], f: [Int], g: [Double]) {
                                   calledMethods.insert(.foo1ABCDEFGCalled)
                                   self.a = a
                                   assignedParameters.insert(.a)
                                   self.b = b
                                   assignedParameters.insert(.b)
                                   self.c = c
                                   assignedParameters.insert(.c)
                                   self.d = d
                                   assignedParameters.insert(.d)
                                   self.e = e
                                   assignedParameters.insert(.e)
                                   self.f = f
                                   assignedParameters.insert(.f)
                                   self.g = g
                                   assignedParameters.insert(.g)
                               }

                               static func foo2(a: Int, b: Double, c: Bool, d: String, e: [String], f: [Int], g: [Double]) {
                                   calledStaticMethods.insert(.foo2ABCDEFGCalled)
                                   self.a = a
                                   assignedStaticParameters.insert(.a)
                                   self.b = b
                                   assignedStaticParameters.insert(.b)
                                   self.c = c
                                   assignedStaticParameters.insert(.c)
                                   self.d = d
                                   assignedStaticParameters.insert(.d)
                                   self.e = e
                                   assignedStaticParameters.insert(.e)
                                   self.f = f
                                   assignedStaticParameters.insert(.f)
                                   self.g = g
                                   assignedStaticParameters.insert(.g)
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

                                   if self.contains(.foo1ABCDEFGCalled) {
                                       handleFirst()
                                       value += ".foo1ABCDEFGCalled"
                                   }

                                   value += "]"
                                   return value
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

                                   if self.contains(.foo2ABCDEFGCalled) {
                                       handleFirst()
                                       value += ".foo2ABCDEFGCalled"
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
                                   if self.contains(.d) {
                                       handleFirst()
                                       value += ".d"
                                   }
                                   if self.contains(.e) {
                                       handleFirst()
                                       value += ".e"
                                   }
                                   if self.contains(.f) {
                                       handleFirst()
                                       value += ".f"
                                   }
                                   if self.contains(.g) {
                                       handleFirst()
                                       value += ".g"
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
                                   if self.contains(.d) {
                                       handleFirst()
                                       value += ".d"
                                   }
                                   if self.contains(.e) {
                                       handleFirst()
                                       value += ".e"
                                   }
                                   if self.contains(.f) {
                                       handleFirst()
                                       value += ".f"
                                   }
                                   if self.contains(.g) {
                                       handleFirst()
                                       value += ".g"
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

    func testCodeGeneration_protocolWithFunctionWithManyParameters_swiftlintAwareTRUE_trackPropertyActivityTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithFunctionWithManyParameters))
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

                           class MockTest: ProtocolWithFunctionWithManyParameters {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let foo1ABCDEFGCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let foo2ABCDEFGCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               //swiftlint:disable identifier_name
                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let a = MethodParameter(rawValue: 1 << 0)
                                   static let b = MethodParameter(rawValue: 1 << 1)
                                   static let c = MethodParameter(rawValue: 1 << 2)
                                   static let d = MethodParameter(rawValue: 1 << 3)
                                   static let e = MethodParameter(rawValue: 1 << 4)
                                   static let f = MethodParameter(rawValue: 1 << 5)
                                   static let g = MethodParameter(rawValue: 1 << 6)
                               }
                               //swiftlint:enable identifier_name
                               private(set) var assignedParameters = MethodParameter()

                               //swiftlint:disable identifier_name
                               struct StaticMethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let a = StaticMethodParameter(rawValue: 1 << 0)
                                   static let b = StaticMethodParameter(rawValue: 1 << 1)
                                   static let c = StaticMethodParameter(rawValue: 1 << 2)
                                   static let d = StaticMethodParameter(rawValue: 1 << 3)
                                   static let e = StaticMethodParameter(rawValue: 1 << 4)
                                   static let f = StaticMethodParameter(rawValue: 1 << 5)
                                   static let g = StaticMethodParameter(rawValue: 1 << 6)
                               }
                               //swiftlint:enable identifier_name
                               private(set) static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var a: Int?
                               private(set) var b: Double?
                               private(set) var c: Bool?
                               private(set) var d: String?
                               private(set) var e: [String]?
                               private(set) var f: [Int]?
                               private(set) var g: [Double]?


                               func reset() {
                                   calledMethods = []
                                   MockTest.calledStaticMethods = []
                                   assignedParameters = []
                                   MockTest.assignedStaticParameters = []
                                   a = nil
                                   b = nil
                                   c = nil
                                   d = nil
                                   e = nil
                                   f = nil
                                   g = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               //swiftlint:disable:next function_parameter_count
                               func foo1(a: Int, b: Double, c: Bool, d: String, e: [String], f: [Int], g: [Double]) {
                                   calledMethods.insert(.foo1ABCDEFGCalled)
                                   self.a = a
                                   assignedParameters.insert(.a)
                                   self.b = b
                                   assignedParameters.insert(.b)
                                   self.c = c
                                   assignedParameters.insert(.c)
                                   self.d = d
                                   assignedParameters.insert(.d)
                                   self.e = e
                                   assignedParameters.insert(.e)
                                   self.f = f
                                   assignedParameters.insert(.f)
                                   self.g = g
                                   assignedParameters.insert(.g)
                               }

                               //swiftlint:disable:next function_parameter_count
                               static func foo2(a: Int, b: Double, c: Bool, d: String, e: [String], f: [Int], g: [Double]) {
                                   calledStaticMethods.insert(.foo2ABCDEFGCalled)
                                   self.a = a
                                   assignedStaticParameters.insert(.a)
                                   self.b = b
                                   assignedStaticParameters.insert(.b)
                                   self.c = c
                                   assignedStaticParameters.insert(.c)
                                   self.d = d
                                   assignedStaticParameters.insert(.d)
                                   self.e = e
                                   assignedStaticParameters.insert(.e)
                                   self.f = f
                                   assignedStaticParameters.insert(.f)
                                   self.g = g
                                   assignedStaticParameters.insert(.g)
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

                                   if self.contains(.foo1ABCDEFGCalled) {
                                       handleFirst()
                                       value += ".foo1ABCDEFGCalled"
                                   }

                                   value += "]"
                                   return value
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

                                   if self.contains(.foo2ABCDEFGCalled) {
                                       handleFirst()
                                       value += ".foo2ABCDEFGCalled"
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
                                   if self.contains(.d) {
                                       handleFirst()
                                       value += ".d"
                                   }
                                   if self.contains(.e) {
                                       handleFirst()
                                       value += ".e"
                                   }
                                   if self.contains(.f) {
                                       handleFirst()
                                       value += ".f"
                                   }
                                   if self.contains(.g) {
                                       handleFirst()
                                       value += ".g"
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
                                   if self.contains(.d) {
                                       handleFirst()
                                       value += ".d"
                                   }
                                   if self.contains(.e) {
                                       handleFirst()
                                       value += ".e"
                                   }
                                   if self.contains(.f) {
                                       handleFirst()
                                       value += ".f"
                                   }
                                   if self.contains(.g) {
                                       handleFirst()
                                       value += ".g"
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
    
    // MARK: Protocol with Function with a Long Completion Handler Name
    
    var protocolWithFunctionWithLongCompletionHandlerName: String {
        """
        protocol ProtocolWithFunctionWithManyParameters {
            func foo1(completionHandlerToBeCalledWhenDone: @escaping (Result<String, Error>) -> Void)
        }
        """
    }
    
    func testCodeGeneration_protocolWithFunctionWithLongCompletionHandlerName_swiftlintAwareFALSE_trackPropertyActivityFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithFunctionWithLongCompletionHandlerName))
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

                           class MockTest: ProtocolWithFunctionWithManyParameters {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let foo1CompletionHandlerToBeCalledWhenDoneCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let stringCompletionHandlerToBeCalledWhenDone = MethodParameter(rawValue: 1 << 0)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var stringCompletionHandlerToBeCalledWhenDone: ((Result<String, Error>) -> Void)?

                               // MARK: - Variables to Use to Control Completion Handlers

                               var shouldCallCompletionHandlerToBeCalledWhenDone = false
                               var stringCompletionHandlerToBeCalledWhenDoneResult = .failure(MockError)

                               var shouldCallFoo1CompletionHandlerToBeCalledWhenDoneCompletionHander = false
                               var foo1CompletionHandlerToBeCalledWhenDoneCompletionHanderResult: Result<String, Error> = .failure(MockError)

                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   stringCompletionHandlerToBeCalledWhenDone = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo1(completionHandlerToBeCalledWhenDone: @escaping (Result<String, Error>) -> Void) {
                                   calledMethods.insert(.foo1CompletionHandlerToBeCalledWhenDoneCalled)
                                   self.stringCompletionHandlerToBeCalledWhenDone = completionHandlerToBeCalledWhenDone
                                   assignedParameters.insert(.stringCompletionHandlerToBeCalledWhenDone)
                                   if shouldCallCompletionHandlerToBeCalledWhenDone {
                                       completionHandlerToBeCalledWhenDone(stringCompletionHandlerToBeCalledWhenDoneResult)
                                   }
                                   if shouldCallFoo1CompletionHandlerToBeCalledWhenDoneCompletionHander {
                                       completionHandlerToBeCalledWhenDone(foo1CompletionHandlerToBeCalledWhenDoneCompletionHanderResult)
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

                                   if self.contains(.foo1CompletionHandlerToBeCalledWhenDoneCalled) {
                                       handleFirst()
                                       value += ".foo1CompletionHandlerToBeCalledWhenDoneCalled"
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

                                   if self.contains(.stringCompletionHandlerToBeCalledWhenDone) {
                                       handleFirst()
                                       value += ".stringCompletionHandlerToBeCalledWhenDone"
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

    func testCodeGeneration_protocolWithFunctionWithLongCompletionHandlerName_swiftlintAwareTRUE_trackPropertyActivityTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithFunctionWithLongCompletionHandlerName))
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

                           class MockTest: ProtocolWithFunctionWithManyParameters {

                               // MARK: - Variables for Trackings Method Invocation

                               //swiftlint:disable identifier_name
                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let foo1CompletionHandlerToBeCalledWhenDoneCalled = Method(rawValue: 1 << 0)
                               }
                               //swiftlint:enable identifier_name
                               private(set) var calledMethods = Method()

                               //swiftlint:disable identifier_name
                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let stringCompletionHandlerToBeCalledWhenDone = MethodParameter(rawValue: 1 << 0)
                               }
                               //swiftlint:enable identifier_name
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var stringCompletionHandlerToBeCalledWhenDone: ((Result<String, Error>) -> Void)?

                               // MARK: - Variables to Use to Control Completion Handlers

                               //swiftlint:disable identifier_name
                               var shouldCallCompletionHandlerToBeCalledWhenDone = false
                               var stringCompletionHandlerToBeCalledWhenDoneResult = .failure(MockError)

                               var shouldCallFoo1CompletionHandlerToBeCalledWhenDoneCompletionHander = false
                               var foo1CompletionHandlerToBeCalledWhenDoneCompletionHanderResult: Result<String, Error> = .failure(MockError)
                               //swiftlint:enable identifier_name

                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   stringCompletionHandlerToBeCalledWhenDone = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo1(completionHandlerToBeCalledWhenDone: @escaping (Result<String, Error>) -> Void) {
                                   calledMethods.insert(.foo1CompletionHandlerToBeCalledWhenDoneCalled)
                                   self.stringCompletionHandlerToBeCalledWhenDone = completionHandlerToBeCalledWhenDone
                                   assignedParameters.insert(.stringCompletionHandlerToBeCalledWhenDone)
                                   if shouldCallCompletionHandlerToBeCalledWhenDone {
                                       completionHandlerToBeCalledWhenDone(stringCompletionHandlerToBeCalledWhenDoneResult)
                                   }
                                   if shouldCallFoo1CompletionHandlerToBeCalledWhenDoneCompletionHander {
                                       completionHandlerToBeCalledWhenDone(foo1CompletionHandlerToBeCalledWhenDoneCompletionHanderResult)
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

                                   if self.contains(.foo1CompletionHandlerToBeCalledWhenDoneCalled) {
                                       handleFirst()
                                       value += ".foo1CompletionHandlerToBeCalledWhenDoneCalled"
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

                                   if self.contains(.stringCompletionHandlerToBeCalledWhenDone) {
                                       handleFirst()
                                       value += ".stringCompletionHandlerToBeCalledWhenDone"
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
    
    // MARK: Protocol with Function with a Result Completion Handler With a Long Type Name
}
//swiftlint:enable function_body_length file_length
