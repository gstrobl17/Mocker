//TODO: evaluate any change and rework to use constants
//swiftlint:disable function_body_length file_length
//
//  ASTMockGeneratorTests+Misc+WarmUpManager.swift
//  MockerTests
//
//  Created by Greg Strobl on 1/25/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import XCTest
import SwiftSyntax

extension ASTMockGeneratorTests {
    
    var warmUpManagerProtocol: String {
        """
        protocol WarmUpManager {
            
            var delegate: WarmUpManagerDelegate? { get set }
            
            var instantWarmUp: WarmUp { get set }
            var userDefinedWarmUps: [WarmUp] { get }

            // Custom Warm-up Methods
            func add(_ warmUp: WarmUp)
            func update(_ warmUp: WarmUp)
            func delete(_ warmUp: WarmUp)
            
            var count: Int { get }
            func warmUp(for index: Int) -> WarmUp?
            func warmUp(for uuid: String) -> WarmUp?
            func index(for warmUp: WarmUp) -> Int?

            // Searchable index (bridge) delegate support
            func searchableIndex(_ searchableIndex: SearchableIndex, reindexAllSearchableItemsWithAcknowledgementHandler acknowledgementHandler: @escaping () -> Void)
            func searchableIndex(_ searchableIndex: SearchableIndex, reindexSearchableItemsWithIdentifiers identifiers: [String], acknowledgementHandler: @escaping () -> Void)
        }
        """
    }
    
    func testCodeGeneration_warmUpManagerProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: warmUpManagerProtocol))
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

                           class MockTest: WarmUpManager {

                               // MARK: - Variables for Protocol Conformance

                               var delegate: WarmUpManagerDelegate?
                               var instantWarmUp: WarmUp
                               var userDefinedWarmUps: [WarmUp]
                               var count: Int

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let addWarmUpCalled = Method(rawValue: 1 << 0)
                                   static let updateWarmUpCalled = Method(rawValue: 1 << 1)
                                   static let deleteWarmUpCalled = Method(rawValue: 1 << 2)
                                   static let warmUpForIndexCalled = Method(rawValue: 1 << 3)
                                   static let warmUpForUuidCalled = Method(rawValue: 1 << 4)
                                   static let indexForWarmUpCalled = Method(rawValue: 1 << 5)
                                   static let searchableIndexSearchableIndexReindexAllSearchableItemsWithAcknowledgementHandlerAcknowledgementHandlerCalled = Method(rawValue: 1 << 6)
                                   static let searchableIndexSearchableIndexReindexSearchableItemsWithIdentifiersIdentifiersAcknowledgementHandlerCalled = Method(rawValue: 1 << 7)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let warmUp = MethodParameter(rawValue: 1 << 0)
                                   static let index = MethodParameter(rawValue: 1 << 1)
                                   static let uuid = MethodParameter(rawValue: 1 << 2)
                                   static let searchableIndex = MethodParameter(rawValue: 1 << 3)
                                   static let acknowledgementHandler = MethodParameter(rawValue: 1 << 4)
                                   static let identifiers = MethodParameter(rawValue: 1 << 5)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var warmUp: WarmUp?
                               private(set) var index: Int?
                               private(set) var uuid: String?
                               private(set) var searchableIndex: SearchableIndex?
                               private(set) var acknowledgementHandler: (() -> Void)?
                               private(set) var identifiers: [String]?

                               // MARK: - Variables to Use as Method Return Values

                               var warmUpForIndexReturnValue: WarmUp?
                               var warmUpForUuidReturnValue: WarmUp?
                               var indexForWarmUpReturnValue: Int?

                               // MARK: - Variables to Use to Control Completion Handlers

                               var shouldCallAcknowledgementHandler = false

                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   warmUp = nil
                                   index = nil
                                   uuid = nil
                                   searchableIndex = nil
                                   acknowledgementHandler = nil
                                   identifiers = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func add(_ warmUp: WarmUp) {
                                   calledMethods.insert(.addWarmUpCalled)
                                   self.warmUp = warmUp
                                   assignedParameters.insert(.warmUp)
                               }

                               func update(_ warmUp: WarmUp) {
                                   calledMethods.insert(.updateWarmUpCalled)
                                   self.warmUp = warmUp
                                   assignedParameters.insert(.warmUp)
                               }

                               func delete(_ warmUp: WarmUp) {
                                   calledMethods.insert(.deleteWarmUpCalled)
                                   self.warmUp = warmUp
                                   assignedParameters.insert(.warmUp)
                               }

                               func warmUp(for index: Int) -> WarmUp? {
                                   calledMethods.insert(.warmUpForIndexCalled)
                                   self.index = index
                                   assignedParameters.insert(.index)
                                   return warmUpForIndexReturnValue
                               }

                               func warmUp(for uuid: String) -> WarmUp? {
                                   calledMethods.insert(.warmUpForUuidCalled)
                                   self.uuid = uuid
                                   assignedParameters.insert(.uuid)
                                   return warmUpForUuidReturnValue
                               }

                               func index(for warmUp: WarmUp) -> Int? {
                                   calledMethods.insert(.indexForWarmUpCalled)
                                   self.warmUp = warmUp
                                   assignedParameters.insert(.warmUp)
                                   return indexForWarmUpReturnValue
                               }

                               func searchableIndex(_ searchableIndex: SearchableIndex, reindexAllSearchableItemsWithAcknowledgementHandler acknowledgementHandler: @escaping () -> Void) {
                                   calledMethods.insert(.searchableIndexSearchableIndexReindexAllSearchableItemsWithAcknowledgementHandlerAcknowledgementHandlerCalled)
                                   self.searchableIndex = searchableIndex
                                   assignedParameters.insert(.searchableIndex)
                                   self.acknowledgementHandler = acknowledgementHandler
                                   assignedParameters.insert(.acknowledgementHandler)
                                   if shouldCallAcknowledgementHandler {
                                       acknowledgementHandler()
                                   }
                               }

                               func searchableIndex(_ searchableIndex: SearchableIndex, reindexSearchableItemsWithIdentifiers identifiers: [String], acknowledgementHandler: @escaping () -> Void) {
                                   calledMethods.insert(.searchableIndexSearchableIndexReindexSearchableItemsWithIdentifiersIdentifiersAcknowledgementHandlerCalled)
                                   self.searchableIndex = searchableIndex
                                   assignedParameters.insert(.searchableIndex)
                                   self.identifiers = identifiers
                                   assignedParameters.insert(.identifiers)
                                   self.acknowledgementHandler = acknowledgementHandler
                                   assignedParameters.insert(.acknowledgementHandler)
                                   if shouldCallAcknowledgementHandler {
                                       acknowledgementHandler()
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

                                   if self.contains(.addWarmUpCalled) {
                                       handleFirst()
                                       value += ".addWarmUpCalled"
                                   }
                                   if self.contains(.updateWarmUpCalled) {
                                       handleFirst()
                                       value += ".updateWarmUpCalled"
                                   }
                                   if self.contains(.deleteWarmUpCalled) {
                                       handleFirst()
                                       value += ".deleteWarmUpCalled"
                                   }
                                   if self.contains(.warmUpForIndexCalled) {
                                       handleFirst()
                                       value += ".warmUpForIndexCalled"
                                   }
                                   if self.contains(.warmUpForUuidCalled) {
                                       handleFirst()
                                       value += ".warmUpForUuidCalled"
                                   }
                                   if self.contains(.indexForWarmUpCalled) {
                                       handleFirst()
                                       value += ".indexForWarmUpCalled"
                                   }
                                   if self.contains(.searchableIndexSearchableIndexReindexAllSearchableItemsWithAcknowledgementHandlerAcknowledgementHandlerCalled) {
                                       handleFirst()
                                       value += ".searchableIndexSearchableIndexReindexAllSearchableItemsWithAcknowledgementHandlerAcknowledgementHandlerCalled"
                                   }
                                   if self.contains(.searchableIndexSearchableIndexReindexSearchableItemsWithIdentifiersIdentifiersAcknowledgementHandlerCalled) {
                                       handleFirst()
                                       value += ".searchableIndexSearchableIndexReindexSearchableItemsWithIdentifiersIdentifiersAcknowledgementHandlerCalled"
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

                                   if self.contains(.warmUp) {
                                       handleFirst()
                                       value += ".warmUp"
                                   }
                                   if self.contains(.index) {
                                       handleFirst()
                                       value += ".index"
                                   }
                                   if self.contains(.uuid) {
                                       handleFirst()
                                       value += ".uuid"
                                   }
                                   if self.contains(.searchableIndex) {
                                       handleFirst()
                                       value += ".searchableIndex"
                                   }
                                   if self.contains(.acknowledgementHandler) {
                                       handleFirst()
                                       value += ".acknowledgementHandler"
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
    
    func testCodeGeneration_warmUpManagerProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: warmUpManagerProtocol))
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

                           public class MockTest: WarmUpManager {
                           
                               public init() { }

                               // MARK: - Variables for Protocol Conformance

                               public var delegate: WarmUpManagerDelegate?
                               public var instantWarmUp: WarmUp
                               public var userDefinedWarmUps: [WarmUp]
                               public var count: Int

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let addWarmUpCalled = Method(rawValue: 1 << 0)
                                   public static let updateWarmUpCalled = Method(rawValue: 1 << 1)
                                   public static let deleteWarmUpCalled = Method(rawValue: 1 << 2)
                                   public static let warmUpForIndexCalled = Method(rawValue: 1 << 3)
                                   public static let warmUpForUuidCalled = Method(rawValue: 1 << 4)
                                   public static let indexForWarmUpCalled = Method(rawValue: 1 << 5)
                                   public static let searchableIndexSearchableIndexReindexAllSearchableItemsWithAcknowledgementHandlerAcknowledgementHandlerCalled = Method(rawValue: 1 << 6)
                                   public static let searchableIndexSearchableIndexReindexSearchableItemsWithIdentifiersIdentifiersAcknowledgementHandlerCalled = Method(rawValue: 1 << 7)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let warmUp = MethodParameter(rawValue: 1 << 0)
                                   public static let index = MethodParameter(rawValue: 1 << 1)
                                   public static let uuid = MethodParameter(rawValue: 1 << 2)
                                   public static let searchableIndex = MethodParameter(rawValue: 1 << 3)
                                   public static let acknowledgementHandler = MethodParameter(rawValue: 1 << 4)
                                   public static let identifiers = MethodParameter(rawValue: 1 << 5)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var warmUp: WarmUp?
                               private(set) public var index: Int?
                               private(set) public var uuid: String?
                               private(set) public var searchableIndex: SearchableIndex?
                               private(set) public var acknowledgementHandler: (() -> Void)?
                               private(set) public var identifiers: [String]?

                               // MARK: - Variables to Use as Method Return Values

                               public var warmUpForIndexReturnValue: WarmUp?
                               public var warmUpForUuidReturnValue: WarmUp?
                               public var indexForWarmUpReturnValue: Int?

                               // MARK: - Variables to Use to Control Completion Handlers

                               public var shouldCallAcknowledgementHandler = false

                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   warmUp = nil
                                   index = nil
                                   uuid = nil
                                   searchableIndex = nil
                                   acknowledgementHandler = nil
                                   identifiers = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func add(_ warmUp: WarmUp) {
                                   calledMethods.insert(.addWarmUpCalled)
                                   self.warmUp = warmUp
                                   assignedParameters.insert(.warmUp)
                               }

                               public func update(_ warmUp: WarmUp) {
                                   calledMethods.insert(.updateWarmUpCalled)
                                   self.warmUp = warmUp
                                   assignedParameters.insert(.warmUp)
                               }

                               public func delete(_ warmUp: WarmUp) {
                                   calledMethods.insert(.deleteWarmUpCalled)
                                   self.warmUp = warmUp
                                   assignedParameters.insert(.warmUp)
                               }

                               public func warmUp(for index: Int) -> WarmUp? {
                                   calledMethods.insert(.warmUpForIndexCalled)
                                   self.index = index
                                   assignedParameters.insert(.index)
                                   return warmUpForIndexReturnValue
                               }

                               public func warmUp(for uuid: String) -> WarmUp? {
                                   calledMethods.insert(.warmUpForUuidCalled)
                                   self.uuid = uuid
                                   assignedParameters.insert(.uuid)
                                   return warmUpForUuidReturnValue
                               }

                               public func index(for warmUp: WarmUp) -> Int? {
                                   calledMethods.insert(.indexForWarmUpCalled)
                                   self.warmUp = warmUp
                                   assignedParameters.insert(.warmUp)
                                   return indexForWarmUpReturnValue
                               }

                               public func searchableIndex(_ searchableIndex: SearchableIndex, reindexAllSearchableItemsWithAcknowledgementHandler acknowledgementHandler: @escaping () -> Void) {
                                   calledMethods.insert(.searchableIndexSearchableIndexReindexAllSearchableItemsWithAcknowledgementHandlerAcknowledgementHandlerCalled)
                                   self.searchableIndex = searchableIndex
                                   assignedParameters.insert(.searchableIndex)
                                   self.acknowledgementHandler = acknowledgementHandler
                                   assignedParameters.insert(.acknowledgementHandler)
                                   if shouldCallAcknowledgementHandler {
                                       acknowledgementHandler()
                                   }
                               }

                               public func searchableIndex(_ searchableIndex: SearchableIndex, reindexSearchableItemsWithIdentifiers identifiers: [String], acknowledgementHandler: @escaping () -> Void) {
                                   calledMethods.insert(.searchableIndexSearchableIndexReindexSearchableItemsWithIdentifiersIdentifiersAcknowledgementHandlerCalled)
                                   self.searchableIndex = searchableIndex
                                   assignedParameters.insert(.searchableIndex)
                                   self.identifiers = identifiers
                                   assignedParameters.insert(.identifiers)
                                   self.acknowledgementHandler = acknowledgementHandler
                                   assignedParameters.insert(.acknowledgementHandler)
                                   if shouldCallAcknowledgementHandler {
                                       acknowledgementHandler()
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

                                   if self.contains(.addWarmUpCalled) {
                                       handleFirst()
                                       value += ".addWarmUpCalled"
                                   }
                                   if self.contains(.updateWarmUpCalled) {
                                       handleFirst()
                                       value += ".updateWarmUpCalled"
                                   }
                                   if self.contains(.deleteWarmUpCalled) {
                                       handleFirst()
                                       value += ".deleteWarmUpCalled"
                                   }
                                   if self.contains(.warmUpForIndexCalled) {
                                       handleFirst()
                                       value += ".warmUpForIndexCalled"
                                   }
                                   if self.contains(.warmUpForUuidCalled) {
                                       handleFirst()
                                       value += ".warmUpForUuidCalled"
                                   }
                                   if self.contains(.indexForWarmUpCalled) {
                                       handleFirst()
                                       value += ".indexForWarmUpCalled"
                                   }
                                   if self.contains(.searchableIndexSearchableIndexReindexAllSearchableItemsWithAcknowledgementHandlerAcknowledgementHandlerCalled) {
                                       handleFirst()
                                       value += ".searchableIndexSearchableIndexReindexAllSearchableItemsWithAcknowledgementHandlerAcknowledgementHandlerCalled"
                                   }
                                   if self.contains(.searchableIndexSearchableIndexReindexSearchableItemsWithIdentifiersIdentifiersAcknowledgementHandlerCalled) {
                                       handleFirst()
                                       value += ".searchableIndexSearchableIndexReindexSearchableItemsWithIdentifiersIdentifiersAcknowledgementHandlerCalled"
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

                                   if self.contains(.warmUp) {
                                       handleFirst()
                                       value += ".warmUp"
                                   }
                                   if self.contains(.index) {
                                       handleFirst()
                                       value += ".index"
                                   }
                                   if self.contains(.uuid) {
                                       handleFirst()
                                       value += ".uuid"
                                   }
                                   if self.contains(.searchableIndex) {
                                       handleFirst()
                                       value += ".searchableIndex"
                                   }
                                   if self.contains(.acknowledgementHandler) {
                                       handleFirst()
                                       value += ".acknowledgementHandler"
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

    func testCodeGeneration_warmUpManagerProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: warmUpManagerProtocol))
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

                           class MockTest: WarmUpManager {

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get/set/initialize the properties without registering a method call

                               var _delegate: WarmUpManagerDelegate? //swiftlint:disable:this weak_delegate
                               var _instantWarmUp: WarmUp
                               var _userDefinedWarmUps: [WarmUp]
                               var _count: Int

                               // MARK: - Variables for Trackings Method Invocation

                               //swiftlint:disable identifier_name
                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let delegateGetterCalled = Method(rawValue: 1 << 0)
                                   static let delegateSetterCalled = Method(rawValue: 1 << 1)
                                   static let instantWarmUpGetterCalled = Method(rawValue: 1 << 2)
                                   static let instantWarmUpSetterCalled = Method(rawValue: 1 << 3)
                                   static let userDefinedWarmUpsGetterCalled = Method(rawValue: 1 << 4)
                                   static let countGetterCalled = Method(rawValue: 1 << 5)
                                   static let addWarmUpCalled = Method(rawValue: 1 << 6)
                                   static let updateWarmUpCalled = Method(rawValue: 1 << 7)
                                   static let deleteWarmUpCalled = Method(rawValue: 1 << 8)
                                   static let warmUpForIndexCalled = Method(rawValue: 1 << 9)
                                   static let warmUpForUuidCalled = Method(rawValue: 1 << 10)
                                   static let indexForWarmUpCalled = Method(rawValue: 1 << 11)
                                   static let searchableIndexSearchableIndexReindexAllSearchableItemsWithAcknowledgementHandlerAcknowledgementHandlerCalled = Method(rawValue: 1 << 12)
                                   static let searchableIndexSearchableIndexReindexSearchableItemsWithIdentifiersIdentifiersAcknowledgementHandlerCalled = Method(rawValue: 1 << 13)
                               }
                               //swiftlint:enable identifier_name
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let delegateInSetter = MethodParameter(rawValue: 1 << 0)
                                   static let instantWarmUpInSetter = MethodParameter(rawValue: 1 << 1)
                                   static let warmUp = MethodParameter(rawValue: 1 << 2)
                                   static let index = MethodParameter(rawValue: 1 << 3)
                                   static let uuid = MethodParameter(rawValue: 1 << 4)
                                   static let searchableIndex = MethodParameter(rawValue: 1 << 5)
                                   static let acknowledgementHandler = MethodParameter(rawValue: 1 << 6)
                                   static let identifiers = MethodParameter(rawValue: 1 << 7)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var delegateInSetter: WarmUpManagerDelegate?
                               private(set) var instantWarmUpInSetter: WarmUp?
                               private(set) var warmUp: WarmUp?
                               private(set) var index: Int?
                               private(set) var uuid: String?
                               private(set) var searchableIndex: SearchableIndex?
                               private(set) var acknowledgementHandler: (() -> Void)?
                               private(set) var identifiers: [String]?

                               // MARK: - Variables to Use as Method Return Values

                               var warmUpForIndexReturnValue: WarmUp?
                               var warmUpForUuidReturnValue: WarmUp?
                               var indexForWarmUpReturnValue: Int?

                               // MARK: - Variables to Use to Control Completion Handlers

                               var shouldCallAcknowledgementHandler = false

                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   delegateInSetter = nil
                                   instantWarmUpInSetter = nil
                                   warmUp = nil
                                   index = nil
                                   uuid = nil
                                   searchableIndex = nil
                                   acknowledgementHandler = nil
                                   identifiers = nil
                               }

                               // MARK: - Properties for Protocol Conformance

                               var delegate: WarmUpManagerDelegate? {
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

                               var instantWarmUp: WarmUp {
                                   get {
                                       calledMethods.insert(.instantWarmUpGetterCalled)
                                       return _instantWarmUp
                                   }
                                   set {
                                       calledMethods.insert(.instantWarmUpSetterCalled)
                                       _instantWarmUp = newValue
                                       self.instantWarmUpInSetter = newValue
                                       assignedParameters.insert(.instantWarmUpInSetter)
                                   }
                               }

                               var userDefinedWarmUps: [WarmUp] {
                                   calledMethods.insert(.userDefinedWarmUpsGetterCalled)
                                   return _userDefinedWarmUps
                               }

                               var count: Int {
                                   calledMethods.insert(.countGetterCalled)
                                   return _count
                               }

                               // MARK: - Methods for Protocol Conformance

                               func add(_ warmUp: WarmUp) {
                                   calledMethods.insert(.addWarmUpCalled)
                                   self.warmUp = warmUp
                                   assignedParameters.insert(.warmUp)
                               }

                               func update(_ warmUp: WarmUp) {
                                   calledMethods.insert(.updateWarmUpCalled)
                                   self.warmUp = warmUp
                                   assignedParameters.insert(.warmUp)
                               }

                               func delete(_ warmUp: WarmUp) {
                                   calledMethods.insert(.deleteWarmUpCalled)
                                   self.warmUp = warmUp
                                   assignedParameters.insert(.warmUp)
                               }

                               func warmUp(for index: Int) -> WarmUp? {
                                   calledMethods.insert(.warmUpForIndexCalled)
                                   self.index = index
                                   assignedParameters.insert(.index)
                                   return warmUpForIndexReturnValue
                               }

                               func warmUp(for uuid: String) -> WarmUp? {
                                   calledMethods.insert(.warmUpForUuidCalled)
                                   self.uuid = uuid
                                   assignedParameters.insert(.uuid)
                                   return warmUpForUuidReturnValue
                               }

                               func index(for warmUp: WarmUp) -> Int? {
                                   calledMethods.insert(.indexForWarmUpCalled)
                                   self.warmUp = warmUp
                                   assignedParameters.insert(.warmUp)
                                   return indexForWarmUpReturnValue
                               }

                               func searchableIndex(_ searchableIndex: SearchableIndex, reindexAllSearchableItemsWithAcknowledgementHandler acknowledgementHandler: @escaping () -> Void) {
                                   calledMethods.insert(.searchableIndexSearchableIndexReindexAllSearchableItemsWithAcknowledgementHandlerAcknowledgementHandlerCalled)
                                   self.searchableIndex = searchableIndex
                                   assignedParameters.insert(.searchableIndex)
                                   self.acknowledgementHandler = acknowledgementHandler
                                   assignedParameters.insert(.acknowledgementHandler)
                                   if shouldCallAcknowledgementHandler {
                                       acknowledgementHandler()
                                   }
                               }

                               func searchableIndex(_ searchableIndex: SearchableIndex, reindexSearchableItemsWithIdentifiers identifiers: [String], acknowledgementHandler: @escaping () -> Void) {
                                   calledMethods.insert(.searchableIndexSearchableIndexReindexSearchableItemsWithIdentifiersIdentifiersAcknowledgementHandlerCalled)
                                   self.searchableIndex = searchableIndex
                                   assignedParameters.insert(.searchableIndex)
                                   self.identifiers = identifiers
                                   assignedParameters.insert(.identifiers)
                                   self.acknowledgementHandler = acknowledgementHandler
                                   assignedParameters.insert(.acknowledgementHandler)
                                   if shouldCallAcknowledgementHandler {
                                       acknowledgementHandler()
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
                                   if self.contains(.instantWarmUpGetterCalled) {
                                       handleFirst()
                                       value += ".instantWarmUpGetterCalled"
                                   }
                                   if self.contains(.instantWarmUpSetterCalled) {
                                       handleFirst()
                                       value += ".instantWarmUpSetterCalled"
                                   }
                                   if self.contains(.userDefinedWarmUpsGetterCalled) {
                                       handleFirst()
                                       value += ".userDefinedWarmUpsGetterCalled"
                                   }
                                   if self.contains(.countGetterCalled) {
                                       handleFirst()
                                       value += ".countGetterCalled"
                                   }
                                   if self.contains(.addWarmUpCalled) {
                                       handleFirst()
                                       value += ".addWarmUpCalled"
                                   }
                                   if self.contains(.updateWarmUpCalled) {
                                       handleFirst()
                                       value += ".updateWarmUpCalled"
                                   }
                                   if self.contains(.deleteWarmUpCalled) {
                                       handleFirst()
                                       value += ".deleteWarmUpCalled"
                                   }
                                   if self.contains(.warmUpForIndexCalled) {
                                       handleFirst()
                                       value += ".warmUpForIndexCalled"
                                   }
                                   if self.contains(.warmUpForUuidCalled) {
                                       handleFirst()
                                       value += ".warmUpForUuidCalled"
                                   }
                                   if self.contains(.indexForWarmUpCalled) {
                                       handleFirst()
                                       value += ".indexForWarmUpCalled"
                                   }
                                   if self.contains(.searchableIndexSearchableIndexReindexAllSearchableItemsWithAcknowledgementHandlerAcknowledgementHandlerCalled) {
                                       handleFirst()
                                       value += ".searchableIndexSearchableIndexReindexAllSearchableItemsWithAcknowledgementHandlerAcknowledgementHandlerCalled"
                                   }
                                   if self.contains(.searchableIndexSearchableIndexReindexSearchableItemsWithIdentifiersIdentifiersAcknowledgementHandlerCalled) {
                                       handleFirst()
                                       value += ".searchableIndexSearchableIndexReindexSearchableItemsWithIdentifiersIdentifiersAcknowledgementHandlerCalled"
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
                                   if self.contains(.instantWarmUpInSetter) {
                                       handleFirst()
                                       value += ".instantWarmUpInSetter"
                                   }
                                   if self.contains(.warmUp) {
                                       handleFirst()
                                       value += ".warmUp"
                                   }
                                   if self.contains(.index) {
                                       handleFirst()
                                       value += ".index"
                                   }
                                   if self.contains(.uuid) {
                                       handleFirst()
                                       value += ".uuid"
                                   }
                                   if self.contains(.searchableIndex) {
                                       handleFirst()
                                       value += ".searchableIndex"
                                   }
                                   if self.contains(.acknowledgementHandler) {
                                       handleFirst()
                                       value += ".acknowledgementHandler"
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

    func testCodeGeneration_warmUpManagerProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: warmUpManagerProtocol))
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

                           public class MockTest: WarmUpManager {
                           
                               public init() { }

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get/set/initialize the properties without registering a method call

                               public var _delegate: WarmUpManagerDelegate? //swiftlint:disable:this weak_delegate
                               public var _instantWarmUp: WarmUp
                               public var _userDefinedWarmUps: [WarmUp]
                               public var _count: Int

                               // MARK: - Variables for Trackings Method Invocation

                               //swiftlint:disable identifier_name
                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let delegateGetterCalled = Method(rawValue: 1 << 0)
                                   public static let delegateSetterCalled = Method(rawValue: 1 << 1)
                                   public static let instantWarmUpGetterCalled = Method(rawValue: 1 << 2)
                                   public static let instantWarmUpSetterCalled = Method(rawValue: 1 << 3)
                                   public static let userDefinedWarmUpsGetterCalled = Method(rawValue: 1 << 4)
                                   public static let countGetterCalled = Method(rawValue: 1 << 5)
                                   public static let addWarmUpCalled = Method(rawValue: 1 << 6)
                                   public static let updateWarmUpCalled = Method(rawValue: 1 << 7)
                                   public static let deleteWarmUpCalled = Method(rawValue: 1 << 8)
                                   public static let warmUpForIndexCalled = Method(rawValue: 1 << 9)
                                   public static let warmUpForUuidCalled = Method(rawValue: 1 << 10)
                                   public static let indexForWarmUpCalled = Method(rawValue: 1 << 11)
                                   public static let searchableIndexSearchableIndexReindexAllSearchableItemsWithAcknowledgementHandlerAcknowledgementHandlerCalled = Method(rawValue: 1 << 12)
                                   public static let searchableIndexSearchableIndexReindexSearchableItemsWithIdentifiersIdentifiersAcknowledgementHandlerCalled = Method(rawValue: 1 << 13)
                               }
                               //swiftlint:enable identifier_name
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let delegateInSetter = MethodParameter(rawValue: 1 << 0)
                                   public static let instantWarmUpInSetter = MethodParameter(rawValue: 1 << 1)
                                   public static let warmUp = MethodParameter(rawValue: 1 << 2)
                                   public static let index = MethodParameter(rawValue: 1 << 3)
                                   public static let uuid = MethodParameter(rawValue: 1 << 4)
                                   public static let searchableIndex = MethodParameter(rawValue: 1 << 5)
                                   public static let acknowledgementHandler = MethodParameter(rawValue: 1 << 6)
                                   public static let identifiers = MethodParameter(rawValue: 1 << 7)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var delegateInSetter: WarmUpManagerDelegate?
                               private(set) public var instantWarmUpInSetter: WarmUp?
                               private(set) public var warmUp: WarmUp?
                               private(set) public var index: Int?
                               private(set) public var uuid: String?
                               private(set) public var searchableIndex: SearchableIndex?
                               private(set) public var acknowledgementHandler: (() -> Void)?
                               private(set) public var identifiers: [String]?

                               // MARK: - Variables to Use as Method Return Values

                               public var warmUpForIndexReturnValue: WarmUp?
                               public var warmUpForUuidReturnValue: WarmUp?
                               public var indexForWarmUpReturnValue: Int?

                               // MARK: - Variables to Use to Control Completion Handlers

                               public var shouldCallAcknowledgementHandler = false

                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   delegateInSetter = nil
                                   instantWarmUpInSetter = nil
                                   warmUp = nil
                                   index = nil
                                   uuid = nil
                                   searchableIndex = nil
                                   acknowledgementHandler = nil
                                   identifiers = nil
                               }

                               // MARK: - Properties for Protocol Conformance

                               public var delegate: WarmUpManagerDelegate? {
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

                               public var instantWarmUp: WarmUp {
                                   get {
                                       calledMethods.insert(.instantWarmUpGetterCalled)
                                       return _instantWarmUp
                                   }
                                   set {
                                       calledMethods.insert(.instantWarmUpSetterCalled)
                                       _instantWarmUp = newValue
                                       self.instantWarmUpInSetter = newValue
                                       assignedParameters.insert(.instantWarmUpInSetter)
                                   }
                               }

                               public var userDefinedWarmUps: [WarmUp] {
                                   calledMethods.insert(.userDefinedWarmUpsGetterCalled)
                                   return _userDefinedWarmUps
                               }

                               public var count: Int {
                                   calledMethods.insert(.countGetterCalled)
                                   return _count
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func add(_ warmUp: WarmUp) {
                                   calledMethods.insert(.addWarmUpCalled)
                                   self.warmUp = warmUp
                                   assignedParameters.insert(.warmUp)
                               }

                               public func update(_ warmUp: WarmUp) {
                                   calledMethods.insert(.updateWarmUpCalled)
                                   self.warmUp = warmUp
                                   assignedParameters.insert(.warmUp)
                               }

                               public func delete(_ warmUp: WarmUp) {
                                   calledMethods.insert(.deleteWarmUpCalled)
                                   self.warmUp = warmUp
                                   assignedParameters.insert(.warmUp)
                               }

                               public func warmUp(for index: Int) -> WarmUp? {
                                   calledMethods.insert(.warmUpForIndexCalled)
                                   self.index = index
                                   assignedParameters.insert(.index)
                                   return warmUpForIndexReturnValue
                               }

                               public func warmUp(for uuid: String) -> WarmUp? {
                                   calledMethods.insert(.warmUpForUuidCalled)
                                   self.uuid = uuid
                                   assignedParameters.insert(.uuid)
                                   return warmUpForUuidReturnValue
                               }

                               public func index(for warmUp: WarmUp) -> Int? {
                                   calledMethods.insert(.indexForWarmUpCalled)
                                   self.warmUp = warmUp
                                   assignedParameters.insert(.warmUp)
                                   return indexForWarmUpReturnValue
                               }

                               public func searchableIndex(_ searchableIndex: SearchableIndex, reindexAllSearchableItemsWithAcknowledgementHandler acknowledgementHandler: @escaping () -> Void) {
                                   calledMethods.insert(.searchableIndexSearchableIndexReindexAllSearchableItemsWithAcknowledgementHandlerAcknowledgementHandlerCalled)
                                   self.searchableIndex = searchableIndex
                                   assignedParameters.insert(.searchableIndex)
                                   self.acknowledgementHandler = acknowledgementHandler
                                   assignedParameters.insert(.acknowledgementHandler)
                                   if shouldCallAcknowledgementHandler {
                                       acknowledgementHandler()
                                   }
                               }

                               public func searchableIndex(_ searchableIndex: SearchableIndex, reindexSearchableItemsWithIdentifiers identifiers: [String], acknowledgementHandler: @escaping () -> Void) {
                                   calledMethods.insert(.searchableIndexSearchableIndexReindexSearchableItemsWithIdentifiersIdentifiersAcknowledgementHandlerCalled)
                                   self.searchableIndex = searchableIndex
                                   assignedParameters.insert(.searchableIndex)
                                   self.identifiers = identifiers
                                   assignedParameters.insert(.identifiers)
                                   self.acknowledgementHandler = acknowledgementHandler
                                   assignedParameters.insert(.acknowledgementHandler)
                                   if shouldCallAcknowledgementHandler {
                                       acknowledgementHandler()
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

                                   if self.contains(.delegateGetterCalled) {
                                       handleFirst()
                                       value += ".delegateGetterCalled"
                                   }
                                   if self.contains(.delegateSetterCalled) {
                                       handleFirst()
                                       value += ".delegateSetterCalled"
                                   }
                                   if self.contains(.instantWarmUpGetterCalled) {
                                       handleFirst()
                                       value += ".instantWarmUpGetterCalled"
                                   }
                                   if self.contains(.instantWarmUpSetterCalled) {
                                       handleFirst()
                                       value += ".instantWarmUpSetterCalled"
                                   }
                                   if self.contains(.userDefinedWarmUpsGetterCalled) {
                                       handleFirst()
                                       value += ".userDefinedWarmUpsGetterCalled"
                                   }
                                   if self.contains(.countGetterCalled) {
                                       handleFirst()
                                       value += ".countGetterCalled"
                                   }
                                   if self.contains(.addWarmUpCalled) {
                                       handleFirst()
                                       value += ".addWarmUpCalled"
                                   }
                                   if self.contains(.updateWarmUpCalled) {
                                       handleFirst()
                                       value += ".updateWarmUpCalled"
                                   }
                                   if self.contains(.deleteWarmUpCalled) {
                                       handleFirst()
                                       value += ".deleteWarmUpCalled"
                                   }
                                   if self.contains(.warmUpForIndexCalled) {
                                       handleFirst()
                                       value += ".warmUpForIndexCalled"
                                   }
                                   if self.contains(.warmUpForUuidCalled) {
                                       handleFirst()
                                       value += ".warmUpForUuidCalled"
                                   }
                                   if self.contains(.indexForWarmUpCalled) {
                                       handleFirst()
                                       value += ".indexForWarmUpCalled"
                                   }
                                   if self.contains(.searchableIndexSearchableIndexReindexAllSearchableItemsWithAcknowledgementHandlerAcknowledgementHandlerCalled) {
                                       handleFirst()
                                       value += ".searchableIndexSearchableIndexReindexAllSearchableItemsWithAcknowledgementHandlerAcknowledgementHandlerCalled"
                                   }
                                   if self.contains(.searchableIndexSearchableIndexReindexSearchableItemsWithIdentifiersIdentifiersAcknowledgementHandlerCalled) {
                                       handleFirst()
                                       value += ".searchableIndexSearchableIndexReindexSearchableItemsWithIdentifiersIdentifiersAcknowledgementHandlerCalled"
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

                                   if self.contains(.delegateInSetter) {
                                       handleFirst()
                                       value += ".delegateInSetter"
                                   }
                                   if self.contains(.instantWarmUpInSetter) {
                                       handleFirst()
                                       value += ".instantWarmUpInSetter"
                                   }
                                   if self.contains(.warmUp) {
                                       handleFirst()
                                       value += ".warmUp"
                                   }
                                   if self.contains(.index) {
                                       handleFirst()
                                       value += ".index"
                                   }
                                   if self.contains(.uuid) {
                                       handleFirst()
                                       value += ".uuid"
                                   }
                                   if self.contains(.searchableIndex) {
                                       handleFirst()
                                       value += ".searchableIndex"
                                   }
                                   if self.contains(.acknowledgementHandler) {
                                       handleFirst()
                                       value += ".acknowledgementHandler"
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
