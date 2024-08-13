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
    
    func testCodeGeneration_helpPresentingProtocol_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: helpPresentingProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
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
    
    func testCodeGeneration_helpPresentingProtocol_trackPropertyActivityFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: helpPresentingProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
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

}
//swiftlint:enable function_body_length
