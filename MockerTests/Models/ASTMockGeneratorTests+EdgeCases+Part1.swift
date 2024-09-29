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

extension ASTMockGeneratorTests {
    
    // MARK: Result Completion Handers
    
    var resultCompletionHandersProtocol: String {
        """
        protocol ResultCompletionHandersProtocol {
            func foo1(completionHandler: @escaping (Result<String, any Error>) -> Void)
            func foo2(completionHandler: @escaping (Result<[String], some Error>) -> Void)
            func foo3(completionHandler: @escaping (Result<[Class], Error>) -> Void)
            func foo4(completionHandler: @escaping (Result<Bool?, Error>) -> Void)
            func foo5(completionHandler: @escaping (Result<(Int, Double, Bool, String), Error>) -> Void)
            func foo6(completionHandler: @escaping (Result<(String, String), Error>) -> Void)
            func foo7(completionHandler: @escaping (Result<any SomeType, any Error>) -> Void)
            func foo8(completionHandler: @escaping (Result<some SomeType, any Error>) -> Void)
            func foo9(completionHandler: @escaping (Result<(any SomeType)?, any Error>) -> Void)
            func foo10(completionHandler: @escaping (Result<[any Boss], any Error>) -> Void)
            func foo11(completionHandler: @escaping (Result<[some SomeType], any Error>) -> Void)
        }
        """
    }
    
    func testCodeGeneration_resultCompletionHandersProtocol_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: resultCompletionHandersProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           class MockTest: ResultCompletionHandersProtocol {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let foo1CompletionHandlerCalled = Method(rawValue: 1 << 0)
                                   static let foo2CompletionHandlerCalled = Method(rawValue: 1 << 1)
                                   static let foo3CompletionHandlerCalled = Method(rawValue: 1 << 2)
                                   static let foo4CompletionHandlerCalled = Method(rawValue: 1 << 3)
                                   static let foo5CompletionHandlerCalled = Method(rawValue: 1 << 4)
                                   static let foo6CompletionHandlerCalled = Method(rawValue: 1 << 5)
                                   static let foo7CompletionHandlerCalled = Method(rawValue: 1 << 6)
                                   static let foo8CompletionHandlerCalled = Method(rawValue: 1 << 7)
                                   static let foo9CompletionHandlerCalled = Method(rawValue: 1 << 8)
                                   static let foo10CompletionHandlerCalled = Method(rawValue: 1 << 9)
                                   static let foo11CompletionHandlerCalled = Method(rawValue: 1 << 10)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let stringCompletionHandler = MethodParameter(rawValue: 1 << 0)
                                   static let stringsCompletionHandler = MethodParameter(rawValue: 1 << 1)
                                   static let classesCompletionHandler = MethodParameter(rawValue: 1 << 2)
                                   static let optionalBoolCompletionHandler = MethodParameter(rawValue: 1 << 3)
                                   static let UNDETERMINED TUPLE NAMETupleCompletionHandler = MethodParameter(rawValue: 1 << 4)
                                   static let anySomeTypeCompletionHandler = MethodParameter(rawValue: 1 << 5)
                                   static let someSomeTypeCompletionHandler = MethodParameter(rawValue: 1 << 6)
                                   static let optionalAnySomeTypeCompletionHandler = MethodParameter(rawValue: 1 << 7)
                                   static let anyBossesCompletionHandler = MethodParameter(rawValue: 1 << 8)
                                   static let someSomeTypesCompletionHandler = MethodParameter(rawValue: 1 << 9)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var stringCompletionHandler: ((Result<String, any Error>) -> Void)?
                               private(set) var stringsCompletionHandler: ((Result<[String], some Error>) -> Void)?
                               private(set) var classesCompletionHandler: ((Result<[Class], Error>) -> Void)?
                               private(set) var optionalBoolCompletionHandler: ((Result<Bool?, Error>) -> Void)?
                               private(set) var UNDETERMINED TUPLE NAMETupleCompletionHandler: ((Result<(Int, Double, Bool, String), Error>) -> Void)?
                               private(set) var anySomeTypeCompletionHandler: ((Result<any SomeType, any Error>) -> Void)?
                               private(set) var someSomeTypeCompletionHandler: ((Result<some SomeType, any Error>) -> Void)?
                               private(set) var optionalAnySomeTypeCompletionHandler: ((Result<(any SomeType)?, any Error>) -> Void)?
                               private(set) var anyBossesCompletionHandler: ((Result<[any Boss], any Error>) -> Void)?
                               private(set) var someSomeTypesCompletionHandler: ((Result<[some SomeType], any Error>) -> Void)?

                               // MARK: - Variables to Use to Control Completion Handlers

                               var shouldCallCompletionHandler = false
                               var stringCompletionHandlerResult = .failure(MockError)
                               var stringsCompletionHandlerResult = .failure(MockError)
                               var classesCompletionHandlerResult = .failure(MockError)
                               var optionalBoolCompletionHandlerResult = .failure(MockError)
                               var UNDETERMINED TUPLE NAMETupleCompletionHandlerResult = .failure(MockError)
                               var anySomeTypeCompletionHandlerResult = .failure(MockError)
                               var someSomeTypeCompletionHandlerResult = .failure(MockError)
                               var optionalAnySomeTypeCompletionHandlerResult = .failure(MockError)
                               var anyBossesCompletionHandlerResult = .failure(MockError)
                               var someSomeTypesCompletionHandlerResult = .failure(MockError)

                               var shouldCallFoo1CompletionHandlerCompletionHander = false
                               var foo1CompletionHandlerCompletionHanderResult: Result<String, any Error> = .failure(MockError)
                               var shouldCallFoo2CompletionHandlerCompletionHander = false
                               var foo2CompletionHandlerCompletionHanderResult: Result<[String], some Error> = .failure(MockError)
                               var shouldCallFoo3CompletionHandlerCompletionHander = false
                               var foo3CompletionHandlerCompletionHanderResult: Result<[Class], Error> = .failure(MockError)
                               var shouldCallFoo4CompletionHandlerCompletionHander = false
                               var foo4CompletionHandlerCompletionHanderResult: Result<Bool?, Error> = .failure(MockError)
                               var shouldCallFoo5CompletionHandlerCompletionHander = false
                               var foo5CompletionHandlerCompletionHanderResult: Result<(Int, Double, Bool, String), Error> = .failure(MockError)
                               var shouldCallFoo6CompletionHandlerCompletionHander = false
                               var foo6CompletionHandlerCompletionHanderResult: Result<(String, String), Error> = .failure(MockError)
                               var shouldCallFoo7CompletionHandlerCompletionHander = false
                               var foo7CompletionHandlerCompletionHanderResult: Result<any SomeType, any Error> = .failure(MockError)
                               var shouldCallFoo8CompletionHandlerCompletionHander = false
                               var foo8CompletionHandlerCompletionHanderResult: Result<some SomeType, any Error> = .failure(MockError)
                               var shouldCallFoo9CompletionHandlerCompletionHander = false
                               var foo9CompletionHandlerCompletionHanderResult: Result<(any SomeType)?, any Error> = .failure(MockError)
                               var shouldCallFoo10CompletionHandlerCompletionHander = false
                               var foo10CompletionHandlerCompletionHanderResult: Result<[any Boss], any Error> = .failure(MockError)
                               var shouldCallFoo11CompletionHandlerCompletionHander = false
                               var foo11CompletionHandlerCompletionHanderResult: Result<[some SomeType], any Error> = .failure(MockError)

                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   stringCompletionHandler = nil
                                   stringsCompletionHandler = nil
                                   classesCompletionHandler = nil
                                   optionalBoolCompletionHandler = nil
                                   UNDETERMINED TUPLE NAMETupleCompletionHandler = nil
                                   anySomeTypeCompletionHandler = nil
                                   someSomeTypeCompletionHandler = nil
                                   optionalAnySomeTypeCompletionHandler = nil
                                   anyBossesCompletionHandler = nil
                                   someSomeTypesCompletionHandler = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func foo1(completionHandler: @escaping (Result<String, any Error>) -> Void) {
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

                               func foo2(completionHandler: @escaping (Result<[String], some Error>) -> Void) {
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

                               func foo7(completionHandler: @escaping (Result<any SomeType, any Error>) -> Void) {
                                   calledMethods.insert(.foo7CompletionHandlerCalled)
                                   self.anySomeTypeCompletionHandler = completionHandler
                                   assignedParameters.insert(.anySomeTypeCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(anySomeTypeCompletionHandlerResult)
                                   }
                                   if shouldCallFoo7CompletionHandlerCompletionHander {
                                       completionHandler(foo7CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               func foo8(completionHandler: @escaping (Result<some SomeType, any Error>) -> Void) {
                                   calledMethods.insert(.foo8CompletionHandlerCalled)
                                   self.someSomeTypeCompletionHandler = completionHandler
                                   assignedParameters.insert(.someSomeTypeCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(someSomeTypeCompletionHandlerResult)
                                   }
                                   if shouldCallFoo8CompletionHandlerCompletionHander {
                                       completionHandler(foo8CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               func foo9(completionHandler: @escaping (Result<(any SomeType)?, any Error>) -> Void) {
                                   calledMethods.insert(.foo9CompletionHandlerCalled)
                                   self.optionalAnySomeTypeCompletionHandler = completionHandler
                                   assignedParameters.insert(.optionalAnySomeTypeCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(optionalAnySomeTypeCompletionHandlerResult)
                                   }
                                   if shouldCallFoo9CompletionHandlerCompletionHander {
                                       completionHandler(foo9CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               func foo10(completionHandler: @escaping (Result<[any Boss], any Error>) -> Void) {
                                   calledMethods.insert(.foo10CompletionHandlerCalled)
                                   self.anyBossesCompletionHandler = completionHandler
                                   assignedParameters.insert(.anyBossesCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(anyBossesCompletionHandlerResult)
                                   }
                                   if shouldCallFoo10CompletionHandlerCompletionHander {
                                       completionHandler(foo10CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               func foo11(completionHandler: @escaping (Result<[some SomeType], any Error>) -> Void) {
                                   calledMethods.insert(.foo11CompletionHandlerCalled)
                                   self.someSomeTypesCompletionHandler = completionHandler
                                   assignedParameters.insert(.someSomeTypesCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(someSomeTypesCompletionHandlerResult)
                                   }
                                   if shouldCallFoo11CompletionHandlerCompletionHander {
                                       completionHandler(foo11CompletionHandlerCompletionHanderResult)
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
                                   if self.contains(.foo7CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo7CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo8CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo8CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo9CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo9CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo10CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo10CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo11CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo11CompletionHandlerCalled"
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
                                   if self.contains(.anySomeTypeCompletionHandler) {
                                       handleFirst()
                                       value += ".anySomeTypeCompletionHandler"
                                   }
                                   if self.contains(.someSomeTypeCompletionHandler) {
                                       handleFirst()
                                       value += ".someSomeTypeCompletionHandler"
                                   }
                                   if self.contains(.optionalAnySomeTypeCompletionHandler) {
                                       handleFirst()
                                       value += ".optionalAnySomeTypeCompletionHandler"
                                   }
                                   if self.contains(.anyBossesCompletionHandler) {
                                       handleFirst()
                                       value += ".anyBossesCompletionHandler"
                                   }
                                   if self.contains(.someSomeTypesCompletionHandler) {
                                       handleFirst()
                                       value += ".someSomeTypesCompletionHandler"
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
    
    func testCodeGeneration_resultCompletionHandersProtocol_trackPropertyActivityFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: resultCompletionHandersProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public class MockTest: ResultCompletionHandersProtocol {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let foo1CompletionHandlerCalled = Method(rawValue: 1 << 0)
                                   public static let foo2CompletionHandlerCalled = Method(rawValue: 1 << 1)
                                   public static let foo3CompletionHandlerCalled = Method(rawValue: 1 << 2)
                                   public static let foo4CompletionHandlerCalled = Method(rawValue: 1 << 3)
                                   public static let foo5CompletionHandlerCalled = Method(rawValue: 1 << 4)
                                   public static let foo6CompletionHandlerCalled = Method(rawValue: 1 << 5)
                                   public static let foo7CompletionHandlerCalled = Method(rawValue: 1 << 6)
                                   public static let foo8CompletionHandlerCalled = Method(rawValue: 1 << 7)
                                   public static let foo9CompletionHandlerCalled = Method(rawValue: 1 << 8)
                                   public static let foo10CompletionHandlerCalled = Method(rawValue: 1 << 9)
                                   public static let foo11CompletionHandlerCalled = Method(rawValue: 1 << 10)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let stringCompletionHandler = MethodParameter(rawValue: 1 << 0)
                                   public static let stringsCompletionHandler = MethodParameter(rawValue: 1 << 1)
                                   public static let classesCompletionHandler = MethodParameter(rawValue: 1 << 2)
                                   public static let optionalBoolCompletionHandler = MethodParameter(rawValue: 1 << 3)
                                   public static let UNDETERMINED TUPLE NAMETupleCompletionHandler = MethodParameter(rawValue: 1 << 4)
                                   public static let anySomeTypeCompletionHandler = MethodParameter(rawValue: 1 << 5)
                                   public static let someSomeTypeCompletionHandler = MethodParameter(rawValue: 1 << 6)
                                   public static let optionalAnySomeTypeCompletionHandler = MethodParameter(rawValue: 1 << 7)
                                   public static let anyBossesCompletionHandler = MethodParameter(rawValue: 1 << 8)
                                   public static let someSomeTypesCompletionHandler = MethodParameter(rawValue: 1 << 9)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var stringCompletionHandler: ((Result<String, any Error>) -> Void)?
                               private(set) public var stringsCompletionHandler: ((Result<[String], some Error>) -> Void)?
                               private(set) public var classesCompletionHandler: ((Result<[Class], Error>) -> Void)?
                               private(set) public var optionalBoolCompletionHandler: ((Result<Bool?, Error>) -> Void)?
                               private(set) public var UNDETERMINED TUPLE NAMETupleCompletionHandler: ((Result<(Int, Double, Bool, String), Error>) -> Void)?
                               private(set) public var anySomeTypeCompletionHandler: ((Result<any SomeType, any Error>) -> Void)?
                               private(set) public var someSomeTypeCompletionHandler: ((Result<some SomeType, any Error>) -> Void)?
                               private(set) public var optionalAnySomeTypeCompletionHandler: ((Result<(any SomeType)?, any Error>) -> Void)?
                               private(set) public var anyBossesCompletionHandler: ((Result<[any Boss], any Error>) -> Void)?
                               private(set) public var someSomeTypesCompletionHandler: ((Result<[some SomeType], any Error>) -> Void)?

                               // MARK: - Variables to Use to Control Completion Handlers

                               public var shouldCallCompletionHandler = false
                               public var stringCompletionHandlerResult = .failure(MockError)
                               public var stringsCompletionHandlerResult = .failure(MockError)
                               public var classesCompletionHandlerResult = .failure(MockError)
                               public var optionalBoolCompletionHandlerResult = .failure(MockError)
                               public var UNDETERMINED TUPLE NAMETupleCompletionHandlerResult = .failure(MockError)
                               public var anySomeTypeCompletionHandlerResult = .failure(MockError)
                               public var someSomeTypeCompletionHandlerResult = .failure(MockError)
                               public var optionalAnySomeTypeCompletionHandlerResult = .failure(MockError)
                               public var anyBossesCompletionHandlerResult = .failure(MockError)
                               public var someSomeTypesCompletionHandlerResult = .failure(MockError)

                               public var shouldCallFoo1CompletionHandlerCompletionHander = false
                               public var foo1CompletionHandlerCompletionHanderResult: Result<String, any Error> = .failure(MockError)
                               public var shouldCallFoo2CompletionHandlerCompletionHander = false
                               public var foo2CompletionHandlerCompletionHanderResult: Result<[String], some Error> = .failure(MockError)
                               public var shouldCallFoo3CompletionHandlerCompletionHander = false
                               public var foo3CompletionHandlerCompletionHanderResult: Result<[Class], Error> = .failure(MockError)
                               public var shouldCallFoo4CompletionHandlerCompletionHander = false
                               public var foo4CompletionHandlerCompletionHanderResult: Result<Bool?, Error> = .failure(MockError)
                               public var shouldCallFoo5CompletionHandlerCompletionHander = false
                               public var foo5CompletionHandlerCompletionHanderResult: Result<(Int, Double, Bool, String), Error> = .failure(MockError)
                               public var shouldCallFoo6CompletionHandlerCompletionHander = false
                               public var foo6CompletionHandlerCompletionHanderResult: Result<(String, String), Error> = .failure(MockError)
                               public var shouldCallFoo7CompletionHandlerCompletionHander = false
                               public var foo7CompletionHandlerCompletionHanderResult: Result<any SomeType, any Error> = .failure(MockError)
                               public var shouldCallFoo8CompletionHandlerCompletionHander = false
                               public var foo8CompletionHandlerCompletionHanderResult: Result<some SomeType, any Error> = .failure(MockError)
                               public var shouldCallFoo9CompletionHandlerCompletionHander = false
                               public var foo9CompletionHandlerCompletionHanderResult: Result<(any SomeType)?, any Error> = .failure(MockError)
                               public var shouldCallFoo10CompletionHandlerCompletionHander = false
                               public var foo10CompletionHandlerCompletionHanderResult: Result<[any Boss], any Error> = .failure(MockError)
                               public var shouldCallFoo11CompletionHandlerCompletionHander = false
                               public var foo11CompletionHandlerCompletionHanderResult: Result<[some SomeType], any Error> = .failure(MockError)

                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   stringCompletionHandler = nil
                                   stringsCompletionHandler = nil
                                   classesCompletionHandler = nil
                                   optionalBoolCompletionHandler = nil
                                   UNDETERMINED TUPLE NAMETupleCompletionHandler = nil
                                   anySomeTypeCompletionHandler = nil
                                   someSomeTypeCompletionHandler = nil
                                   optionalAnySomeTypeCompletionHandler = nil
                                   anyBossesCompletionHandler = nil
                                   someSomeTypesCompletionHandler = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo1(completionHandler: @escaping (Result<String, any Error>) -> Void) {
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

                               public func foo2(completionHandler: @escaping (Result<[String], some Error>) -> Void) {
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

                               public func foo3(completionHandler: @escaping (Result<[Class], Error>) -> Void) {
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

                               public func foo4(completionHandler: @escaping (Result<Bool?, Error>) -> Void) {
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

                               public func foo5(completionHandler: @escaping (Result<(Int, Double, Bool, String), Error>) -> Void) {
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

                               public func foo6(completionHandler: @escaping (Result<(String, String), Error>) -> Void) {
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

                               public func foo7(completionHandler: @escaping (Result<any SomeType, any Error>) -> Void) {
                                   calledMethods.insert(.foo7CompletionHandlerCalled)
                                   self.anySomeTypeCompletionHandler = completionHandler
                                   assignedParameters.insert(.anySomeTypeCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(anySomeTypeCompletionHandlerResult)
                                   }
                                   if shouldCallFoo7CompletionHandlerCompletionHander {
                                       completionHandler(foo7CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               public func foo8(completionHandler: @escaping (Result<some SomeType, any Error>) -> Void) {
                                   calledMethods.insert(.foo8CompletionHandlerCalled)
                                   self.someSomeTypeCompletionHandler = completionHandler
                                   assignedParameters.insert(.someSomeTypeCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(someSomeTypeCompletionHandlerResult)
                                   }
                                   if shouldCallFoo8CompletionHandlerCompletionHander {
                                       completionHandler(foo8CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               public func foo9(completionHandler: @escaping (Result<(any SomeType)?, any Error>) -> Void) {
                                   calledMethods.insert(.foo9CompletionHandlerCalled)
                                   self.optionalAnySomeTypeCompletionHandler = completionHandler
                                   assignedParameters.insert(.optionalAnySomeTypeCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(optionalAnySomeTypeCompletionHandlerResult)
                                   }
                                   if shouldCallFoo9CompletionHandlerCompletionHander {
                                       completionHandler(foo9CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               public func foo10(completionHandler: @escaping (Result<[any Boss], any Error>) -> Void) {
                                   calledMethods.insert(.foo10CompletionHandlerCalled)
                                   self.anyBossesCompletionHandler = completionHandler
                                   assignedParameters.insert(.anyBossesCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(anyBossesCompletionHandlerResult)
                                   }
                                   if shouldCallFoo10CompletionHandlerCompletionHander {
                                       completionHandler(foo10CompletionHandlerCompletionHanderResult)
                                   }
                               }

                               public func foo11(completionHandler: @escaping (Result<[some SomeType], any Error>) -> Void) {
                                   calledMethods.insert(.foo11CompletionHandlerCalled)
                                   self.someSomeTypesCompletionHandler = completionHandler
                                   assignedParameters.insert(.someSomeTypesCompletionHandler)
                                   if shouldCallCompletionHandler {
                                       completionHandler(someSomeTypesCompletionHandlerResult)
                                   }
                                   if shouldCallFoo11CompletionHandlerCompletionHander {
                                       completionHandler(foo11CompletionHandlerCompletionHanderResult)
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
                                   if self.contains(.foo7CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo7CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo8CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo8CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo9CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo9CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo10CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo10CompletionHandlerCalled"
                                   }
                                   if self.contains(.foo11CompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".foo11CompletionHandlerCalled"
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
                                   if self.contains(.anySomeTypeCompletionHandler) {
                                       handleFirst()
                                       value += ".anySomeTypeCompletionHandler"
                                   }
                                   if self.contains(.someSomeTypeCompletionHandler) {
                                       handleFirst()
                                       value += ".someSomeTypeCompletionHandler"
                                   }
                                   if self.contains(.optionalAnySomeTypeCompletionHandler) {
                                       handleFirst()
                                       value += ".optionalAnySomeTypeCompletionHandler"
                                   }
                                   if self.contains(.anyBossesCompletionHandler) {
                                       handleFirst()
                                       value += ".anyBossesCompletionHandler"
                                   }
                                   if self.contains(.someSomeTypesCompletionHandler) {
                                       handleFirst()
                                       value += ".someSomeTypesCompletionHandler"
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
    
    // MARK: - Protocol with Throwing Methods
    
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
    
    func testCodeGeneration_throwingMethodsProtocol_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: throwingMethodsProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           class MockTest: ThrowingMethodsProtocol {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let foo1Called = Method(rawValue: 1 << 0)
                                   static let foo2Called = Method(rawValue: 1 << 1)
                               }
                               private(set) var calledMethods = Method()

                               struct StaticMethod: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let foo3Called = StaticMethod(rawValue: 1 << 0)
                                   static let foo4Called = StaticMethod(rawValue: 1 << 1)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               static var errorToThrow: (any Error)!
                               var errorToThrow: (any Error)!
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

                           \(expectedCustomReflectableWithCalledMethodsAndCalledStaticMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_throwingMethodsProtocol_trackPropertyActivityFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: throwingMethodsProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public class MockTest: ThrowingMethodsProtocol {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let foo1Called = Method(rawValue: 1 << 0)
                                   public static let foo2Called = Method(rawValue: 1 << 1)
                               }
                               private(set) public var calledMethods = Method()

                               public struct StaticMethod: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let foo3Called = StaticMethod(rawValue: 1 << 0)
                                   public static let foo4Called = StaticMethod(rawValue: 1 << 1)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()

                               public static var errorToThrow: (any Error)!
                               public var errorToThrow: (any Error)!
                               public var foo1ShouldThrowError = false
                               public static var foo3ShouldThrowError = false


                               public func reset() {
                                   calledMethods = []
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo1() throws {
                                   calledMethods.insert(.foo1Called)
                                   if foo1ShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                               }

                               public func foo2() {
                                   calledMethods.insert(.foo2Called)
                               }

                               public static func foo3() throws {
                                   calledStaticMethods.insert(.foo3Called)
                                   if foo3ShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                               }

                               public static func foo4() {
                                   calledStaticMethods.insert(.foo4Called)
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

                           \(expectedPublicCustomReflectableWithCalledMethodsAndCalledStaticMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    // MARK: - Protocol with Delegate
    
    var protocolWithDelegate: String {
        """
        protocol ProtocolWithDelegate {
            var delegate: SomeDelegate? { get set }
        }
        """
    }
    
    func testCodeGeneration_protocolWithDelegate_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithDelegate))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

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
    
    func testCodeGeneration_protocolWithDelegate_trackPropertyActivityFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithDelegate))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public class MockTest: ProtocolWithDelegate {
                           
                               public init() { }

                               // MARK: - Variables for Protocol Conformance

                               public var delegate: SomeDelegate?


                               public func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    // MARK: - Protocol with Any Delegate
    
    var protocolWithAnyDelegate: String {
        """
        protocol ProtocolWithDelegate {
            var delegate: (any SomeDelegate)? { get set }
        }
        """
    }
    
    func testCodeGeneration_protocolWithAnyDelegate_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithAnyDelegate))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           class MockTest: ProtocolWithDelegate {

                               // MARK: - Variables for Protocol Conformance

                               var delegate: (any SomeDelegate)?


                               func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_protocolWithAnyDelegate_trackPropertyActivityFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithAnyDelegate))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public class MockTest: ProtocolWithDelegate {
                           
                               public init() { }

                               // MARK: - Variables for Protocol Conformance

                               public var delegate: (any SomeDelegate)?


                               public func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: - Protocol with Long Static Method Name
    
    var protocolWithLongStaticMethodName: String {
        """
        protocol ProtocolWithLongStaticMethodName {
            static func thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarning(_ flag: bool)
        }
        """
    }
    
    func testCodeGeneration_protocolWithLongStaticMethodName_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithLongStaticMethodName))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           class MockTest: ProtocolWithLongStaticMethodName {

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarningFlagCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               struct StaticMethodParameter: OptionSet, Sendable {
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

                           \(expectedCustomReflectableWithCalledStaticMethodsAndAssignedStaticParameters)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_protocolWithLongStaticMethodName_trackPropertyActivityFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithLongStaticMethodName))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public class MockTest: ProtocolWithLongStaticMethodName {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct StaticMethod: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarningFlagCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()

                               public struct StaticMethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let flag = StaticMethodParameter(rawValue: 1 << 0)
                               }
                               private(set) public static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public static var flag: bool?


                               public func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.flag = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public static func thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarning(_ flag: bool) {
                                   calledStaticMethods.insert(.thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarningFlagCalled)
                                   self.flag = flag
                                   assignedStaticParameters.insert(.flag)
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

                                   if self.contains(.thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarningFlagCalled) {
                                       handleFirst()
                                       value += ".thisIsAVeryLongMethodNameThatWillTriggerASwiftlintWarningFlagCalled"
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

                                   if self.contains(.flag) {
                                       handleFirst()
                                       value += ".flag"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedPublicCustomReflectableWithCalledStaticMethodsAndAssignedStaticParameters)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: - Protocol with Function with a Lot of Parameters
    
    var protocolWithFunctionWithManyParameters: String {
        """
        protocol ProtocolWithFunctionWithManyParameters {
            func foo1(a: Int, b: Double, c: Bool, d: String, e: [String], f: [Int], g: [Double])
            static func foo2(a: Int, b: Double, c: Bool, d: String, e: [String], f: [Int], g: [Double])
        }
        """
    }
    
    func testCodeGeneration_protocolWithFunctionWithManyParameters_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithFunctionWithManyParameters))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           class MockTest: ProtocolWithFunctionWithManyParameters {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let foo1ABCDEFGCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct StaticMethod: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let foo2ABCDEFGCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               struct MethodParameter: OptionSet, Sendable {
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

                               struct StaticMethodParameter: OptionSet, Sendable {
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

                           \(expectedCustomReflectableWithAllMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_protocolWithFunctionWithManyParameters_trackPropertyActivityFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithFunctionWithManyParameters))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public class MockTest: ProtocolWithFunctionWithManyParameters {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let foo1ABCDEFGCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()

                               public struct StaticMethod: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let foo2ABCDEFGCalled = StaticMethod(rawValue: 1 << 0)
                               }
                               private(set) public static var calledStaticMethods = StaticMethod()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let a = MethodParameter(rawValue: 1 << 0)
                                   public static let b = MethodParameter(rawValue: 1 << 1)
                                   public static let c = MethodParameter(rawValue: 1 << 2)
                                   public static let d = MethodParameter(rawValue: 1 << 3)
                                   public static let e = MethodParameter(rawValue: 1 << 4)
                                   public static let f = MethodParameter(rawValue: 1 << 5)
                                   public static let g = MethodParameter(rawValue: 1 << 6)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               public struct StaticMethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let a = StaticMethodParameter(rawValue: 1 << 0)
                                   public static let b = StaticMethodParameter(rawValue: 1 << 1)
                                   public static let c = StaticMethodParameter(rawValue: 1 << 2)
                                   public static let d = StaticMethodParameter(rawValue: 1 << 3)
                                   public static let e = StaticMethodParameter(rawValue: 1 << 4)
                                   public static let f = StaticMethodParameter(rawValue: 1 << 5)
                                   public static let g = StaticMethodParameter(rawValue: 1 << 6)
                               }
                               private(set) public static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var a: Int?
                               private(set) public var b: Double?
                               private(set) public var c: Bool?
                               private(set) public var d: String?
                               private(set) public var e: [String]?
                               private(set) public var f: [Int]?
                               private(set) public var g: [Double]?


                               public func reset() {
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

                               public func foo1(a: Int, b: Double, c: Bool, d: String, e: [String], f: [Int], g: [Double]) {
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

                               public static func foo2(a: Int, b: Double, c: Bool, d: String, e: [String], f: [Int], g: [Double]) {
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

                                   if self.contains(.foo1ABCDEFGCalled) {
                                       handleFirst()
                                       value += ".foo1ABCDEFGCalled"
                                   }

                                   value += "]"
                                   return value
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

                                   if self.contains(.foo2ABCDEFGCalled) {
                                       handleFirst()
                                       value += ".foo2ABCDEFGCalled"
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

                           \(expectedPublicCustomReflectableWithAllMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    // MARK: - Protocol with Function with a Long Completion Handler Name
    
    var protocolWithFunctionWithLongCompletionHandlerName: String {
        """
        protocol ProtocolWithFunctionWithManyParameters {
            func foo1(completionHandlerToBeCalledWhenDone: @escaping (Result<String, Error>) -> Void)
        }
        """
    }
    
    func testCodeGeneration_protocolWithFunctionWithLongCompletionHandlerName_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithFunctionWithLongCompletionHandlerName))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           class MockTest: ProtocolWithFunctionWithManyParameters {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let foo1CompletionHandlerToBeCalledWhenDoneCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
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

                           \(expectedCustomReflectableWithCalledMethodsAndAssignedParameters)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_protocolWithFunctionWithLongCompletionHandlerName_trackPropertyActivityFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: protocolWithFunctionWithLongCompletionHandlerName))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public class MockTest: ProtocolWithFunctionWithManyParameters {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let foo1CompletionHandlerToBeCalledWhenDoneCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let stringCompletionHandlerToBeCalledWhenDone = MethodParameter(rawValue: 1 << 0)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var stringCompletionHandlerToBeCalledWhenDone: ((Result<String, Error>) -> Void)?

                               // MARK: - Variables to Use to Control Completion Handlers

                               public var shouldCallCompletionHandlerToBeCalledWhenDone = false
                               public var stringCompletionHandlerToBeCalledWhenDoneResult = .failure(MockError)

                               public var shouldCallFoo1CompletionHandlerToBeCalledWhenDoneCompletionHander = false
                               public var foo1CompletionHandlerToBeCalledWhenDoneCompletionHanderResult: Result<String, Error> = .failure(MockError)

                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   stringCompletionHandlerToBeCalledWhenDone = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func foo1(completionHandlerToBeCalledWhenDone: @escaping (Result<String, Error>) -> Void) {
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

                                   if self.contains(.foo1CompletionHandlerToBeCalledWhenDoneCalled) {
                                       handleFirst()
                                       value += ".foo1CompletionHandlerToBeCalledWhenDoneCalled"
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

                                   if self.contains(.stringCompletionHandlerToBeCalledWhenDone) {
                                       handleFirst()
                                       value += ".stringCompletionHandlerToBeCalledWhenDone"
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
