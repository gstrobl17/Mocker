//
//  DeclModifierListSyntax+Extensions.swift
//  Mocker
//
//  Created by Greg Strobl on 6/21/22.
//

import SwiftSyntax

extension DeclModifierListSyntax {
    
    var containsStaticModifier: Bool {
        guard !isEmpty else { return false }
        for modifier in self where modifier.name.text == "static" {
            return true
        }
        return false
    }
    
}
