//swiftlint:disable type_body_length file_length
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
import SwiftParser

final class ASTMockGeneratorTests: XCTestCase {

    var dataSource: MockSourceFileDataSource!
    var path1: ImportPathComponentListSyntax!
    var path2: ImportPathComponentListSyntax!
    var path3: ImportPathComponentListSyntax!
    var imports: [ImportDeclSyntax]!
    var dateFactory: MockDateCreating!
    var fullNameProvider: MockFullNameProviding!
    var generator: ASTMockGenerator!

    var expectedDate: String!
    var expectedYear: Int!
    
    enum Default {
        static let mockName = "MockTest"
        static let includeHeader = true
        static let includeTestableImport = true
        static let testableTargetName = "Mocker"
        static let trackPropertyActivity = false
        static let `public` = false
        static let organizationName = "Acme Corp"
    }
    
    private func generatePopulatedHeader(includeTestableImport: Bool) -> String {
        guard let expectedDate else { return "expectedDate is nil "}
        guard let expectedYear else { return "expectedYear is nil "}
        var string = """
            //
            //  MockTest.swift
            //  file
            //
            // Created by Chris X. Programmer on \(expectedDate).
            // Copyright © \(expectedYear). All rights reserved.
            //

            
            """
        if includeTestableImport {
            string += """
            @testable import Mocker
            
            """
        }
        string += """
            import Foundation
            import UIKit
            import Core
            """
        return string
    }
    
    // \(expectedPopulatedHeader)
    var expectedPopulatedHeader: String {
        generatePopulatedHeader(includeTestableImport: false)
    }
    
    // \(expectedPopulatedHeaderWithTestableImport)
    var expectedPopulatedHeaderWithTestableImport: String {
        generatePopulatedHeader(includeTestableImport: true)
    }
    
    private func generateExpectedCustomReflectableString(
        isPublic: Bool,
        childrenPairs: [(key: String, Value: String)]
    ) -> String {
        let publicSpecifier = isPublic ? "public " : ""
        var string = """
            extension MockTest: CustomReflectable {
                \(publicSpecifier)var customMirror: Mirror {
                    Mirror(self,
                           children: [
            
            """
        for pair in childrenPairs {
            string += """
                            "\(pair.key)": \(pair.Value),
            
            """
        }
        string += """
                           ],
                           displayStyle: .none
                    )
                }
            }
            
            """
        return string
    }
    
    // \(expectedCustomReflectableWithCalledMethods)
    var expectedCustomReflectableWithCalledMethods: String {
        generateExpectedCustomReflectableString(
            isPublic: false,
            childrenPairs: [("calledMethods", "calledMethods")]
        )
    }
    
    // \(expectedPublicCustomReflectableWithCalledMethods)
    var expectedPublicCustomReflectableWithCalledMethods: String {
        generateExpectedCustomReflectableString(
            isPublic: true,
            childrenPairs: [("calledMethods", "calledMethods")]
        )
    }

    // \(expectedCustomReflectableWithCalledMethodsAndAssignedParameters)
    var expectedCustomReflectableWithCalledMethodsAndAssignedParameters: String {
        generateExpectedCustomReflectableString(
            isPublic: false,
            childrenPairs: [("calledMethods", "calledMethods"), ("assignedParameters", "assignedParameters")]
        )
    }

    // \(expectedPublicCustomReflectableWithCalledMethodsAndAssignedParameters)
    var expectedPublicCustomReflectableWithCalledMethodsAndAssignedParameters: String {
        generateExpectedCustomReflectableString(
            isPublic: true,
            childrenPairs: [("calledMethods", "calledMethods"), ("assignedParameters", "assignedParameters")]
        )
    }
    
    // \(expectedCustomReflectableWithCalledStaticMethods)
    var expectedCustomReflectableWithCalledStaticMethods: String {
        generateExpectedCustomReflectableString(
            isPublic: false,
            childrenPairs: [("calledStaticMethods", "MockTest.calledStaticMethods")]
        )
    }
    
    // \(expectedPublicCustomReflectableWithCalledStaticMethods)
    var expectedPublicCustomReflectableWithCalledStaticMethods: String {
        generateExpectedCustomReflectableString(
            isPublic: true,
            childrenPairs: [("calledStaticMethods", "MockTest.calledStaticMethods")]
        )
    }

    // \(expectedCustomReflectableWithCalledStaticMethodsAndAssignedStaticParameters)
    var expectedCustomReflectableWithCalledStaticMethodsAndAssignedStaticParameters: String {
        generateExpectedCustomReflectableString(
            isPublic: false,
            childrenPairs: [("calledStaticMethods", "MockTest.calledStaticMethods"),
                            ("assignedStaticParameters", "MockTest.assignedStaticParameters")]
        )
    }

    // \(expectedPublicCustomReflectableWithCalledStaticMethodsAndAssignedStaticParameters)
    var expectedPublicCustomReflectableWithCalledStaticMethodsAndAssignedStaticParameters: String {
        generateExpectedCustomReflectableString(
            isPublic: true,
            childrenPairs: [("calledStaticMethods", "MockTest.calledStaticMethods"),
                            ("assignedStaticParameters", "MockTest.assignedStaticParameters")]
        )
    }

    // \(expectedCustomReflectableWithCalledMethodsAndCalledStaticMethods)
    var expectedCustomReflectableWithCalledMethodsAndCalledStaticMethods: String {
        generateExpectedCustomReflectableString(
            isPublic: false,
            childrenPairs: [("calledMethods", "calledMethods"), ("calledStaticMethods", "MockTest.calledStaticMethods")]
        )
    }

    // \(expectedPublicCustomReflectableWithCalledMethodsAndCalledStaticMethods)
    var expectedPublicCustomReflectableWithCalledMethodsAndCalledStaticMethods: String {
        generateExpectedCustomReflectableString(
            isPublic: true,
            childrenPairs: [("calledMethods", "calledMethods"), ("calledStaticMethods", "MockTest.calledStaticMethods")]
        )
    }

    // \(expectedCustomReflectableWithAllMethods)
    var expectedCustomReflectableWithAllMethods: String {
        generateExpectedCustomReflectableString(
            isPublic: false,
            childrenPairs: [("calledMethods", "calledMethods"), 
                            ("calledStaticMethods", "MockTest.calledStaticMethods"),
                            ("assignedParameters", "assignedParameters"),
                            ("assignedStaticParameters", "MockTest.assignedStaticParameters")
                           ]
        )
    }

    // \(expectedPublicCustomReflectableWithAllMethods)
    var expectedPublicCustomReflectableWithAllMethods: String {
        generateExpectedCustomReflectableString(
            isPublic: true,
            childrenPairs: [("calledMethods", "calledMethods"),
                            ("calledStaticMethods", "MockTest.calledStaticMethods"),
                            ("assignedParameters", "assignedParameters"),
                            ("assignedStaticParameters", "MockTest.assignedStaticParameters")
                           ]
        )
    }

    override func setUpWithError() throws {
        try super.setUpWithError()

        dataSource = MockSourceFileDataSource()
        dataSource.filePathReturnValue = "/usr/local/dataSource/file.swift"
        dataSource._projectName = "file"
        path1 = ImportPathComponentListSyntax([ImportPathComponentSyntax(name: TokenSyntax(.identifier("Foundation"), presence: .present))])
        path2 = ImportPathComponentListSyntax([ImportPathComponentSyntax(name: TokenSyntax(.identifier("UIKit"), presence: .present))])
        path3 = ImportPathComponentListSyntax([ImportPathComponentSyntax(name: TokenSyntax(.identifier("Core"), presence: .present))])
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
        dateFactory: (any DateCreating)? = nil,
        fullNameProvider: (any FullNameProviding)? = nil
    ) {
        generator = ASTMockGenerator(
            swiftlintAware: swiftlintAware ?? false,
            dateFactory: dateFactory ?? self.dateFactory,
            fullNameProvider: fullNameProvider ?? self.fullNameProvider
        )
    }

    func createParameters(
        dataSource: (any SourceFileDataSource)? = nil,
        imports: [ImportDeclSyntax]? = nil,
        protocolDeclaration: ProtocolDeclSyntax,
        mockName: String? = nil,
        includeHeader: Bool? = nil,
        includeTestableImport: Bool? = nil,
        testableTargetName: String? = nil,
        trackPropertyActivity: Bool? = nil,
        public: Bool? = nil
    ) -> MockGeneratorParameters {
        MockGeneratorParameters(
            dataSource: dataSource ?? self.dataSource,
            imports: imports ?? self.imports,
            protocolDeclaration: protocolDeclaration,
            mockName: mockName ?? Default.mockName,
            includeHeader: includeHeader ?? Default.includeHeader,
            includeTestableImport: includeTestableImport ?? Default.includeTestableImport,
            testableTargetName: testableTargetName ?? Default.testableTargetName,
            trackPropertyActivity: trackPropertyActivity ?? Default.trackPropertyActivity,
            public: `public` ?? Default.public
        )
    }
    
    func protocolDeclaration(for input: String) -> ProtocolDeclSyntax? {
        let sourceFileSyntax = Parser.parse(source: input)
        let sourceFileInformation = SourceFileInformation(viewMode: .sourceAccurate)
        sourceFileInformation.walk(sourceFileSyntax)
        return sourceFileInformation.protocols.first
    }
    
    // MARK: Empty Protocol
    
    var emptyProtocol: String {
        """
        protocol Empty {
        }
        """
    }
    
    func testCodeGeneration_emptyProtocol_includeHeaderTRUE_swiftlintAwareFALSE_includeTestableImportFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: emptyProtocol))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           class MockTest: Empty {


                               func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }
    
    func testCodeGeneration_emptyProtocol_includeHeaderTRUE_swiftlintAwareFALSE_includeTestableImportFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: emptyProtocol))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           \(expectedPopulatedHeader)

                           public class MockTest: Empty {

                               public init() { }


                               public func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_emptyProtocol_includeHeaderFALSE_swiftlintAwareFALSE_includeTestableImportFALSE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: emptyProtocol))
        let parameters = createParameters(protocolDeclaration: decl, includeHeader: false, includeTestableImport: false)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
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
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_emptyProtocol_includeHeaderFALSE_swiftlintAwareFALSE_includeTestableImportFALSE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: emptyProtocol))
        let parameters = createParameters(protocolDeclaration: decl, includeHeader: false, includeTestableImport: false, public: true)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           import Foundation
                           import UIKit
                           import Core

                           public class MockTest: Empty {

                               public init() { }


                               public func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_emptyProtocol_organizationSetupInProject_includeHeaderTRUE_swiftlintAwareFALSE_includeTestableImportFALSE_publicFALSE() throws {
        dataSource._organizationName = Default.organizationName
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
                           // Copyright © \(expectedYear) Acme Corp. All rights reserved.
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
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_emptyProtocol_organizationSetupInProject_includeHeaderTRUE_swiftlintAwareFALSE_includeTestableImportFALSE_publicTRUE() throws {
        dataSource._organizationName = Default.organizationName
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: emptyProtocol))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: false, public: true)
        createGenerator(swiftlintAware: false)
        let expectedCode = """
                           //
                           //  MockTest.swift
                           //  file
                           //
                           // Created by Chris X. Programmer on \(expectedDate).
                           // Copyright © \(expectedYear) Acme Corp. All rights reserved.
                           //

                           import Foundation
                           import UIKit
                           import Core

                           public class MockTest: Empty {

                               public init() { }


                               public func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_emptyProtocol_includeHeaderTRUE_swiftlintAwareTRUE_includeTestableImportTRUE_publicFALSE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: emptyProtocol))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true)
        createGenerator(swiftlintAware: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           class MockTest: Empty {


                               func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_emptyProtocol_includeHeaderTRUE_swiftlintAwareTRUE_includeTestableImportTRUE_publicTRUE() throws {
        let decl = try XCTUnwrap(protocolDeclaration(for: emptyProtocol))
        let parameters = createParameters(protocolDeclaration: decl, includeTestableImport: true, public: true)
        createGenerator(swiftlintAware: true)
        let expectedCode = """
                           \(expectedPopulatedHeaderWithTestableImport)

                           public class MockTest: Empty {

                               public init() { }


                               public func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
    }

    func testCodeGeneration_emptyProtocol_includeHeaderTRUE_swiftlintAwareTRUE_includeTestableImportTRUE_emptyImportList_publicFALSE() throws {
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
        printFirstDifference(code, expectedCode)
   }

    func testCodeGeneration_emptyProtocol_includeHeaderTRUE_swiftlintAwareTRUE_includeTestableImportTRUE_emptyImportList_publicTRUE() throws {
        let expectedDate = try XCTUnwrap(self.expectedDate)
        let expectedYear = try XCTUnwrap(self.expectedYear)
        let decl = try XCTUnwrap(protocolDeclaration(for: emptyProtocol))
        let parameters = createParameters(imports: [], protocolDeclaration: decl, includeTestableImport: true, public: true)
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

                           public class MockTest: Empty {

                               public init() { }
                           

                               public func reset() {
                               }

                           }
                           
                           """
        
        let code = generator.generateMockCode(for: parameters)
        
        XCTAssertEqual(code, expectedCode)
        printFirstDifference(code, expectedCode)
   }
}

//swiftlint:enable type_body_length file_length
