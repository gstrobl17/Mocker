//swiftlint:disable function_body_length file_length
//
//  ASTMockGeneratorTests+Misc+FileManagerProtocol.swift
//  MockerTests
//
//  Created by Greg Strobl on 1/25/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import XCTest
import SwiftSyntax

extension ASTMockGeneratorTests {
    
    var fileManagerProtocol: String {
        """
        protocol FileManagerProtocol {
            func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL]
            func url(for directory: FileManager.SearchPathDirectory, in domain: FileManager.SearchPathDomainMask, appropriateFor url: URL?, create shouldCreate: Bool) throws -> URL

            func fileExists(atPath path: String) -> Bool
            func removeItem(at URL: URL) throws
        }
        """
    }
    
    func testCodeGeneration_fileManagerProtocol_trackPropertyActivityFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: fileManagerProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           class MockTest: FileManagerProtocol {

                               // MARK: - Variables for Trackings Method Invocation

                               struct Method: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let urlsForDirectoryInDomainMaskCalled = Method(rawValue: 1 << 0)
                                   static let urlForDirectoryInDomainAppropriateForUrlCreateShouldCreateCalled = Method(rawValue: 1 << 1)
                                   static let fileExistsAtPathPathCalled = Method(rawValue: 1 << 2)
                                   static let removeItemAtURLCalled = Method(rawValue: 1 << 3)
                               }
                               private(set) var calledMethods = Method()

                               struct MethodParameter: OptionSet, Sendable {
                                   let rawValue: UInt
                                   static let directory = MethodParameter(rawValue: 1 << 0)
                                   static let domainMask = MethodParameter(rawValue: 1 << 1)
                                   static let domain = MethodParameter(rawValue: 1 << 2)
                                   static let url = MethodParameter(rawValue: 1 << 3)
                                   static let shouldCreate = MethodParameter(rawValue: 1 << 4)
                                   static let path = MethodParameter(rawValue: 1 << 5)
                                   static let URL = MethodParameter(rawValue: 1 << 6)
                               }
                               private(set) var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) var directory: FileManager.SearchPathDirectory?
                               private(set) var domainMask: FileManager.SearchPathDomainMask?
                               private(set) var domain: FileManager.SearchPathDomainMask?
                               private(set) var url: URL?
                               private(set) var shouldCreate: Bool?
                               private(set) var path: String?
                               private(set) var URL: URL?

                               // MARK: - Variables to Use as Method Return Values

                               var urlsForDirectoryInDomainMaskReturnValue: [URL]!
                               var urlForDirectoryInDomainAppropriateForUrlCreateShouldCreateReturnValue: URL!
                               var fileExistsAtPathPathReturnValue: Bool!

                               var errorToThrow: Error!
                               var urlForDirectoryInDomainAppropriateForUrlCreateShouldCreateShouldThrowError = false
                               var removeItemAtURLShouldThrowError = false


                               func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   directory = nil
                                   domainMask = nil
                                   domain = nil
                                   url = nil
                                   shouldCreate = nil
                                   path = nil
                                   URL = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL] {
                                   calledMethods.insert(.urlsForDirectoryInDomainMaskCalled)
                                   self.directory = directory
                                   assignedParameters.insert(.directory)
                                   self.domainMask = domainMask
                                   assignedParameters.insert(.domainMask)
                                   return urlsForDirectoryInDomainMaskReturnValue
                               }

                               func url(for directory: FileManager.SearchPathDirectory, in domain: FileManager.SearchPathDomainMask, appropriateFor url: URL?, create shouldCreate: Bool) throws -> URL {
                                   calledMethods.insert(.urlForDirectoryInDomainAppropriateForUrlCreateShouldCreateCalled)
                                   self.directory = directory
                                   assignedParameters.insert(.directory)
                                   self.domain = domain
                                   assignedParameters.insert(.domain)
                                   self.url = url
                                   assignedParameters.insert(.url)
                                   self.shouldCreate = shouldCreate
                                   assignedParameters.insert(.shouldCreate)
                                   if urlForDirectoryInDomainAppropriateForUrlCreateShouldCreateShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return urlForDirectoryInDomainAppropriateForUrlCreateShouldCreateReturnValue
                               }

                               func fileExists(atPath path: String) -> Bool {
                                   calledMethods.insert(.fileExistsAtPathPathCalled)
                                   self.path = path
                                   assignedParameters.insert(.path)
                                   return fileExistsAtPathPathReturnValue
                               }

                               func removeItem(at URL: URL) throws {
                                   calledMethods.insert(.removeItemAtURLCalled)
                                   self.URL = URL
                                   assignedParameters.insert(.URL)
                                   if removeItemAtURLShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
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

                                   if self.contains(.urlsForDirectoryInDomainMaskCalled) {
                                       handleFirst()
                                       value += ".urlsForDirectoryInDomainMaskCalled"
                                   }
                                   if self.contains(.urlForDirectoryInDomainAppropriateForUrlCreateShouldCreateCalled) {
                                       handleFirst()
                                       value += ".urlForDirectoryInDomainAppropriateForUrlCreateShouldCreateCalled"
                                   }
                                   if self.contains(.fileExistsAtPathPathCalled) {
                                       handleFirst()
                                       value += ".fileExistsAtPathPathCalled"
                                   }
                                   if self.contains(.removeItemAtURLCalled) {
                                       handleFirst()
                                       value += ".removeItemAtURLCalled"
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

                                   if self.contains(.directory) {
                                       handleFirst()
                                       value += ".directory"
                                   }
                                   if self.contains(.domainMask) {
                                       handleFirst()
                                       value += ".domainMask"
                                   }
                                   if self.contains(.domain) {
                                       handleFirst()
                                       value += ".domain"
                                   }
                                   if self.contains(.url) {
                                       handleFirst()
                                       value += ".url"
                                   }
                                   if self.contains(.shouldCreate) {
                                       handleFirst()
                                       value += ".shouldCreate"
                                   }
                                   if self.contains(.path) {
                                       handleFirst()
                                       value += ".path"
                                   }
                                   if self.contains(.URL) {
                                       handleFirst()
                                       value += ".URL"
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
    
    func testCodeGeneration_fileManagerProtocol_trackPropertyActivityFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: fileManagerProtocol))
        let parameters = createParameters(protocolDeclaration: decl, trackPropertyActivity: false, public: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public class MockTest: FileManagerProtocol {
                           
                               public init() { }

                               // MARK: - Variables for Trackings Method Invocation

                               public struct Method: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let urlsForDirectoryInDomainMaskCalled = Method(rawValue: 1 << 0)
                                   public static let urlForDirectoryInDomainAppropriateForUrlCreateShouldCreateCalled = Method(rawValue: 1 << 1)
                                   public static let fileExistsAtPathPathCalled = Method(rawValue: 1 << 2)
                                   public static let removeItemAtURLCalled = Method(rawValue: 1 << 3)
                               }
                               private(set) public var calledMethods = Method()

                               public struct MethodParameter: OptionSet, Sendable {
                                   public let rawValue: UInt
                                   public init(rawValue: UInt) { self.rawValue = rawValue }
                                   public static let directory = MethodParameter(rawValue: 1 << 0)
                                   public static let domainMask = MethodParameter(rawValue: 1 << 1)
                                   public static let domain = MethodParameter(rawValue: 1 << 2)
                                   public static let url = MethodParameter(rawValue: 1 << 3)
                                   public static let shouldCreate = MethodParameter(rawValue: 1 << 4)
                                   public static let path = MethodParameter(rawValue: 1 << 5)
                                   public static let URL = MethodParameter(rawValue: 1 << 6)
                               }
                               private(set) public var assignedParameters = MethodParameter()

                               // MARK: - Variables for Captured Parameter Values

                               private(set) public var directory: FileManager.SearchPathDirectory?
                               private(set) public var domainMask: FileManager.SearchPathDomainMask?
                               private(set) public var domain: FileManager.SearchPathDomainMask?
                               private(set) public var url: URL?
                               private(set) public var shouldCreate: Bool?
                               private(set) public var path: String?
                               private(set) public var URL: URL?

                               // MARK: - Variables to Use as Method Return Values

                               public var urlsForDirectoryInDomainMaskReturnValue: [URL]!
                               public var urlForDirectoryInDomainAppropriateForUrlCreateShouldCreateReturnValue: URL!
                               public var fileExistsAtPathPathReturnValue: Bool!

                               public var errorToThrow: Error!
                               public var urlForDirectoryInDomainAppropriateForUrlCreateShouldCreateShouldThrowError = false
                               public var removeItemAtURLShouldThrowError = false


                               public func reset() {
                                   calledMethods = []
                                   assignedParameters = []
                                   directory = nil
                                   domainMask = nil
                                   domain = nil
                                   url = nil
                                   shouldCreate = nil
                                   path = nil
                                   URL = nil
                               }

                               // MARK: - Methods for Protocol Conformance

                               public func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL] {
                                   calledMethods.insert(.urlsForDirectoryInDomainMaskCalled)
                                   self.directory = directory
                                   assignedParameters.insert(.directory)
                                   self.domainMask = domainMask
                                   assignedParameters.insert(.domainMask)
                                   return urlsForDirectoryInDomainMaskReturnValue
                               }

                               public func url(for directory: FileManager.SearchPathDirectory, in domain: FileManager.SearchPathDomainMask, appropriateFor url: URL?, create shouldCreate: Bool) throws -> URL {
                                   calledMethods.insert(.urlForDirectoryInDomainAppropriateForUrlCreateShouldCreateCalled)
                                   self.directory = directory
                                   assignedParameters.insert(.directory)
                                   self.domain = domain
                                   assignedParameters.insert(.domain)
                                   self.url = url
                                   assignedParameters.insert(.url)
                                   self.shouldCreate = shouldCreate
                                   assignedParameters.insert(.shouldCreate)
                                   if urlForDirectoryInDomainAppropriateForUrlCreateShouldCreateShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
                                   }
                                   return urlForDirectoryInDomainAppropriateForUrlCreateShouldCreateReturnValue
                               }

                               public func fileExists(atPath path: String) -> Bool {
                                   calledMethods.insert(.fileExistsAtPathPathCalled)
                                   self.path = path
                                   assignedParameters.insert(.path)
                                   return fileExistsAtPathPathReturnValue
                               }

                               public func removeItem(at URL: URL) throws {
                                   calledMethods.insert(.removeItemAtURLCalled)
                                   self.URL = URL
                                   assignedParameters.insert(.URL)
                                   if removeItemAtURLShouldThrowError && errorToThrow != nil {
                                       throw errorToThrow
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

                                   if self.contains(.urlsForDirectoryInDomainMaskCalled) {
                                       handleFirst()
                                       value += ".urlsForDirectoryInDomainMaskCalled"
                                   }
                                   if self.contains(.urlForDirectoryInDomainAppropriateForUrlCreateShouldCreateCalled) {
                                       handleFirst()
                                       value += ".urlForDirectoryInDomainAppropriateForUrlCreateShouldCreateCalled"
                                   }
                                   if self.contains(.fileExistsAtPathPathCalled) {
                                       handleFirst()
                                       value += ".fileExistsAtPathPathCalled"
                                   }
                                   if self.contains(.removeItemAtURLCalled) {
                                       handleFirst()
                                       value += ".removeItemAtURLCalled"
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

                                   if self.contains(.directory) {
                                       handleFirst()
                                       value += ".directory"
                                   }
                                   if self.contains(.domainMask) {
                                       handleFirst()
                                       value += ".domainMask"
                                   }
                                   if self.contains(.domain) {
                                       handleFirst()
                                       value += ".domain"
                                   }
                                   if self.contains(.url) {
                                       handleFirst()
                                       value += ".url"
                                   }
                                   if self.contains(.shouldCreate) {
                                       handleFirst()
                                       value += ".shouldCreate"
                                   }
                                   if self.contains(.path) {
                                       handleFirst()
                                       value += ".path"
                                   }
                                   if self.contains(.URL) {
                                       handleFirst()
                                       value += ".URL"
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
//swiftlint:enable function_body_length file_length
