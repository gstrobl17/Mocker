//swiftlint:disable function_body_length
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

extension ASTMockGeneratorTests {
    
    var helpPresentingProtocol: String {
        """
        protocol HelpPresenting {
            
            var viewController: (any ViewController)? { get }
            var analyticsRecorder: any AnalyticsRecording { get }
            var helpMenuWireframeType: any HelpMenuWireframeProtocol.Type { get }
            var helpItems: [HelpItem] { get }
            
            func openHelp()
        }
        """
    }
    
    func testCodeGeneration_helpPresentingProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: helpPresentingProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           class MockTest: HelpPresenting {

                               // MARK: - Variables for Protocol Conformance

                               var viewController: (any ViewController)?
                               var analyticsRecorder: any AnalyticsRecording
                               var helpMenuWireframeType: any HelpMenuWireframeProtocol.Type
                               var helpItems: [HelpItem]

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
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

                           \(expectedCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_helpPresentingProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: helpPresentingProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public class MockTest: HelpPresenting {
                           
                               public init() { }

                               // MARK: - Variables for Protocol Conformance

                               public var viewController: (any ViewController)?
                               public var analyticsRecorder: any AnalyticsRecording
                               public var helpMenuWireframeType: any HelpMenuWireframeProtocol.Type
                               public var helpItems: [HelpItem]

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
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

                           \(expectedPublicCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_helpPresentingProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: helpPresentingProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: true)
        createGenerator(swiftlintAware: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           class MockTest: HelpPresenting {

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get/set/initialize the properties without registering a method call

                               var _viewController: (any ViewController)?
                               var _analyticsRecorder: any AnalyticsRecording
                               var _helpMenuWireframeType: any HelpMenuWireframeProtocol.Type
                               var _helpItems: [HelpItem]

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
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

                               var viewController: (any ViewController)? {
                                   calledMethods.insert(.viewControllerGetterCalled)
                                   return _viewController
                               }

                               var analyticsRecorder: any AnalyticsRecording {
                                   calledMethods.insert(.analyticsRecorderGetterCalled)
                                   return _analyticsRecorder
                               }

                               var helpMenuWireframeType: any HelpMenuWireframeProtocol.Type {
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

                           \(expectedCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_helpPresentingProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: helpPresentingProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: true, public: true)
        createGenerator(swiftlintAware: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public class MockTest: HelpPresenting {
                           
                               public init() { }

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get/set/initialize the properties without registering a method call

                               public var _viewController: (any ViewController)?
                               public var _analyticsRecorder: any AnalyticsRecording
                               public var _helpMenuWireframeType: any HelpMenuWireframeProtocol.Type
                               public var _helpItems: [HelpItem]

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
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

                               public var viewController: (any ViewController)? {
                                   calledMethods.insert(.viewControllerGetterCalled)
                                   return _viewController
                               }

                               public var analyticsRecorder: any AnalyticsRecording {
                                   calledMethods.insert(.analyticsRecorderGetterCalled)
                                   return _analyticsRecorder
                               }

                               public var helpMenuWireframeType: any HelpMenuWireframeProtocol.Type {
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

                           \(expectedPublicCustomReflectableWithCalledMethods)
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
}
//swiftlint:enable function_body_length
