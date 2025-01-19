//
//  ProtocolDeclSyntax+Extensions.swift
//  Mocker
//
//  Created by Greg Strobl on 9/29/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import SwiftSyntax

extension ProtocolDeclSyntax {
    
    var hasMainActorAnnotation: Bool {
        let attributeNames = attributes.compactMap { $0.as(AttributeSyntax.self)?.attributeName.trimmedDescription }
        return attributeNames.contains("MainActor")
    }
    
    /*
     ProtocolDeclSyntax
     ├─attributes: AttributeListSyntax
     ├─modifiers: DeclModifierListSyntax
     ├─protocolKeyword: keyword(SwiftSyntax.Keyword.protocol)
     ├─name: identifier("Empty")
     ├─inheritanceClause: InheritanceClauseSyntax
     │ ├─colon: colon
     │ ╰─inheritedTypes: InheritedTypeListSyntax
     │   ╰─[0]: InheritedTypeSyntax
     │     ╰─type: IdentifierTypeSyntax
     │       ╰─name: identifier("Actor")
     ╰─memberBlock: MemberBlockSyntax
       ├─leftBrace: leftBrace
       ├─members: MemberBlockItemListSyntax
       ╰─rightBrace: rightBrace
     */
    var isActor: Bool {
        guard let inheritedTypes = inheritanceClause?.inheritedTypes else { return false }
        return inheritedTypes.contains { type in
            guard let type = type.as(InheritedTypeSyntax.self),
                  let identifier = type.type.as(IdentifierTypeSyntax.self),
                  let name = identifier.name.as(TokenSyntax.self) else { return false }
            return name.text == "Actor"
        }
    }
    
}

