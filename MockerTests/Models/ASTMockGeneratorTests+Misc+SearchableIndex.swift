//swiftlint:disable function_body_length file_length
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
import SwiftSyntaxParser

extension ASTMockGeneratorTests {
    
    var searchableIndexProtocol: String {
        """
        protocol SearchableIndex {

            var indexDelegate: CSSearchableIndexDelegate? { get set }

            func indexSearchableItems(_ items: [CSSearchableItem], completionHandler: ((Error?) -> Void)?)
            func deleteSearchableItems(withIdentifiers identifiers: [String], completionHandler: ((Error?) -> Void)?)
            func deleteAllSearchableItems(completionHandler: ((Error?) -> Void)?)
            
        }
        """
    }
    
    func testCodeGeneration_searchableIndexProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: searchableIndexProtocol))
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

                           class MockTest: SearchableIndex {

                               // MARK: - Variables for Protocol Conformance

                               var indexDelegate: CSSearchableIndexDelegate?

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let indexSearchableItemsItemsCompletionHandlerCalled = Method(rawValue: 1 << 0)
                                   static let deleteSearchableItemsWithIdentifiersIdentifiersCompletionHandlerCalled = Method(rawValue: 1 << 1)
                                   static let deleteAllSearchableItemsCompletionHandlerCalled = Method(rawValue: 1 << 2)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
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

                           extension MockTest: CustomReflectable {
                               var customMirror: Mirror {
                                   Mirror(self,
                                          children: [
                                           "calledMethods": calledMethods,
                                           "assignedParameters": assignedParameters,
                                          ],
                                          displayStyle: .none
                                   )
                               }
                           }

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_searchableIndexProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: searchableIndexProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
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

                           public class MockTest: SearchableIndex {
                           
                               public init() { }

                               // MARK: - Variables for Protocol Conformance

                               public var indexDelegate: CSSearchableIndexDelegate?

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let indexSearchableItemsItemsCompletionHandlerCalled = Method(rawValue: 1 << 0)
                                   public static let deleteSearchableItemsWithIdentifiersIdentifiersCompletionHandlerCalled = Method(rawValue: 1 << 1)
                                   public static let deleteAllSearchableItemsCompletionHandlerCalled = Method(rawValue: 1 << 2)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet {
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

                           extension MockTest: CustomReflectable {
                               public var customMirror: Mirror {
                                   Mirror(self,
                                          children: [
                                           "calledMethods": calledMethods,
                                           "assignedParameters": assignedParameters,
                                          ],
                                          displayStyle: .none
                                   )
                               }
                           }

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_searchableIndexProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: searchableIndexProtocol))
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

                           class MockTest: SearchableIndex {

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get/set/initialize the properties without registering a method call

                               var _indexDelegate: CSSearchableIndexDelegate?

                               // MARK: - Variables for Trackings Method Invocation

                               //swiftlint:disable identifier_name
                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let indexDelegateGetterCalled = Method(rawValue: 1 << 0)
                                   static let indexDelegateSetterCalled = Method(rawValue: 1 << 1)
                                   static let indexSearchableItemsItemsCompletionHandlerCalled = Method(rawValue: 1 << 2)
                                   static let deleteSearchableItemsWithIdentifiersIdentifiersCompletionHandlerCalled = Method(rawValue: 1 << 3)
                                   static let deleteAllSearchableItemsCompletionHandlerCalled = Method(rawValue: 1 << 4)
                               }
                               //swiftlint:enable identifier_name
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let indexDelegateInSetter = MethodParameter(rawValue: 1 << 0)
                                   static let items = MethodParameter(rawValue: 1 << 1)
                                   static let completionHandler = MethodParameter(rawValue: 1 << 2)
                                   static let identifiers = MethodParameter(rawValue: 1 << 3)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var indexDelegateInSetter: CSSearchableIndexDelegate?
                               private(set) var items: [CSSearchableItem]?
                               private(set) var completionHandler: ((Error?) -> Void)?
                               private(set) var identifiers: [String]?


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   indexDelegateInSetter = nil
                                   items = nil
                                   completionHandler = nil
                                   identifiers = nil
                               }

                               // MARK: - Properties for Protocol Conformance

                               var indexDelegate: CSSearchableIndexDelegate? {
                                   get {
                                       calledMethods.insert(.indexDelegateGetterCalled)
                                       return _indexDelegate
                                   }
                                   set {
                                       calledMethods.insert(.indexDelegateSetterCalled)
                                       _indexDelegate = newValue
                                       self.indexDelegateInSetter = newValue
                                       assignedParameters.insert(.indexDelegateInSetter)
                                   }
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

                                   if self.contains(.indexDelegateGetterCalled) {
                                       handleFirst()
                                       value += ".indexDelegateGetterCalled"
                                   }
                                   if self.contains(.indexDelegateSetterCalled) {
                                       handleFirst()
                                       value += ".indexDelegateSetterCalled"
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

                                   if self.contains(.indexDelegateInSetter) {
                                       handleFirst()
                                       value += ".indexDelegateInSetter"
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

                           extension MockTest: CustomReflectable {
                               var customMirror: Mirror {
                                   Mirror(self,
                                          children: [
                                           "calledMethods": calledMethods,
                                           "assignedParameters": assignedParameters,
                                          ],
                                          displayStyle: .none
                                   )
                               }
                           }

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_searchableIndexProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: searchableIndexProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: true, public: true)
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

                           public class MockTest: SearchableIndex {
                           
                               public init() { }

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get/set/initialize the properties without registering a method call

                               public var _indexDelegate: CSSearchableIndexDelegate?

                               // MARK: - Variables for Trackings Method Invocation

                               //swiftlint:disable identifier_name
                               public struct Method: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let indexDelegateGetterCalled = Method(rawValue: 1 << 0)
                                   public static let indexDelegateSetterCalled = Method(rawValue: 1 << 1)
                                   public static let indexSearchableItemsItemsCompletionHandlerCalled = Method(rawValue: 1 << 2)
                                   public static let deleteSearchableItemsWithIdentifiersIdentifiersCompletionHandlerCalled = Method(rawValue: 1 << 3)
                                   public static let deleteAllSearchableItemsCompletionHandlerCalled = Method(rawValue: 1 << 4)
                               }
                               //swiftlint:enable identifier_name
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let indexDelegateInSetter = MethodParameter(rawValue: 1 << 0)
                                   public static let items = MethodParameter(rawValue: 1 << 1)
                                   public static let completionHandler = MethodParameter(rawValue: 1 << 2)
                                   public static let identifiers = MethodParameter(rawValue: 1 << 3)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var indexDelegateInSetter: CSSearchableIndexDelegate?
                               private(set) public var items: [CSSearchableItem]?
                               private(set) public var completionHandler: ((Error?) -> Void)?
                               private(set) public var identifiers: [String]?


                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   indexDelegateInSetter = nil
                                   items = nil
                                   completionHandler = nil
                                   identifiers = nil
                               }

                               // MARK: - Properties for Protocol Conformance

                               public var indexDelegate: CSSearchableIndexDelegate? {
                                   get {
                                       calledMethods.insert(.indexDelegateGetterCalled)
                                       return _indexDelegate
                                   }
                                   set {
                                       calledMethods.insert(.indexDelegateSetterCalled)
                                       _indexDelegate = newValue
                                       self.indexDelegateInSetter = newValue
                                       assignedParameters.insert(.indexDelegateInSetter)
                                   }
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

                                   if self.contains(.indexDelegateGetterCalled) {
                                       handleFirst()
                                       value += ".indexDelegateGetterCalled"
                                   }
                                   if self.contains(.indexDelegateSetterCalled) {
                                       handleFirst()
                                       value += ".indexDelegateSetterCalled"
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

                                   if self.contains(.indexDelegateInSetter) {
                                       handleFirst()
                                       value += ".indexDelegateInSetter"
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

                           extension MockTest: CustomReflectable {
                               public var customMirror: Mirror {
                                   Mirror(self,
                                          children: [
                                           "calledMethods": calledMethods,
                                           "assignedParameters": assignedParameters,
                                          ],
                                          displayStyle: .none
                                   )
                               }
                           }

                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
}
//swiftlint:enable function_body_length file_length
