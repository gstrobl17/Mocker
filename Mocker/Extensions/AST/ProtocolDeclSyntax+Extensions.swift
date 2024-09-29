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
    
}
