//
//  VariableDeclSyntax+Extensions.swift
//  Mocker
//
//  Created by Greg Strobl on 6/21/22.
//

import SwiftSyntax

extension VariableDeclSyntax {
    
    var isStatic: Bool {
        modifiers.containsStaticModifier
    }
    
    var isOptional: Bool {
        assert(bindings.count == 1)
        guard let binding = bindings.first else { return false }
        guard let typeAnnotation = binding.typeAnnotation else { return false }
        return typeAnnotation.type.isOptional
    }
    
    var isSomeOrAnyType: Bool {
        assert(bindings.count == 1)
        guard let binding = bindings.first else { return false }
        guard let typeAnnotation = binding.typeAnnotation else { return false }
        return typeAnnotation.type.is(SomeOrAnyTypeSyntax.self)
    }

    var isDelegate: Bool {
        nameForCode == "delegate"
    }

    var internalNameForCode: String {
        assert(bindings.count == 1)
        guard let binding = bindings.first else { return "Unexpected Binding Count(\(bindings.count)" }
        return "_" + binding.pattern.description
    }

    var nameForCode: String {
        assert(bindings.count == 1)
        guard let binding = bindings.first else { return "Unexpected Binding Count(\(bindings.count)" }
        return binding.pattern.description
    }
    
    var typeForCode: String {
        assert(bindings.count == 1)
        guard let binding = bindings.first else { return "Unexpected Binding Count(\(bindings.count)" }
        guard let typeAnnotation = binding.typeAnnotation else { return "Type annotation not found for variable" }
        
        return typeAnnotation.description.trimmingTrailingCharacters(in: .whitespaces)
    }
    
    var processedTypeNameForCode: String {
        assert(bindings.count == 1)
        guard let binding = bindings.first else { return "Unexpected Binding Count(\(bindings.count)" }
        guard let typeAnnotation = binding.typeAnnotation else { return "Type annotation not found for variable" }
        
        return typeAnnotation.type.processedTypeName(removeEscaping: true)
    }

    var hasGetter: Bool {
        assert(bindings.count == 1)
        guard let binding = bindings.first else { return false }
        guard let accessor = binding.accessorBlock else { return false }
        let description = accessor.description
        let parts = description.split(separator: " ")
        return parts.contains("get")
    }

    var hasSetter: Bool {
        assert(bindings.count == 1)
        guard let binding = bindings.first else { return false }
        guard let accessor = binding.accessorBlock else { return false }
        let description = accessor.description
        let parts = description.split(separator: " ")
        return parts.contains("set")
    }

    var calledGetterVariableName: String {
        nameForCode + "GetterCalled"
    }

    var getterSignatureString: String {
        var string = ""
        if isStatic {
            string += "static "
        }
        string += "getter:\(nameForCode)"
        return string
    }

    var calledSetterVariableName: String {
        nameForCode + "SetterCalled"
    }

    var setterCaptureValueVariableName: String {
        nameForCode + "InSetter"
    }

    var setterSignatureString: String {
        var string = ""
        if isStatic {
            string += "static "
        }
        string += "setter:\(nameForCode)"
        return string
    }
    
    var typeFromInitializerClause: String {
        assert(bindings.count == 1)
        guard let binding = bindings.first else { return "Unexpected Binding Count(\(bindings.count)" }
        guard let initializer = binding.initializer else { return "Type not found for variable" }
        guard let functionCall = initializer.value.as(FunctionCallExprSyntax.self) else { return "Initializer value not FunctionCallExprSyntax" }
        guard let identifier = functionCall.calledExpression.as(DeclReferenceExprSyntax.self) else { return "Function Call calledExpression is not IdentifierExprSyntax" }
        
        return identifier.baseName.text
    }

}
