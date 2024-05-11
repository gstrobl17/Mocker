//swiftlint:disable function_body_length file_length
//
//  ASTMockGeneratorTests+SinglePropertyProtocol.swift
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
    
    // MARK: Single Property Protocol, Get
    
    var singlePropertyProtocolGet: String {
        """
        protocol SingleFunction {
           var value: Int { get }
        }
        """
    }
    
    func testCodeGeneration_singlePropertyProtocolGet_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singlePropertyProtocolGet))
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

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Protocol Conformance

                               var value: Int


                               func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singlePropertyProtocolGet_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singlePropertyProtocolGet))
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
                           
                           class MockTest: SingleFunction {

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get/set/initialize the properties without registering a method call

                               var _value: Int

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let valueGetterCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()


                               func reset() {
                                   calledMethods = []
                               }

                               // MARK: - Properties for Protocol Conformance

                               var value: Int {
                                   calledMethods.insert(.valueGetterCalled)
                                   return _value
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

                                   if self.contains(.valueGetterCalled) {
                                       handleFirst()
                                       value += ".valueGetterCalled"
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
    
    // MARK: Single Property Protocol, Set
    
    var singlePropertyProtocolSet: String {
        """
        protocol SingleFunction {
           var value: Int { set }
        }
        """
    }
    
    func testCodeGeneration_singlePropertyProtocolSet_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singlePropertyProtocolSet))
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

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Protocol Conformance

                               var value: Int


                               func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singlePropertyProtocolSet_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singlePropertyProtocolSet))
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
                           
                           class MockTest: SingleFunction {

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get/set/initialize the properties without registering a method call

                               var _value: Int

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let valueSetterCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let valueInSetter = MethodParameter(rawValue: 1 << 0)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var valueInSetter: Int?


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   valueInSetter = nil
                               }

                               // MARK: - Properties for Protocol Conformance

                               var value: Int {
                                   set {
                                       calledMethods.insert(.valueSetterCalled)
                                       _value = newValue
                                       self.valueInSetter = newValue
                                       assignedParameters.insert(.valueInSetter)
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

                                   if self.contains(.valueSetterCalled) {
                                       handleFirst()
                                       value += ".valueSetterCalled"
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

                                   if self.contains(.valueInSetter) {
                                       handleFirst()
                                       value += ".valueInSetter"
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
    
    // MARK: Single Property Protocol, Get & Set
    
    var singlePropertyProtocolGetSet: String {
        """
        protocol SingleFunction {
           var value: Int { get set }
        }
        """
    }
    
    func testCodeGeneration_singlePropertyProtocolGetSet_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singlePropertyProtocolGetSet))
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

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Protocol Conformance

                               var value: Int


                               func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singlePropertyProtocolGetSet_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singlePropertyProtocolGetSet))
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
                           
                           class MockTest: SingleFunction {

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get/set/initialize the properties without registering a method call

                               var _value: Int

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet {
                                   let rawValue: UInt
                                   static let valueGetterCalled = Method(rawValue: 1 << 0)
                                   static let valueSetterCalled = Method(rawValue: 1 << 1)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let valueInSetter = MethodParameter(rawValue: 1 << 0)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var valueInSetter: Int?


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   valueInSetter = nil
                               }

                               // MARK: - Properties for Protocol Conformance

                               var value: Int {
                                   get {
                                       calledMethods.insert(.valueGetterCalled)
                                       return _value
                                   }
                                   set {
                                       calledMethods.insert(.valueSetterCalled)
                                       _value = newValue
                                       self.valueInSetter = newValue
                                       assignedParameters.insert(.valueInSetter)
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

                                   if self.contains(.valueGetterCalled) {
                                       handleFirst()
                                       value += ".valueGetterCalled"
                                   }
                                   if self.contains(.valueSetterCalled) {
                                       handleFirst()
                                       value += ".valueSetterCalled"
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

                                   if self.contains(.valueInSetter) {
                                       handleFirst()
                                       value += ".valueInSetter"
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
    
    // MARK: Single Static Property Protocol, Get
    
    var singleStaticPropertyProtocolGet: String {
        """
        protocol SingleFunction {
           static var value: Int { get }
        }
        """
    }
    
    func testCodeGeneration_singleStaticPropertyProtocolGet_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticPropertyProtocolGet))
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

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Protocol Conformance

                               static var value: Int


                               func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleStaticPropertyProtocolGet_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticPropertyProtocolGet))
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
                           
                           class MockTest: SingleFunction {

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get/set/initialize the properties without registering a method call

                               static var _value: Int

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let valueGetterCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()


                               func reset() {
                                   MockTest.calledStaticMethods = []
                               }

                               // MARK: - Properties for Protocol Conformance

                               static var value: Int {
                                   calledStaticMethods.insert(.valueGetterCalled)
                                   return _value
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                                   if self.contains(.valueGetterCalled) {
                                       handleFirst()
                                       value += ".valueGetterCalled"
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
    
    // MARK: Single Static Property Protocol, Set
    
    var singleStaticPropertyProtocolSet: String {
        """
        protocol SingleFunction {
           static var value: Int { set }
        }
        """
    }
    
    func testCodeGeneration_singleStaticPropertyProtocolSet_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticPropertyProtocolSet))
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

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Protocol Conformance

                               static var value: Int


                               func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleStaticPropertyProtocolSet_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticPropertyProtocolSet))
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
                           
                           class MockTest: SingleFunction {

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get/set/initialize the properties without registering a method call

                               static var _value: Int

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let valueSetterCalled = Method(rawValue: 1 << 0)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               struct StaticMethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let valueInSetter = StaticMethodParameter(rawValue: 1 << 0)
                               }
                               private(set) static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) static var valueInSetter: Int?


                               func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.valueInSetter = nil
                               }

                               // MARK: - Properties for Protocol Conformance

                               static var value: Int {
                                   set {
                                       calledStaticMethods.insert(.valueSetterCalled)
                                       _value = newValue
                                       self.valueInSetter = newValue
                                       assignedStaticParameters.insert(.valueInSetter)
                                   }
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                                   if self.contains(.valueSetterCalled) {
                                       handleFirst()
                                       value += ".valueSetterCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           extension MockTest.StaticMethodParameter: CustomStringConvertible {
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

                                   if self.contains(.valueInSetter) {
                                       handleFirst()
                                       value += ".valueInSetter"
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
    
    // MARK: Single Static Property Protocol, Get & Set
    
    var singleStaticPropertyProtocolGetSet: String {
        """
        protocol SingleFunction {
           static var value: Int { get set }
        }
        """
    }
    
    func testCodeGeneration_singleStaticPropertyProtocolGetSet_swiftlintAwareFALSE_trackPropertyActivityFALSE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticPropertyProtocolGetSet))
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

                           class MockTest: SingleFunction {

                               // MARK: - Variables for Protocol Conformance

                               static var value: Int


                               func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_singleStaticPropertyProtocolGetSet_swiftlintAwareTRUE_trackPropertyActivityTRUE_publicFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: singleStaticPropertyProtocolGetSet))
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
                           
                           class MockTest: SingleFunction {

                               // MARK: - Variables for Properties Used for Protocol Conformance
                               // Use these properties to get/set/initialize the properties without registering a method call

                               static var _value: Int

                               // MARK: - Variables for Trackings Method Invocation

                               struct StaticMethod: OptionSet {
                                   let rawValue: UInt
                                   static let valueGetterCalled = Method(rawValue: 1 << 0)
                                   static let valueSetterCalled = Method(rawValue: 1 << 1)
                               }
                               private(set) static var calledStaticMethods = StaticMethod()

                               struct StaticMethodParameter: OptionSet {
                                   let rawValue: UInt
                                   static let valueInSetter = StaticMethodParameter(rawValue: 1 << 0)
                               }
                               private(set) static var assignedStaticParameters = StaticMethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) static var valueInSetter: Int?


                               func reset() {
                                   MockTest.calledStaticMethods = []
                                   MockTest.assignedStaticParameters = []
                                   MockTest.valueInSetter = nil
                               }

                               // MARK: - Properties for Protocol Conformance

                               static var value: Int {
                                   get {
                                       calledStaticMethods.insert(.valueGetterCalled)
                                       return _value
                                   }
                                   set {
                                       calledStaticMethods.insert(.valueSetterCalled)
                                       _value = newValue
                                       self.valueInSetter = newValue
                                       assignedStaticParameters.insert(.valueInSetter)
                                   }
                               }

                           }

                           extension MockTest.StaticMethod: CustomStringConvertible {
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

                                   if self.contains(.valueGetterCalled) {
                                       handleFirst()
                                       value += ".valueGetterCalled"
                                   }
                                   if self.contains(.valueSetterCalled) {
                                       handleFirst()
                                       value += ".valueSetterCalled"
                                   }

                                   value += "]"
                                   return value
                               }
                           }

                           extension MockTest.StaticMethodParameter: CustomStringConvertible {
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

                                   if self.contains(.valueInSetter) {
                                       handleFirst()
                                       value += ".valueInSetter"
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
//swiftlint:enable function_body_length file_length
