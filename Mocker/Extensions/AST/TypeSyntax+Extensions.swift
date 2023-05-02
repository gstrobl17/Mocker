//
//  TypeSyntax+Extensions.swift
//  Mocker
//
//  Created by Greg Strobl on 6/22/22.
//

import SwiftSyntax

extension TypeSyntax {
    
    func processedTypeName(removeOptional: Bool = false, removeExclamationMark: Bool = false, removeEscaping: Bool = false) -> String {
        var typeName = self.withoutTrivia().description

        if removeOptional, typeName.hasSuffix("?") {
            typeName = String(typeName.dropLast())
        }
        
        if removeExclamationMark, typeName.hasSuffix("!") {
            typeName = String(typeName.dropLast())
        }

        if removeEscaping, typeName.hasPrefix("@escaping ") {
            typeName = typeName.replacingOccurrences(of: "@escaping ", with: "")
        }
        
        if removeEscaping, typeName.hasPrefix("@escaping") {
            typeName = typeName.replacingOccurrences(of: "@escaping", with: "")
        }

        return typeName
    }
 
    var isOptional: Bool {
        self.is(OptionalTypeSyntax.self)
    }
    
    var isFunction: Bool {
        var attributedTypeSyntax: AttributedTypeSyntax?

        if let optional = self.as(OptionalTypeSyntax.self), let type = optional.wrappedType.as(AttributedTypeSyntax.self) {
            attributedTypeSyntax = type
        }
        if let type = self.as(AttributedTypeSyntax.self) {
            attributedTypeSyntax = type
        }

        guard let attributedTypeSyntax = attributedTypeSyntax else { return false }
        return attributedTypeSyntax.baseType.is(FunctionTypeSyntax.self)
    }

}
