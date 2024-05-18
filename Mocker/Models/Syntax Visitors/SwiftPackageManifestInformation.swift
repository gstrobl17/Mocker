//
//  SwiftPackageManifestInformation.swift
//  Mocker
//
//  Created by Greg Strobl on 5/16/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation
import SwiftSyntax

class SwiftPackageManifestInformation: SyntaxVisitor {
    
    private(set) var imports = [ImportDeclSyntax]()
    private(set) var variables = [VariableDeclSyntax]()

    override func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
        imports.append(node)
        return .skipChildren
    }
    
    override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
        variables.append(node)
        return .skipChildren
    }

}
