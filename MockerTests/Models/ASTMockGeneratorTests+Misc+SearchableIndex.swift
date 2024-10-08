//swiftlint:disable function_body_length
//
//  ASTMockGeneratorTests+Misc+SearchableIndex.swift
//  MockerTests
//
//  Created by Greg Strobl on 1/25/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import XCTest
import SwiftSyntax

extension ASTMockGeneratorTests {
    
    var searchableIndexProtocol: String {
        """
        protocol SearchableIndex {

            var indexDelegate: (any CSSearchableIndexDelegate)? { get set }

            func indexSearchableItems(_ items: [CSSearchableItem], completionHandler: ((Error?) -> Void)?)
            func deleteSearchableItems(withIdentifiers identifiers: [String], completionHandler: ((Error?) -> Void)?)
            func deleteAllSearchableItems(completionHandler: ((Error?) -> Void)?)
            
        }
        """
    }
    
    func testCodeGeneration_searchableIndexProtocol_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: searchableIndexProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           class MockTest: SearchableIndex {

                               // MARK: - Variables for Protocol Conformance

                               var indexDelegate: (any CSSearchableIndexDelegate)?

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let indexSearchableItemsItemsCompletionHandlerCalled = Method(rawValue: 1 << 0)
                                   static let deleteSearchableItemsWithIdentifiersIdentifiersCompletionHandlerCalled = Method(rawValue: 1 << 1)
                                   static let deleteAllSearchableItemsCompletionHandlerCalled = Method(rawValue: 1 << 2)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let items = MethodParameter(rawValue: 1 << 0)
                                   static let completionHandler = MethodParameter(rawValue: 1 << 1)
                                   static let identifiers = MethodParameter(rawValue: 1 << 2)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var items: [CSSearchableItem]?
                               private(set) var completionHandler: ((Error?) -> Void)?
                               private(set) var identifiers: [String]?


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   items = nil
                                   completionHandler = nil
                                   identifiers = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func indexSearchableItems(_ items: [CSSearchableItem], completionHandler: ((Error?) -> Void)?) {
                                   calledMethods.insert(.indexSearchableItemsItemsCompletionHandlerCalled)
                                   self.items = items
                                   assignedParameters.insert(.items)
                                   self.completionHandler = completionHandler
                                   assignedParameters.insert(.completionHandler)
                               }

                               func deleteSearchableItems(withIdentifiers identifiers: [String], completionHandler: ((Error?) -> Void)?) {
                                   calledMethods.insert(.deleteSearchableItemsWithIdentifiersIdentifiersCompletionHandlerCalled)
                                   self.identifiers = identifiers
                                   assignedParameters.insert(.identifiers)
                                   self.completionHandler = completionHandler
                                   assignedParameters.insert(.completionHandler)
                               }

                               func deleteAllSearchableItems(completionHandler: ((Error?) -> Void)?) {
                                   calledMethods.insert(.deleteAllSearchableItemsCompletionHandlerCalled)
                                   self.completionHandler = completionHandler
                                   assignedParameters.insert(.completionHandler)
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

                                   if self.contains(.indexSearchableItemsItemsCompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".indexSearchableItemsItemsCompletionHandlerCalled"
                                   }
                                   if self.contains(.deleteSearchableItemsWithIdentifiersIdentifiersCompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".deleteSearchableItemsWithIdentifiersIdentifiersCompletionHandlerCalled"
                                   }
                                   if self.contains(.deleteAllSearchableItemsCompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".deleteAllSearchableItemsCompletionHandlerCalled"
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

                                   if self.contains(.items) {
                                       handleFirst()
                                       value += ".items"
                                   }
                                   if self.contains(.completionHandler) {
                                       handleFirst()
                                       value += ".completionHandler"
                                   }
                                   if self.contains(.identifiers) {
                                       handleFirst()
                                       value += ".identifiers"
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
    
    func testCodeGeneration_searchableIndexProtocol_trackPropertyActivityFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: searchableIndexProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public class MockTest: SearchableIndex {
                           
                               public init() { }

                               // MARK: - Variables for Protocol Conformance

                               public var indexDelegate: (any CSSearchableIndexDelegate)?

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let indexSearchableItemsItemsCompletionHandlerCalled = Method(rawValue: 1 << 0)
                                   public static let deleteSearchableItemsWithIdentifiersIdentifiersCompletionHandlerCalled = Method(rawValue: 1 << 1)
                                   public static let deleteAllSearchableItemsCompletionHandlerCalled = Method(rawValue: 1 << 2)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let items = MethodParameter(rawValue: 1 << 0)
                                   public static let completionHandler = MethodParameter(rawValue: 1 << 1)
                                   public static let identifiers = MethodParameter(rawValue: 1 << 2)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var items: [CSSearchableItem]?
                               private(set) public var completionHandler: ((Error?) -> Void)?
                               private(set) public var identifiers: [String]?


                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   items = nil
                                   completionHandler = nil
                                   identifiers = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func indexSearchableItems(_ items: [CSSearchableItem], completionHandler: ((Error?) -> Void)?) {
                                   calledMethods.insert(.indexSearchableItemsItemsCompletionHandlerCalled)
                                   self.items = items
                                   assignedParameters.insert(.items)
                                   self.completionHandler = completionHandler
                                   assignedParameters.insert(.completionHandler)
                               }

                               public func deleteSearchableItems(withIdentifiers identifiers: [String], completionHandler: ((Error?) -> Void)?) {
                                   calledMethods.insert(.deleteSearchableItemsWithIdentifiersIdentifiersCompletionHandlerCalled)
                                   self.identifiers = identifiers
                                   assignedParameters.insert(.identifiers)
                                   self.completionHandler = completionHandler
                                   assignedParameters.insert(.completionHandler)
                               }

                               public func deleteAllSearchableItems(completionHandler: ((Error?) -> Void)?) {
                                   calledMethods.insert(.deleteAllSearchableItemsCompletionHandlerCalled)
                                   self.completionHandler = completionHandler
                                   assignedParameters.insert(.completionHandler)
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

                                   if self.contains(.indexSearchableItemsItemsCompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".indexSearchableItemsItemsCompletionHandlerCalled"
                                   }
                                   if self.contains(.deleteSearchableItemsWithIdentifiersIdentifiersCompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".deleteSearchableItemsWithIdentifiersIdentifiersCompletionHandlerCalled"
                                   }
                                   if self.contains(.deleteAllSearchableItemsCompletionHandlerCalled) {
                                       handleFirst()
                                       value += ".deleteAllSearchableItemsCompletionHandlerCalled"
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

                                   if self.contains(.items) {
                                       handleFirst()
                                       value += ".items"
                                   }
                                   if self.contains(.completionHandler) {
                                       handleFirst()
                                       value += ".completionHandler"
                                   }
                                   if self.contains(.identifiers) {
                                       handleFirst()
                                       value += ".identifiers"
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
//swiftlint:enable function_body_length
