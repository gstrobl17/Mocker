//swiftlint:disable function_body_length file_length
//
//  ASTMockGeneratorTests+Misc+NotificationCenterProtocol.swift
//  MockerTests
//
//  Created by Greg Strobl on 1/25/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import XCTest
import SwiftSyntax

extension ASTMockGeneratorTests {
    
    var notificationCenterProtocol: String {
        """
        protocol NotificationCenterProtocol {
            
            func post(_ notification: Notification)
            
            func post(name aName: NSNotification.Name, object anObject: Any?)
            
            func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable: Any]?)
            
            func removeObserver(_ observer: Any)
            
            func removeObserver(_ observer: Any,
                                name aName: NSNotification.Name?,
                                object anObject: Any?)
            
            @available(iOS 4.0, *)
            func addObserver(forName name: NSNotification.Name?,
                             object obj: Any?,
                             queue: OperationQueue?,
                             using block: @escaping @Sendable (Notification) -> Void) -> NSObjectProtocol
            
            func addObserver(_ observer: Any,
                             selector aSelector: Selector,
                             name aName: NSNotification.Name?,
                             object anObject: Any?)
        }
        """
    }
    
    func testCodeGeneration_notificationCenterProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: notificationCenterProtocol))
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

                           class MockTest: NotificationCenterProtocol {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let postNotificationCalled = Method(rawValue: 1 << 0)
                                   static let postNameANameObjectAnObjectCalled = Method(rawValue: 1 << 1)
                                   static let postNameANameObjectAnObjectUserInfoAUserInfoCalled = Method(rawValue: 1 << 2)
                                   static let removeObserverObserverCalled = Method(rawValue: 1 << 3)
                                   static let removeObserverObserverNameANameObjectAnObjectCalled = Method(rawValue: 1 << 4)
                                   static let addObserverForNameNameObjectObjQueueUsingBlockCalled = Method(rawValue: 1 << 5)
                                   static let addObserverObserverSelectorASelectorNameANameObjectAnObjectCalled = Method(rawValue: 1 << 6)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let notification = MethodParameter(rawValue: 1 << 0)
                                   static let aName = MethodParameter(rawValue: 1 << 1)
                                   static let anObject = MethodParameter(rawValue: 1 << 2)
                                   static let aUserInfo = MethodParameter(rawValue: 1 << 3)
                                   static let observer = MethodParameter(rawValue: 1 << 4)
                                   static let name = MethodParameter(rawValue: 1 << 5)
                                   static let obj = MethodParameter(rawValue: 1 << 6)
                                   static let queue = MethodParameter(rawValue: 1 << 7)
                                   static let block = MethodParameter(rawValue: 1 << 8)
                                   static let aSelector = MethodParameter(rawValue: 1 << 9)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var notification: Notification?
                               private(set) var aName: NSNotification.Name?
                               private(set) var anObject: Any?
                               private(set) var aUserInfo: [AnyHashable: Any]?
                               private(set) var observer: Any?
                               private(set) var name: NSNotification.Name?
                               private(set) var obj: Any?
                               private(set) var queue: OperationQueue?
                               private(set) var block: (@Sendable (Notification) -> Void)?
                               private(set) var aSelector: Selector?

                               // MARK: - Variables to Use as Method Return Values

                               var addObserverForNameNameObjectObjQueueUsingBlockReturnValue: NSObjectProtocol!

                               // MARK: - Variables to Use to Control Completion Handlers

                               var shouldCallBlock = false

                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   notification = nil
                                   aName = nil
                                   anObject = nil
                                   aUserInfo = nil
                                   observer = nil
                                   name = nil
                                   obj = nil
                                   queue = nil
                                   block = nil
                                   aSelector = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func post(_ notification: Notification) {
                                   calledMethods.insert(.postNotificationCalled)
                                   self.notification = notification
                                   assignedParameters.insert(.notification)
                               }

                               func post(name aName: NSNotification.Name, object anObject: Any?) {
                                   calledMethods.insert(.postNameANameObjectAnObjectCalled)
                                   self.aName = aName
                                   assignedParameters.insert(.aName)
                                   self.anObject = anObject
                                   assignedParameters.insert(.anObject)
                               }

                               func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable: Any]?) {
                                   calledMethods.insert(.postNameANameObjectAnObjectUserInfoAUserInfoCalled)
                                   self.aName = aName
                                   assignedParameters.insert(.aName)
                                   self.anObject = anObject
                                   assignedParameters.insert(.anObject)
                                   self.aUserInfo = aUserInfo
                                   assignedParameters.insert(.aUserInfo)
                               }

                               func removeObserver(_ observer: Any) {
                                   calledMethods.insert(.removeObserverObserverCalled)
                                   self.observer = observer
                                   assignedParameters.insert(.observer)
                               }

                               func removeObserver(_ observer: Any,
                                                   name aName: NSNotification.Name?,
                                                   object anObject: Any?) {
                                   calledMethods.insert(.removeObserverObserverNameANameObjectAnObjectCalled)
                                   self.observer = observer
                                   assignedParameters.insert(.observer)
                                   self.aName = aName
                                   assignedParameters.insert(.aName)
                                   self.anObject = anObject
                                   assignedParameters.insert(.anObject)
                               }

                               @available(iOS 4.0, *)
                               func addObserver(forName name: NSNotification.Name?,
                                                object obj: Any?,
                                                queue: OperationQueue?,
                                                using block: @escaping @Sendable (Notification) -> Void) -> NSObjectProtocol {
                                   calledMethods.insert(.addObserverForNameNameObjectObjQueueUsingBlockCalled)
                                   self.name = name
                                   assignedParameters.insert(.name)
                                   self.obj = obj
                                   assignedParameters.insert(.obj)
                                   self.queue = queue
                                   assignedParameters.insert(.queue)
                                   self.block = block
                                   assignedParameters.insert(.block)
                                   if shouldCallBlock {
                                       block()
                                   }
                                   return addObserverForNameNameObjectObjQueueUsingBlockReturnValue
                               }

                               func addObserver(_ observer: Any,
                                                selector aSelector: Selector,
                                                name aName: NSNotification.Name?,
                                                object anObject: Any?) {
                                   calledMethods.insert(.addObserverObserverSelectorASelectorNameANameObjectAnObjectCalled)
                                   self.observer = observer
                                   assignedParameters.insert(.observer)
                                   self.aSelector = aSelector
                                   assignedParameters.insert(.aSelector)
                                   self.aName = aName
                                   assignedParameters.insert(.aName)
                                   self.anObject = anObject
                                   assignedParameters.insert(.anObject)
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

                                   if self.contains(.postNotificationCalled) {
                                       handleFirst()
                                       value += ".postNotificationCalled"
                                   }
                                   if self.contains(.postNameANameObjectAnObjectCalled) {
                                       handleFirst()
                                       value += ".postNameANameObjectAnObjectCalled"
                                   }
                                   if self.contains(.postNameANameObjectAnObjectUserInfoAUserInfoCalled) {
                                       handleFirst()
                                       value += ".postNameANameObjectAnObjectUserInfoAUserInfoCalled"
                                   }
                                   if self.contains(.removeObserverObserverCalled) {
                                       handleFirst()
                                       value += ".removeObserverObserverCalled"
                                   }
                                   if self.contains(.removeObserverObserverNameANameObjectAnObjectCalled) {
                                       handleFirst()
                                       value += ".removeObserverObserverNameANameObjectAnObjectCalled"
                                   }
                                   if self.contains(.addObserverForNameNameObjectObjQueueUsingBlockCalled) {
                                       handleFirst()
                                       value += ".addObserverForNameNameObjectObjQueueUsingBlockCalled"
                                   }
                                   if self.contains(.addObserverObserverSelectorASelectorNameANameObjectAnObjectCalled) {
                                       handleFirst()
                                       value += ".addObserverObserverSelectorASelectorNameANameObjectAnObjectCalled"
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

                                   if self.contains(.notification) {
                                       handleFirst()
                                       value += ".notification"
                                   }
                                   if self.contains(.aName) {
                                       handleFirst()
                                       value += ".aName"
                                   }
                                   if self.contains(.anObject) {
                                       handleFirst()
                                       value += ".anObject"
                                   }
                                   if self.contains(.aUserInfo) {
                                       handleFirst()
                                       value += ".aUserInfo"
                                   }
                                   if self.contains(.observer) {
                                       handleFirst()
                                       value += ".observer"
                                   }
                                   if self.contains(.name) {
                                       handleFirst()
                                       value += ".name"
                                   }
                                   if self.contains(.obj) {
                                       handleFirst()
                                       value += ".obj"
                                   }
                                   if self.contains(.queue) {
                                       handleFirst()
                                       value += ".queue"
                                   }
                                   if self.contains(.block) {
                                       handleFirst()
                                       value += ".block"
                                   }
                                   if self.contains(.aSelector) {
                                       handleFirst()
                                       value += ".aSelector"
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
    
    func testCodeGeneration_notificationCenterProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: notificationCenterProtocol))
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

                           public class MockTest: NotificationCenterProtocol {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let postNotificationCalled = Method(rawValue: 1 << 0)
                                   public static let postNameANameObjectAnObjectCalled = Method(rawValue: 1 << 1)
                                   public static let postNameANameObjectAnObjectUserInfoAUserInfoCalled = Method(rawValue: 1 << 2)
                                   public static let removeObserverObserverCalled = Method(rawValue: 1 << 3)
                                   public static let removeObserverObserverNameANameObjectAnObjectCalled = Method(rawValue: 1 << 4)
                                   public static let addObserverForNameNameObjectObjQueueUsingBlockCalled = Method(rawValue: 1 << 5)
                                   public static let addObserverObserverSelectorASelectorNameANameObjectAnObjectCalled = Method(rawValue: 1 << 6)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let notification = MethodParameter(rawValue: 1 << 0)
                                   public static let aName = MethodParameter(rawValue: 1 << 1)
                                   public static let anObject = MethodParameter(rawValue: 1 << 2)
                                   public static let aUserInfo = MethodParameter(rawValue: 1 << 3)
                                   public static let observer = MethodParameter(rawValue: 1 << 4)
                                   public static let name = MethodParameter(rawValue: 1 << 5)
                                   public static let obj = MethodParameter(rawValue: 1 << 6)
                                   public static let queue = MethodParameter(rawValue: 1 << 7)
                                   public static let block = MethodParameter(rawValue: 1 << 8)
                                   public static let aSelector = MethodParameter(rawValue: 1 << 9)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var notification: Notification?
                               private(set) public var aName: NSNotification.Name?
                               private(set) public var anObject: Any?
                               private(set) public var aUserInfo: [AnyHashable: Any]?
                               private(set) public var observer: Any?
                               private(set) public var name: NSNotification.Name?
                               private(set) public var obj: Any?
                               private(set) public var queue: OperationQueue?
                               private(set) public var block: (@Sendable (Notification) -> Void)?
                               private(set) public var aSelector: Selector?

                               // MARK: - Variables to Use as Method Return Values

                               public var addObserverForNameNameObjectObjQueueUsingBlockReturnValue: NSObjectProtocol!

                               // MARK: - Variables to Use to Control Completion Handlers

                               public var shouldCallBlock = false

                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   notification = nil
                                   aName = nil
                                   anObject = nil
                                   aUserInfo = nil
                                   observer = nil
                                   name = nil
                                   obj = nil
                                   queue = nil
                                   block = nil
                                   aSelector = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func post(_ notification: Notification) {
                                   calledMethods.insert(.postNotificationCalled)
                                   self.notification = notification
                                   assignedParameters.insert(.notification)
                               }

                               public func post(name aName: NSNotification.Name, object anObject: Any?) {
                                   calledMethods.insert(.postNameANameObjectAnObjectCalled)
                                   self.aName = aName
                                   assignedParameters.insert(.aName)
                                   self.anObject = anObject
                                   assignedParameters.insert(.anObject)
                               }

                               public func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable: Any]?) {
                                   calledMethods.insert(.postNameANameObjectAnObjectUserInfoAUserInfoCalled)
                                   self.aName = aName
                                   assignedParameters.insert(.aName)
                                   self.anObject = anObject
                                   assignedParameters.insert(.anObject)
                                   self.aUserInfo = aUserInfo
                                   assignedParameters.insert(.aUserInfo)
                               }

                               public func removeObserver(_ observer: Any) {
                                   calledMethods.insert(.removeObserverObserverCalled)
                                   self.observer = observer
                                   assignedParameters.insert(.observer)
                               }

                               public func removeObserver(_ observer: Any,
                                                   name aName: NSNotification.Name?,
                                                   object anObject: Any?) {
                                   calledMethods.insert(.removeObserverObserverNameANameObjectAnObjectCalled)
                                   self.observer = observer
                                   assignedParameters.insert(.observer)
                                   self.aName = aName
                                   assignedParameters.insert(.aName)
                                   self.anObject = anObject
                                   assignedParameters.insert(.anObject)
                               }

                               public @available(iOS 4.0, *)
                               func addObserver(forName name: NSNotification.Name?,
                                                object obj: Any?,
                                                queue: OperationQueue?,
                                                using block: @escaping @Sendable (Notification) -> Void) -> NSObjectProtocol {
                                   calledMethods.insert(.addObserverForNameNameObjectObjQueueUsingBlockCalled)
                                   self.name = name
                                   assignedParameters.insert(.name)
                                   self.obj = obj
                                   assignedParameters.insert(.obj)
                                   self.queue = queue
                                   assignedParameters.insert(.queue)
                                   self.block = block
                                   assignedParameters.insert(.block)
                                   if shouldCallBlock {
                                       block()
                                   }
                                   return addObserverForNameNameObjectObjQueueUsingBlockReturnValue
                               }

                               public func addObserver(_ observer: Any,
                                                selector aSelector: Selector,
                                                name aName: NSNotification.Name?,
                                                object anObject: Any?) {
                                   calledMethods.insert(.addObserverObserverSelectorASelectorNameANameObjectAnObjectCalled)
                                   self.observer = observer
                                   assignedParameters.insert(.observer)
                                   self.aSelector = aSelector
                                   assignedParameters.insert(.aSelector)
                                   self.aName = aName
                                   assignedParameters.insert(.aName)
                                   self.anObject = anObject
                                   assignedParameters.insert(.anObject)
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

                                   if self.contains(.postNotificationCalled) {
                                       handleFirst()
                                       value += ".postNotificationCalled"
                                   }
                                   if self.contains(.postNameANameObjectAnObjectCalled) {
                                       handleFirst()
                                       value += ".postNameANameObjectAnObjectCalled"
                                   }
                                   if self.contains(.postNameANameObjectAnObjectUserInfoAUserInfoCalled) {
                                       handleFirst()
                                       value += ".postNameANameObjectAnObjectUserInfoAUserInfoCalled"
                                   }
                                   if self.contains(.removeObserverObserverCalled) {
                                       handleFirst()
                                       value += ".removeObserverObserverCalled"
                                   }
                                   if self.contains(.removeObserverObserverNameANameObjectAnObjectCalled) {
                                       handleFirst()
                                       value += ".removeObserverObserverNameANameObjectAnObjectCalled"
                                   }
                                   if self.contains(.addObserverForNameNameObjectObjQueueUsingBlockCalled) {
                                       handleFirst()
                                       value += ".addObserverForNameNameObjectObjQueueUsingBlockCalled"
                                   }
                                   if self.contains(.addObserverObserverSelectorASelectorNameANameObjectAnObjectCalled) {
                                       handleFirst()
                                       value += ".addObserverObserverSelectorASelectorNameANameObjectAnObjectCalled"
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

                                   if self.contains(.notification) {
                                       handleFirst()
                                       value += ".notification"
                                   }
                                   if self.contains(.aName) {
                                       handleFirst()
                                       value += ".aName"
                                   }
                                   if self.contains(.anObject) {
                                       handleFirst()
                                       value += ".anObject"
                                   }
                                   if self.contains(.aUserInfo) {
                                       handleFirst()
                                       value += ".aUserInfo"
                                   }
                                   if self.contains(.observer) {
                                       handleFirst()
                                       value += ".observer"
                                   }
                                   if self.contains(.name) {
                                       handleFirst()
                                       value += ".name"
                                   }
                                   if self.contains(.obj) {
                                       handleFirst()
                                       value += ".obj"
                                   }
                                   if self.contains(.queue) {
                                       handleFirst()
                                       value += ".queue"
                                   }
                                   if self.contains(.block) {
                                       handleFirst()
                                       value += ".block"
                                   }
                                   if self.contains(.aSelector) {
                                       handleFirst()
                                       value += ".aSelector"
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

    func testCodeGeneration_notificationCenterProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: notificationCenterProtocol))
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

                           class MockTest: NotificationCenterProtocol {

                               // MARK: - Variables for Trackings Method Invocation

                               //swiftlint:disable identifier_name
                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let postNotificationCalled = Method(rawValue: 1 << 0)
                                   static let postNameANameObjectAnObjectCalled = Method(rawValue: 1 << 1)
                                   static let postNameANameObjectAnObjectUserInfoAUserInfoCalled = Method(rawValue: 1 << 2)
                                   static let removeObserverObserverCalled = Method(rawValue: 1 << 3)
                                   static let removeObserverObserverNameANameObjectAnObjectCalled = Method(rawValue: 1 << 4)
                                   static let addObserverForNameNameObjectObjQueueUsingBlockCalled = Method(rawValue: 1 << 5)
                                   static let addObserverObserverSelectorASelectorNameANameObjectAnObjectCalled = Method(rawValue: 1 << 6)
                               }
                               //swiftlint:enable identifier_name
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let notification = MethodParameter(rawValue: 1 << 0)
                                   static let aName = MethodParameter(rawValue: 1 << 1)
                                   static let anObject = MethodParameter(rawValue: 1 << 2)
                                   static let aUserInfo = MethodParameter(rawValue: 1 << 3)
                                   static let observer = MethodParameter(rawValue: 1 << 4)
                                   static let name = MethodParameter(rawValue: 1 << 5)
                                   static let obj = MethodParameter(rawValue: 1 << 6)
                                   static let queue = MethodParameter(rawValue: 1 << 7)
                                   static let block = MethodParameter(rawValue: 1 << 8)
                                   static let aSelector = MethodParameter(rawValue: 1 << 9)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var notification: Notification?
                               private(set) var aName: NSNotification.Name?
                               private(set) var anObject: Any?
                               private(set) var aUserInfo: [AnyHashable: Any]?
                               private(set) var observer: Any?
                               private(set) var name: NSNotification.Name?
                               private(set) var obj: Any?
                               private(set) var queue: OperationQueue?
                               private(set) var block: (@Sendable (Notification) -> Void)?
                               private(set) var aSelector: Selector?

                               // MARK: - Variables to Use as Method Return Values

                               //swiftlint:disable implicitly_unwrapped_optional
                               var addObserverForNameNameObjectObjQueueUsingBlockReturnValue: NSObjectProtocol! //swiftlint:disable:this identifier_name
                               //swiftlint:enable implicitly_unwrapped_optional

                               // MARK: - Variables to Use to Control Completion Handlers

                               var shouldCallBlock = false

                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   notification = nil
                                   aName = nil
                                   anObject = nil
                                   aUserInfo = nil
                                   observer = nil
                                   name = nil
                                   obj = nil
                                   queue = nil
                                   block = nil
                                   aSelector = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func post(_ notification: Notification) {
                                   calledMethods.insert(.postNotificationCalled)
                                   self.notification = notification
                                   assignedParameters.insert(.notification)
                               }

                               func post(name aName: NSNotification.Name, object anObject: Any?) {
                                   calledMethods.insert(.postNameANameObjectAnObjectCalled)
                                   self.aName = aName
                                   assignedParameters.insert(.aName)
                                   self.anObject = anObject
                                   assignedParameters.insert(.anObject)
                               }

                               func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable: Any]?) {
                                   calledMethods.insert(.postNameANameObjectAnObjectUserInfoAUserInfoCalled)
                                   self.aName = aName
                                   assignedParameters.insert(.aName)
                                   self.anObject = anObject
                                   assignedParameters.insert(.anObject)
                                   self.aUserInfo = aUserInfo
                                   assignedParameters.insert(.aUserInfo)
                               }

                               func removeObserver(_ observer: Any) {
                                   calledMethods.insert(.removeObserverObserverCalled)
                                   self.observer = observer
                                   assignedParameters.insert(.observer)
                               }

                               func removeObserver(_ observer: Any,
                                                   name aName: NSNotification.Name?,
                                                   object anObject: Any?) {
                                   calledMethods.insert(.removeObserverObserverNameANameObjectAnObjectCalled)
                                   self.observer = observer
                                   assignedParameters.insert(.observer)
                                   self.aName = aName
                                   assignedParameters.insert(.aName)
                                   self.anObject = anObject
                                   assignedParameters.insert(.anObject)
                               }

                               @available(iOS 4.0, *)
                               func addObserver(forName name: NSNotification.Name?,
                                                object obj: Any?,
                                                queue: OperationQueue?,
                                                using block: @escaping @Sendable (Notification) -> Void) -> NSObjectProtocol {
                                   calledMethods.insert(.addObserverForNameNameObjectObjQueueUsingBlockCalled)
                                   self.name = name
                                   assignedParameters.insert(.name)
                                   self.obj = obj
                                   assignedParameters.insert(.obj)
                                   self.queue = queue
                                   assignedParameters.insert(.queue)
                                   self.block = block
                                   assignedParameters.insert(.block)
                                   if shouldCallBlock {
                                       block()
                                   }
                                   return addObserverForNameNameObjectObjQueueUsingBlockReturnValue
                               }

                               func addObserver(_ observer: Any,
                                                selector aSelector: Selector,
                                                name aName: NSNotification.Name?,
                                                object anObject: Any?) {
                                   calledMethods.insert(.addObserverObserverSelectorASelectorNameANameObjectAnObjectCalled)
                                   self.observer = observer
                                   assignedParameters.insert(.observer)
                                   self.aSelector = aSelector
                                   assignedParameters.insert(.aSelector)
                                   self.aName = aName
                                   assignedParameters.insert(.aName)
                                   self.anObject = anObject
                                   assignedParameters.insert(.anObject)
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

                                   if self.contains(.postNotificationCalled) {
                                       handleFirst()
                                       value += ".postNotificationCalled"
                                   }
                                   if self.contains(.postNameANameObjectAnObjectCalled) {
                                       handleFirst()
                                       value += ".postNameANameObjectAnObjectCalled"
                                   }
                                   if self.contains(.postNameANameObjectAnObjectUserInfoAUserInfoCalled) {
                                       handleFirst()
                                       value += ".postNameANameObjectAnObjectUserInfoAUserInfoCalled"
                                   }
                                   if self.contains(.removeObserverObserverCalled) {
                                       handleFirst()
                                       value += ".removeObserverObserverCalled"
                                   }
                                   if self.contains(.removeObserverObserverNameANameObjectAnObjectCalled) {
                                       handleFirst()
                                       value += ".removeObserverObserverNameANameObjectAnObjectCalled"
                                   }
                                   if self.contains(.addObserverForNameNameObjectObjQueueUsingBlockCalled) {
                                       handleFirst()
                                       value += ".addObserverForNameNameObjectObjQueueUsingBlockCalled"
                                   }
                                   if self.contains(.addObserverObserverSelectorASelectorNameANameObjectAnObjectCalled) {
                                       handleFirst()
                                       value += ".addObserverObserverSelectorASelectorNameANameObjectAnObjectCalled"
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

                                   if self.contains(.notification) {
                                       handleFirst()
                                       value += ".notification"
                                   }
                                   if self.contains(.aName) {
                                       handleFirst()
                                       value += ".aName"
                                   }
                                   if self.contains(.anObject) {
                                       handleFirst()
                                       value += ".anObject"
                                   }
                                   if self.contains(.aUserInfo) {
                                       handleFirst()
                                       value += ".aUserInfo"
                                   }
                                   if self.contains(.observer) {
                                       handleFirst()
                                       value += ".observer"
                                   }
                                   if self.contains(.name) {
                                       handleFirst()
                                       value += ".name"
                                   }
                                   if self.contains(.obj) {
                                       handleFirst()
                                       value += ".obj"
                                   }
                                   if self.contains(.queue) {
                                       handleFirst()
                                       value += ".queue"
                                   }
                                   if self.contains(.block) {
                                       handleFirst()
                                       value += ".block"
                                   }
                                   if self.contains(.aSelector) {
                                       handleFirst()
                                       value += ".aSelector"
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
}
//swiftlint:enable function_body_length file_length
