//
//  ASTMockGeneratorTests.swift
//  MockerTests
//
//  Created by Greg Strobl on 1/24/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

@testable import Mocker
import XCTest
import SwiftSyntax
import SwiftSyntaxParser

final class ASTMockGeneratorTests: XCTestCase {

    var project: MockProject!
    var path1: AccessPathSyntax!
    var path2: AccessPathSyntax!
    var path3: AccessPathSyntax!
    var imports: [ImportDeclSyntax]!
    var dateFactory: MockDateCreating!
    var fullNameProvider: MockFullNameProviding!
    var generator: ASTMockGenerator!

    var expectedDate: String!
    var expectedYear: Int!
    
    enum Default {
        static let mockName = "MockTest"
        static let includeTestableImport = true
        static let testableTargetName = "Mocker"
        static let trackPropertyActivity = false
        static let organizationName = "Acme Corp"
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        project = MockProject()
        project.objectsReturnValue = ["attributes": ["ORGANIZATIONNAME": Default.organizationName]]
        project.filePathReturnValue = "/usr/local/project/file.swift"
        path1 = AccessPathSyntax([AccessPathComponentSyntax(name: TokenSyntax(.identifier("Foundation"), presence: .present))])
        path2 = AccessPathSyntax([AccessPathComponentSyntax(name: TokenSyntax(.identifier("UIKit"), presence: .present))])
        path3 = AccessPathSyntax([AccessPathComponentSyntax(name: TokenSyntax(.identifier("Core"), presence: .present))])
        imports = [ImportDeclSyntax(path: path1), ImportDeclSyntax(path: path2), ImportDeclSyntax(path: path3)]
        
        dateFactory = MockDateCreating()
        dateFactory._now = Date(timeIntervalSince1970: TimeInterval(123456))
        fullNameProvider = MockFullNameProviding()
        createGenerator()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        expectedDate = formatter.string(from: dateFactory._now)
        expectedYear = Calendar.current.component(.year, from: dateFactory._now)
    }
    
    func createGenerator(
        swiftlintAware: Bool? = nil,
        dateFactory: DateCreating? = nil,
        fullNameProvider: FullNameProviding? = nil
    ) {
        generator = ASTMockGenerator(
            swiftlintAware: swiftlintAware ?? false,
            dateFactory: dateFactory ?? self.dateFactory,
            fullNameProvider: fullNameProvider ?? self.fullNameProvider
        )
    }

    func createParameters(
        project: Project? = nil,
        imports: [ImportDeclSyntax]? = nil,
        protocolDeclaration: ProtocolDeclSyntax,
        mockName: String? = nil,
        includeTestableImport: Bool? = nil,
        testableTargetName: String? = nil,
        trackPropertyActivity: Bool? = nil
    ) -> MockGeneratorParameters {
        MockGeneratorParameters(
            project: project ?? self.project,
            imports: imports ?? self.imports,
            protocolDeclaration: protocolDeclaration,
            mockName: mockName ?? Default.mockName,
            includeTestableImport: includeTestableImport ?? Default.includeTestableImport,
            testableTargetName: testableTargetName ?? Default.testableTargetName,
            trackPropertyActivity: trackPropertyActivity ?? Default.trackPropertyActivity
        )
    }
    
    func protocolDeclaration(for input: String) throws -> ProtocolDeclSyntax? {
        let sourceFileSyntax = try SyntaxParser.parse(source: input)
        let sourceFileInformation = SourceFileInformation(viewMode: .sourceAccurate)
        sourceFileInformation.walk(sourceFileSyntax)
        return sourceFileInformation.protocols.first
    }
    
    // MARK: Empty Protocol
    
    let emptyProtocol = """
                        protocol Empty {
                        }
                        """
    
    func testCodeGeneration_emptyProtocol_swiftlintAwareFALSE_includeTestableImportFALSE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: emptyProtocol))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear). All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core

                           class MockTest: Empty {


                               func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
    }
    
    func testCodeGeneration_emptyProtocol_swiftlintAwareTRUE_includeTestableImportTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: emptyProtocol))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true)
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

                           class MockTest: Empty {


                               func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
    }
    
    func testCodeGeneration_emptyProtocol_swiftlintAwareTRUE_includeTestableImportTRUE_emptyImportList() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: emptyProtocol))
        let parameters = createParameters(imports: [], protocolDeclaration: decl, includeTestableImport: true)
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

                           class MockTest: Empty {


                               func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
    }
}
