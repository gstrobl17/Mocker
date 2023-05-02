//
//  SourceFileInformation.swift
//  Mocker
//
//  Created by Greg on 2/25/18.
//

import Foundation
import SwiftSyntax

class SourceFileInformation: SyntaxVisitor {
    
    private(set) var imports = [ImportDeclSyntax]()
    private(set) var protocols = [ProtocolDeclSyntax]()

    override func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
        imports.append(node)
        return .skipChildren
    }

    override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
        protocols.append(node)
        return .skipChildren
    }

}
