//swiftlint:disable function_body_length file_length
//
//  ASTMockGeneratorTests+Misc+HelpPresenting.swift
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
    
    var helpPresentingProtocol: String {
        """
        protocol HelpPresenting {
            
            var viewController: ViewController? { get }
            var analyticsRecorder: AnalyticsRecording { get }
            var helpMenuWireframeType: HelpMenuWireframeProtocol.Type { get }
            var helpItems: [HelpItem] { get }
            
            func openHelp()
        }
        """
    }
    
    func testCodeGeneration_helpPresentingProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: helpPresentingProtocol))
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

                           class MockTest: HelpPresenting {

                               // MARK: - Variables for Protocol Conformance

                               var viewController: ViewController?
                               var analyticsRecorder: AnalyticsRecording
                               var helpMenuWireframeType: HelpMenuWireframeProtocol.Type
                               var helpItems: [HelpItem]

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let openHelpCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()


                               func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               func openHelp() {
                                   calledMethods.insert(.openHelpCalled)
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

                                   if self.contains(.openHelpCalled) {
                                       handleFirst()
                                       value += ".openHelpCalled"
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
    
    func testCodeGeneration_helpPresentingProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: helpPresentingProtocol))
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

                           public class MockTest: HelpPresenting {
                           
                               public init() { }

                               // MARK: - Variables for Protocol Conformance

                               public var viewController: ViewController?
                               public var analyticsRecorder: AnalyticsRecording
                               public var helpMenuWireframeType: HelpMenuWireframeProtocol.Type
                               public var helpItems: [HelpItem]

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let openHelpCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) public var calledMethods = Method()


                               public func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func openHelp() {
                                   calledMethods.insert(.openHelpCalled)
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

                                   if self.contains(.openHelpCalled) {
                                       handleFirst()
                                       value += ".openHelpCalled"
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

    func testCodeGeneration_helpPresentingProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: helpPresentingProtocol))
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

                           class MockTest: HelpPresenting {

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get/set/initialize the properties without registering a method call

                               var _viewController: ViewController?
                               var _analyticsRecorder: AnalyticsRecording
                               var _helpMenuWireframeType: HelpMenuWireframeProtocol.Type
                               var _helpItems: [HelpItem]

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let viewControllerGetterCalled = Method(rawValue: 1 << 0)
                                   static let analyticsRecorderGetterCalled = Method(rawValue: 1 << 1)
                                   static let helpMenuWireframeTypeGetterCalled = Method(rawValue: 1 << 2)
                                   static let helpItemsGetterCalled = Method(rawValue: 1 << 3)
                                   static let openHelpCalled = Method(rawValue: 1 << 4)
                               }
                               private(set) var calledMethods = Method()


                               func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Properties for Protocol Conformance

                               var viewController: ViewController? {
                                   calledMethods.insert(.viewControllerGetterCalled)
                                   return _viewController
                               }

                               var analyticsRecorder: AnalyticsRecording {
                                   calledMethods.insert(.analyticsRecorderGetterCalled)
                                   return _analyticsRecorder
                               }

                               var helpMenuWireframeType: HelpMenuWireframeProtocol.Type {
                                   calledMethods.insert(.helpMenuWireframeTypeGetterCalled)
                                   return _helpMenuWireframeType
                               }

                               var helpItems: [HelpItem] {
                                   calledMethods.insert(.helpItemsGetterCalled)
                                   return _helpItems
                               }

                               // MARK: - Methods for Protocol Conformance

                               func openHelp() {
                                   calledMethods.insert(.openHelpCalled)
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

                                   if self.contains(.viewControllerGetterCalled) {
                                       handleFirst()
                                       value += ".viewControllerGetterCalled"
                                   }
                                   if self.contains(.analyticsRecorderGetterCalled) {
                                       handleFirst()
                                       value += ".analyticsRecorderGetterCalled"
                                   }
                                   if self.contains(.helpMenuWireframeTypeGetterCalled) {
                                       handleFirst()
                                       value += ".helpMenuWireframeTypeGetterCalled"
                                   }
                                   if self.contains(.helpItemsGetterCalled) {
                                       handleFirst()
                                       value += ".helpItemsGetterCalled"
                                   }
                                   if self.contains(.openHelpCalled) {
                                       handleFirst()
                                       value += ".openHelpCalled"
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

    func testCodeGeneration_helpPresentingProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: helpPresentingProtocol))
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

                           public class MockTest: HelpPresenting {
                           
                               public init() { }

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get/set/initialize the properties without registering a method call

                               public var _viewController: ViewController?
                               public var _analyticsRecorder: AnalyticsRecording
                               public var _helpMenuWireframeType: HelpMenuWireframeProtocol.Type
                               public var _helpItems: [HelpItem]

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let viewControllerGetterCalled = Method(rawValue: 1 << 0)
                                   public static let analyticsRecorderGetterCalled = Method(rawValue: 1 << 1)
                                   public static let helpMenuWireframeTypeGetterCalled = Method(rawValue: 1 << 2)
                                   public static let helpItemsGetterCalled = Method(rawValue: 1 << 3)
                                   public static let openHelpCalled = Method(rawValue: 1 << 4)
                               }
                               private(set) public var calledMethods = Method()


                               public func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Properties for Protocol Conformance

                               public var viewController: ViewController? {
                                   calledMethods.insert(.viewControllerGetterCalled)
                                   return _viewController
                               }

                               public var analyticsRecorder: AnalyticsRecording {
                                   calledMethods.insert(.analyticsRecorderGetterCalled)
                                   return _analyticsRecorder
                               }

                               public var helpMenuWireframeType: HelpMenuWireframeProtocol.Type {
                                   calledMethods.insert(.helpMenuWireframeTypeGetterCalled)
                                   return _helpMenuWireframeType
                               }

                               public var helpItems: [HelpItem] {
                                   calledMethods.insert(.helpItemsGetterCalled)
                                   return _helpItems
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func openHelp() {
                                   calledMethods.insert(.openHelpCalled)
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

                                   if self.contains(.viewControllerGetterCalled) {
                                       handleFirst()
                                       value += ".viewControllerGetterCalled"
                                   }
                                   if self.contains(.analyticsRecorderGetterCalled) {
                                       handleFirst()
                                       value += ".analyticsRecorderGetterCalled"
                                   }
                                   if self.contains(.helpMenuWireframeTypeGetterCalled) {
                                       handleFirst()
                                       value += ".helpMenuWireframeTypeGetterCalled"
                                   }
                                   if self.contains(.helpItemsGetterCalled) {
                                       handleFirst()
                                       value += ".helpItemsGetterCalled"
                                   }
                                   if self.contains(.openHelpCalled) {
                                       handleFirst()
                                       value += ".openHelpCalled"
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
