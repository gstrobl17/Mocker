//swiftlint:disable function_body_length file_length
//
//  ASTMockGeneratorTests+Misc+AnalyticsRecording.swift
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
    
    var analyticsRecordingProtocol: String {
        """
        protocol AnalyticsRecording {
            func setScreenName(_ name: String)
            func logEvent(_ name: String, parameters: [String: String]?)
        }
        """
    }
    
    func testCodeGeneration_analyticsRecordingProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: analyticsRecordingProtocol))
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

                           class MockTest: AnalyticsRecording {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let setScreenNameNameCalled = Method(rawValue: 1 << 0)
                                   static let logEventNameParametersCalled = Method(rawValue: 1 << 1)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let name = MethodParameter(rawValue: 1 << 0)
                                   static let parameters = MethodParameter(rawValue: 1 << 1)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var name: String?
                               private(set) var parameters: [String: String]?


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   name = nil
                                   parameters = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func setScreenName(_ name: String) {
                                   calledMethods.insert(.setScreenNameNameCalled)
                                   self.name = name
                                   assignedParameters.insert(.name)
                               }

                               func logEvent(_ name: String, parameters: [String: String]?) {
                                   calledMethods.insert(.logEventNameParametersCalled)
                                   self.name = name
                                   assignedParameters.insert(.name)
                                   self.parameters = parameters
                                   assignedParameters.insert(.parameters)
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

                                   if self.contains(.setScreenNameNameCalled) {
                                       handleFirst()
                                       value += ".setScreenNameNameCalled"
                                   }
                                   if self.contains(.logEventNameParametersCalled) {
                                       handleFirst()
                                       value += ".logEventNameParametersCalled"
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

                                   if self.contains(.name) {
                                       handleFirst()
                                       value += ".name"
                                   }
                                   if self.contains(.parameters) {
                                       handleFirst()
                                       value += ".parameters"
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
    
    func testCodeGeneration_analyticsRecordingProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: analyticsRecordingProtocol))
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

                           public class MockTest: AnalyticsRecording {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let setScreenNameNameCalled = Method(rawValue: 1 << 0)
                                   public static let logEventNameParametersCalled = Method(rawValue: 1 << 1)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let name = MethodParameter(rawValue: 1 << 0)
                                   public static let parameters = MethodParameter(rawValue: 1 << 1)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var name: String?
                               private(set) public var parameters: [String: String]?


                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   name = nil
                                   parameters = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func setScreenName(_ name: String) {
                                   calledMethods.insert(.setScreenNameNameCalled)
                                   self.name = name
                                   assignedParameters.insert(.name)
                               }

                               public func logEvent(_ name: String, parameters: [String: String]?) {
                                   calledMethods.insert(.logEventNameParametersCalled)
                                   self.name = name
                                   assignedParameters.insert(.name)
                                   self.parameters = parameters
                                   assignedParameters.insert(.parameters)
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

                                   if self.contains(.setScreenNameNameCalled) {
                                       handleFirst()
                                       value += ".setScreenNameNameCalled"
                                   }
                                   if self.contains(.logEventNameParametersCalled) {
                                       handleFirst()
                                       value += ".logEventNameParametersCalled"
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

                                   if self.contains(.name) {
                                       handleFirst()
                                       value += ".name"
                                   }
                                   if self.contains(.parameters) {
                                       handleFirst()
                                       value += ".parameters"
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

    func testCodeGeneration_analyticsRecordingProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: analyticsRecordingProtocol))
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

                           class MockTest: AnalyticsRecording {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let setScreenNameNameCalled = Method(rawValue: 1 << 0)
                                   static let logEventNameParametersCalled = Method(rawValue: 1 << 1)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let name = MethodParameter(rawValue: 1 << 0)
                                   static let parameters = MethodParameter(rawValue: 1 << 1)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var name: String?
                               private(set) var parameters: [String: String]?


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   name = nil
                                   parameters = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func setScreenName(_ name: String) {
                                   calledMethods.insert(.setScreenNameNameCalled)
                                   self.name = name
                                   assignedParameters.insert(.name)
                               }

                               func logEvent(_ name: String, parameters: [String: String]?) {
                                   calledMethods.insert(.logEventNameParametersCalled)
                                   self.name = name
                                   assignedParameters.insert(.name)
                                   self.parameters = parameters
                                   assignedParameters.insert(.parameters)
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

                                   if self.contains(.setScreenNameNameCalled) {
                                       handleFirst()
                                       value += ".setScreenNameNameCalled"
                                   }
                                   if self.contains(.logEventNameParametersCalled) {
                                       handleFirst()
                                       value += ".logEventNameParametersCalled"
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

                                   if self.contains(.name) {
                                       handleFirst()
                                       value += ".name"
                                   }
                                   if self.contains(.parameters) {
                                       handleFirst()
                                       value += ".parameters"
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

    func testCodeGeneration_analyticsRecordingProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: analyticsRecordingProtocol))
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

                           public class MockTest: AnalyticsRecording {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let setScreenNameNameCalled = Method(rawValue: 1 << 0)
                                   public static let logEventNameParametersCalled = Method(rawValue: 1 << 1)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let name = MethodParameter(rawValue: 1 << 0)
                                   public static let parameters = MethodParameter(rawValue: 1 << 1)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var name: String?
                               private(set) public var parameters: [String: String]?


                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   name = nil
                                   parameters = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func setScreenName(_ name: String) {
                                   calledMethods.insert(.setScreenNameNameCalled)
                                   self.name = name
                                   assignedParameters.insert(.name)
                               }

                               public func logEvent(_ name: String, parameters: [String: String]?) {
                                   calledMethods.insert(.logEventNameParametersCalled)
                                   self.name = name
                                   assignedParameters.insert(.name)
                                   self.parameters = parameters
                                   assignedParameters.insert(.parameters)
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

                                   if self.contains(.setScreenNameNameCalled) {
                                       handleFirst()
                                       value += ".setScreenNameNameCalled"
                                   }
                                   if self.contains(.logEventNameParametersCalled) {
                                       handleFirst()
                                       value += ".logEventNameParametersCalled"
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

                                   if self.contains(.name) {
                                       handleFirst()
                                       value += ".name"
                                   }
                                   if self.contains(.parameters) {
                                       handleFirst()
                                       value += ".parameters"
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
