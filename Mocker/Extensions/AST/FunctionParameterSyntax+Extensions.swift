//
//  FunctionParameterSyntax+Extensions.swift
//  Mocker
//
//  Created by Greg Strobl on 6/22/22.
//

import Foundation
import SwiftSyntax

extension FunctionParameterSyntax {
    
    var isOptional: Bool {
        type.isOptional
    }
    
    var isFunction: Bool {
        type.isFunction
    }

    var nameForConcatenatedVariableName: String {
        var name = ""
        
        if firstName.text != "_" {
            name += firstName.text.firstUppercased
        }

        if let secondName = secondName {
            if name.isEmpty {
                name = secondName.text
            } else {
                name += secondName.text.firstUppercased
            }
        }

        return name
    }

    var nameForParameter: String {
        if let secondName = secondName {
            return secondName.text
        }

        return firstName.text
    }

    var typeNameForParameter: String {
        guard let type = type.as(TypeSyntax.self) else {
            // Haven't see this before. Set a break point and do a `po self` here and try to work out the data types.
            return "NO TYPE SUPPLIED"
        }
        return type.processedTypeName()
    }
    
    var nonEscapingTypeNameForParameter: String {
        guard let type = type.as(TypeSyntax.self) else {
            // Haven't see this before. Set a break point and do a `po self` here and try to work out the data types.
            return "NO TYPE SUPPLIED"
        }
        return type.processedTypeName(removeEscaping: true)
    }

    var baseTypeNameForParameter: String {
        guard let type = type.as(TypeSyntax.self) else {
            // Haven't see this before. Set a break point and do a `po self` here and try to work out the data types.
            return "NO TYPE SUPPLIED"
        }
        return type.processedTypeName(removeOptional: true, removeEscaping: true)
    }

    var shouldCallVariableName: String {
        "shouldCall" + nameForParameter.firstUppercased
    }

    typealias ResultCompletionHandlerDetail = (name: String, successType: TypeSyntax, failureType: TypeSyntax)
    enum ResultCompletionHandlerAnswer {
        case yes(ResultCompletionHandlerDetail)
        case no
    }

    var isResultCompletionHandler: ResultCompletionHandlerAnswer {
        guard
            // Is the parameter a function? (of the type with result type)
            let typeSyntax = type.as(AttributedTypeSyntax.self),
            let baseType = typeSyntax.baseType.as(FunctionTypeSyntax.self),

            // Does the parameter have one argument named "Result"?
            baseType.parameters.count == 1,
            let firstArgument = baseType.parameters.first,
            let firstArgumentType = firstArgument.type.as(IdentifierTypeSyntax.self),
            firstArgumentType.name.text == "Result",
            
            // Does the first argument have a generic argument clause with two parameters?
            let genericArgumentClause = firstArgumentType.genericArgumentClause,
            genericArgumentClause.arguments.count == 2,
            let firstGenericArgument = genericArgumentClause.arguments.first,
            let secondGenericArgument = genericArgumentClause.arguments.last

        else {
            return .no
        }
        
        let successType = firstGenericArgument.argument
        let failureType = secondGenericArgument.argument
        let detail = (name: nameForParameter, successType: successType, failureType: failureType)
        return .yes(detail)
    }

    func typeNameForDetail(_ detail: ResultCompletionHandlerDetail) -> String {
        "Result<\(detail.successType.processedTypeName()), \(detail.failureType.processedTypeName())>"
    }
}
