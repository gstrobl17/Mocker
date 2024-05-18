//
//  MockGeneratorParameters.swift
//  Mocker
//
//  Created by Greg on 2/27/18.
//

import Foundation
import SwiftSyntax

class MockGeneratorParameters: SyntaxVisitor {
    let dataSource: SourceFileDataSource
    let imports: [ImportDeclSyntax]
    let protocolDeclaration: ProtocolDeclSyntax
    let mockName: String
    let includeHeader: Bool
    let includeTestableImport: Bool
    let testableTargetName: String
    let trackPropertyActivity: Bool
    let `public`: Bool

    private(set) var variables = [VariableDeclSyntax]()
    private(set) var methods = [FunctionDeclSyntax]()

    init(
        dataSource: SourceFileDataSource,
        imports: [ImportDeclSyntax],
        protocolDeclaration: ProtocolDeclSyntax,
        mockName: String,
        includeHeader: Bool,
        includeTestableImport: Bool,
        testableTargetName: String,
        trackPropertyActivity: Bool,
        public: Bool
    ) {
        self.dataSource = dataSource
        self.imports = imports
        self.protocolDeclaration = protocolDeclaration
        self.mockName = mockName
        self.includeHeader = includeHeader
        self.includeTestableImport = includeTestableImport
        self.testableTargetName = testableTargetName
        self.trackPropertyActivity = trackPropertyActivity
        self.public = `public`
        super.init(viewMode: .sourceAccurate)

        // To get an object tree for the selected protocol,
        //  add a break point here and use "po protocolDeclaration".
        //
        //  (This will give you the tree with the right object/protocol types
        //  to debug/develop with.)
        walk(protocolDeclaration)
    }
    
    override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
        variables.append(node)
        return .skipChildren
    }

    override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        methods.append(node)
        return .skipChildren
    }
}
