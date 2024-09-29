//swiftlint:disable function_body_length
//
//  ASTMockGeneratorTests+Misc+ProjectFileSelectorInteractorInputProtocol.swift
//  MockerTests
//
//  Created by Greg Strobl on 9/29/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import XCTest
import SwiftSyntax

extension ASTMockGeneratorTests {
    
    var interactorProtocol: String {
        """
        @MainActor
        protocol ProjectFileSelectorInteractorInputProtocol: AnyObject {

            var presenter: (any ProjectFileSelectorInteractorOutputProtocol)? { get set }
            var url: URL? { get }
            
            func setURL(_ url: URL)
            func projectFileSelected(_ url: URL)
            func viewHasLoaded()

        }
        """
    }
    
    func testCodeGeneration_interactorProtocol_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: interactorProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           @MainActor
                           class MockTest: ProjectFileSelectorInteractorInputProtocol {

                               // MARK: - Variables for Protocol Conformance

                               var presenter: (any ProjectFileSelectorInteractorOutputProtocol)?
                               var url: URL?

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let setURLUrlCalled = Method(rawValue: 1 << 0)
                                   static let projectFileSelectedUrlCalled = Method(rawValue: 1 << 1)
                                   static let viewHasLoadedCalled = Method(rawValue: 1 << 2)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let urlParameter = MethodParameter(rawValue: 1 << 0)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var urlParameter: URL?


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   urlParameter = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func setURL(_ url: URL) {
                                   calledMethods.insert(.setURLUrlCalled)
                                   self.urlParameter = url
                                   assignedParameters.insert(.urlParameter)
                               }

                               func projectFileSelected(_ url: URL) {
                                   calledMethods.insert(.projectFileSelectedUrlCalled)
                                   self.urlParameter = url
                                   assignedParameters.insert(.urlParameter)
                               }

                               func viewHasLoaded() {
                                   calledMethods.insert(.viewHasLoadedCalled)
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

                                   if self.contains(.setURLUrlCalled) {
                                       handleFirst()
                                       value += ".setURLUrlCalled"
                                   }
                                   if self.contains(.projectFileSelectedUrlCalled) {
                                       handleFirst()
                                       value += ".projectFileSelectedUrlCalled"
                                   }
                                   if self.contains(.viewHasLoadedCalled) {
                                       handleFirst()
                                       value += ".viewHasLoadedCalled"
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

                                   if self.contains(.urlParameter) {
                                       handleFirst()
                                       value += ".urlParameter"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedCustomReflectableWithCalledMethodsAndAssignedParametersForMainActorProtocol)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_interactorProtocol_trackPropertyActivityFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: interactorProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           @MainActor
                           public class MockTest: ProjectFileSelectorInteractorInputProtocol {

                               public init() { }

                               // MARK: - Variables for Protocol Conformance

                               public var presenter: (any ProjectFileSelectorInteractorOutputProtocol)?
                               public var url: URL?

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let setURLUrlCalled = Method(rawValue: 1 << 0)
                                   public static let projectFileSelectedUrlCalled = Method(rawValue: 1 << 1)
                                   public static let viewHasLoadedCalled = Method(rawValue: 1 << 2)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let urlParameter = MethodParameter(rawValue: 1 << 0)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var urlParameter: URL?


                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   urlParameter = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func setURL(_ url: URL) {
                                   calledMethods.insert(.setURLUrlCalled)
                                   self.urlParameter = url
                                   assignedParameters.insert(.urlParameter)
                               }

                               public func projectFileSelected(_ url: URL) {
                                   calledMethods.insert(.projectFileSelectedUrlCalled)
                                   self.urlParameter = url
                                   assignedParameters.insert(.urlParameter)
                               }

                               public func viewHasLoaded() {
                                   calledMethods.insert(.viewHasLoadedCalled)
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

                                   if self.contains(.setURLUrlCalled) {
                                       handleFirst()
                                       value += ".setURLUrlCalled"
                                   }
                                   if self.contains(.projectFileSelectedUrlCalled) {
                                       handleFirst()
                                       value += ".projectFileSelectedUrlCalled"
                                   }
                                   if self.contains(.viewHasLoadedCalled) {
                                       handleFirst()
                                       value += ".viewHasLoadedCalled"
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

                                   if self.contains(.urlParameter) {
                                       handleFirst()
                                       value += ".urlParameter"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           \(expectedPublicCustomReflectableWithCalledMethodsAndAssignedParametersForMainActorProtocol)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

}
//swiftlint:enable function_body_length
