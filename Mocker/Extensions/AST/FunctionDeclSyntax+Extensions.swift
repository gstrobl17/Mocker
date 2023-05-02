//
//  FunctionDeclSyntax+Extensions.swift
//  Mocker
//
//  Created by Greg Strobl on 6/21/22.
//

import SwiftSyntax

extension FunctionDeclSyntax {
    
    var isStatic: Bool {
        guard let modifiers = modifiers else { return false }
        return modifiers.containsStaticModifier
    }

    var calledVariableName: String {
        concatenatedVariableName + "Called"
    }
    
    var returnValueVariableName: String {
        concatenatedVariableName + "ReturnValue"
    }

    var shouldThrowErrorVariableName: String {
        concatenatedVariableName + "ShouldThrowError"
    }

    private var concatenatedVariableName: String {
        var concatenatedVariableName = identifier.text
        for parameter in signature.input.parameterList {
            concatenatedVariableName += parameter.nameForConcatenatedVariableName.firstUppercased
        }
        return concatenatedVariableName
    }
    
    var signatureString: String {
        self.withoutTrivia().description
    }

    var shouldCallCompletionHandlerVariableName: String {
        "shouldCall" + concatenatedVariableName.firstUppercased + "CompletionHander"
    }

    var completionHandlerResultVariableName: String {
        concatenatedVariableName + "CompletionHanderResult"
    }

}
