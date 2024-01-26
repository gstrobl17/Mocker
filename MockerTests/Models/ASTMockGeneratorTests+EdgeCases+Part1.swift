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
}
//swiftlint:enable function_body_length file_length
