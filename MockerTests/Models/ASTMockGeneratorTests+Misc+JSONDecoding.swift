//swiftlint:disable function_body_length
//
//  ASTMockGeneratorTests+Misc+JSONDecoding.swift
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
    
    var jsonDecodingProtocol: String {
        """
        protocol JSONDecoding {
         
            func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable

        }
        """
    }
    
    func testCodeGeneration_jsonDecodingProtocol_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: jsonDecodingProtocol))
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

                           class MockTest: JSONDecoding {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let decodeTypeFromDataCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let type = MethodParameter(rawValue: 1 << 0)
                                   static let data = MethodParameter(rawValue: 1 << 1)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var type: T.Type?
                               private(set) var data: Data?

                               // MARK: - Variables to Use as Method Return Values

                               var decodeTypeFromDataReturnValue: T!

                               var errorToThrow: Error!
                               var decodeTypeFromDataShouldThrowError = false


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   type = nil
                                   data = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
                                   calledMethods.insert(.decodeTypeFromDataCalled)
                                   self.type = type
                                   assignedParameters.insert(.type)
                                   self.data = data
                                   assignedParameters.insert(.data)
                                   if decodeTypeFromDataShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return decodeTypeFromDataReturnValue
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

                                   if self.contains(.decodeTypeFromDataCalled) {
                                       handleFirst()
                                       value += ".decodeTypeFromDataCalled"
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

                                   if self.contains(.type) {
                                       handleFirst()
                                       value += ".type"
                                   }
                                   if self.contains(.data) {
                                       handleFirst()
                                       value += ".data"
                                   }

                                   value += "]"
                                   return value
                               }
                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_jsonDecodingProtocol_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: jsonDecodingProtocol))
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

                           class MockTest: JSONDecoding {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let decodeTypeFromDataCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let type = MethodParameter(rawValue: 1 << 0)
                                   static let data = MethodParameter(rawValue: 1 << 1)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var type: T.Type?
                               private(set) var data: Data?

                               // MARK: - Variables to Use as Method Return Values

                               //swiftlint:disable implicitly_unwrapped_optional
                               var decodeTypeFromDataReturnValue: T!
                               //swiftlint:enable implicitly_unwrapped_optional

                               var errorToThrow: Error!
                               var decodeTypeFromDataShouldThrowError = false


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   type = nil
                                   data = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
                                   calledMethods.insert(.decodeTypeFromDataCalled)
                                   self.type = type
                                   assignedParameters.insert(.type)
                                   self.data = data
                                   assignedParameters.insert(.data)
                                   if decodeTypeFromDataShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return decodeTypeFromDataReturnValue
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

                                   if self.contains(.decodeTypeFromDataCalled) {
                                       handleFirst()
                                       value += ".decodeTypeFromDataCalled"
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

                                   if self.contains(.type) {
                                       handleFirst()
                                       value += ".type"
                                   }
                                   if self.contains(.data) {
                                       handleFirst()
                                       value += ".data"
                                   }

                                   value += "]"
                                   return value
                               }
                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
}
//swiftlint:enable function_body_length
