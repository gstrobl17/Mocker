//
//  ASTMockGenerator.swift
//  Mocker
//
//  Created by Greg on 2/27/18.
//

import Foundation
import SwiftSyntax

class ASTMockGenerator: MockGenerating {

    let dateFactory: any DateCreating
    let fullNameProvider: any FullNameProviding
    internal var code = ""
    internal var contentGenerated = false
    internal let indentation = "    "
    internal let propertyTracker = NameTracker()
    internal let calledAttributeTracker = NameTracker()
    internal let parameterTracker = NameTracker()
    internal var generateInstanceErrorToThrowVariable = false
    internal var generateClassErrorToThrowVariable = false
    internal var publicAccessQualifier = ""

    enum VariableName {
        static let staticErrorToThrow = "errorToThrow"
        static let instanceErrorToThrow = "errorToThrow"

        static let calledMethods = "calledMethods"
        static let calledStaticMethods = "calledStaticMethods"
        static let assignedParameters = "assignedParameters"
        static let assignedStaticParameters = "assignedStaticParameters"
        
        static let parameterNameSuffixForNameCollisions = "Parameter"
    }

    enum TypeName {
        static let Method = "Method"
        static let StaticMethod = "StaticMethod"
        static let MethodParameter = "MethodParameter"
        static let StaticMethodParameter = "StaticMethodParameter"
    }

    init(
        dateFactory: any DateCreating = DateFactory(),
        fullNameProvider: any FullNameProviding = FullNameProvider()
    ) {
        self.dateFactory = dateFactory
        self.fullNameProvider = fullNameProvider
    }

    // MARK: - Pre-parsing functions -

    func getterCalledAttributeName(for variable: VariableDeclSyntax) -> String? {
        let name = variable.calledGetterVariableName
        let signature = variable.getterSignatureString
        guard let calledAttributeName = calledAttributeTracker.uniqueName(for: name, identifiedBy: signature) else {
            assertionFailure("Unmapped call attribute name/signature: {\(name), \(signature)})")
            return nil
        }
        return calledAttributeName
    }

    func setterCalledAttributeName(for variable: VariableDeclSyntax) -> String? {
        let name = variable.calledSetterVariableName
        let signature = variable.setterSignatureString
        guard let calledAttributeName = calledAttributeTracker.uniqueName(for: name, identifiedBy: signature) else {
            assertionFailure("Unmapped call attribute name/signature: {\(name), \(signature)})")
            return nil
        }
        return calledAttributeName
    }
    
    func calledAttributeName(for method: FunctionDeclSyntax) -> String? {
        let name = method.calledVariableName
        let signature = method.signatureString
        guard let calledAttributeName = calledAttributeTracker.uniqueName(for: name, identifiedBy: signature) else {
            assertionFailure("Unmapped call attribute name/signature: {\(name), \(signature)})")
            return nil
        }
        return calledAttributeName
    }

    func parameterName(for parameter: FunctionParameterSyntax, in method: FunctionDeclSyntax) -> String? {
        switch parameter.isResultCompletionHandler {
        case .yes(let details):
            return completionHandlerVariableName(for: details)
        case .no:
            let name = parameter.nameForParameter
            let type = parameter.baseTypeNameForParameter
            guard var parameterName = parameterTracker.uniqueName(for: name, identifiedBy: type) else {
                assertionFailure("Unmapped parameter name/type: {\(name), \(type)})")
                return nil
            }
            let nameCollisionWithProperty = (method.isStatic) ? calledAttributeTracker.staticUniqueNames.contains(parameterName) || propertyTracker.staticUniqueNames.contains(parameterName)
                                                              : calledAttributeTracker.nonStaticUniqueNames.contains(parameterName) || propertyTracker.nonStaticUniqueNames.contains(parameterName)
            if nameCollisionWithProperty {
                parameterName += VariableName.parameterNameSuffixForNameCollisions
            }
            return parameterName
        }
    }

    func determineIfAnyMethodsThrow(for parameters: MockGeneratorParameters) {
        for method in parameters.methods where method.signature.throwsOrRethrows {
            if method.isStatic {
                generateClassErrorToThrowVariable = true
            } else {
                generateInstanceErrorToThrowVariable = true
            }

            // If both variables have been set to true, we can leave early
            if generateClassErrorToThrowVariable && generateInstanceErrorToThrowVariable {
                break
            }
        }
    }

    //swiftlint:disable:next cyclomatic_complexity
    func completionHandlerVariableName(for detail: FunctionParameterSyntax.ResultCompletionHandlerDetail) -> String {
        // Start with the type
        var name = "UNDETERMINED"

        // Prefix the name of the variable with the type
        if let arrayType = detail.successType.as(ArrayTypeSyntax.self) {
            
            if let type = arrayType.element.as(IdentifierTypeSyntax.self) {
                let lastCharacter = type.name.text.last
                
                if lastCharacter == "s" {
                    name = type.name.text.firstLowercased + "es"
                } else {
                    name = type.name.text.firstLowercased + "s"
                }
            }

            if let someOrAnyType = arrayType.element.as(SomeOrAnyTypeSyntax.self), let type = someOrAnyType.constraint.as(IdentifierTypeSyntax.self) {
                let lastCharacter = type.name.text.last
                
                if lastCharacter == "s" {
                    name = someOrAnyType.someOrAnySpecifier.text + type.name.text.firstUppercased + "es"
                } else {
                    name = someOrAnyType.someOrAnySpecifier.text + type.name.text.firstUppercased + "s"
                }
            }
        }

        if let type = detail.successType.as(IdentifierTypeSyntax.self) {
            name = type.name.text.firstLowercased
        }

        if let optional = detail.successType.as(OptionalTypeSyntax.self) {
            if let type = optional.wrappedType.as(IdentifierTypeSyntax.self) {
                name = "optional" + type.name.text.firstUppercased
            }
            
            if let tupleType = optional.wrappedType.as(TupleTypeSyntax.self),
                tupleType.elements.count == 1,
                let tupleTypeElement = tupleType.elements.first?.as(TupleTypeElementSyntax.self),
                let someOrAnyType = tupleTypeElement.type.as(SomeOrAnyTypeSyntax.self),
                let type = someOrAnyType.constraint.as(IdentifierTypeSyntax.self) {
                name = "optional" + someOrAnyType.someOrAnySpecifier.text.firstUppercased + type.name.text.firstUppercased
            }
        }

        if let type = detail.successType.as(TupleTypeSyntax.self) {
            name = type.concatenatedVariableName
        }
        
        if let someOrAnyType = detail.successType.as(SomeOrAnyTypeSyntax.self) {
            name = someOrAnyType.someOrAnySpecifier.text
            if let type = someOrAnyType.constraint.as(IdentifierTypeSyntax.self) {
                name += type.name.text.firstUppercased
            }
        }

        // Add the name of the parameter
        name += detail.name.firstUppercased

        return name
    }

    func completionHandlerResultVariableName(for detail: FunctionParameterSyntax.ResultCompletionHandlerDetail) -> String {
        completionHandlerVariableName(for: detail) + "Result"
    }

    // MARK: - MockGenerating implementation -

    func generateMockCode(for parameters: MockGeneratorParameters) -> String {
        publicAccessQualifier = parameters.public ? "public " : ""
        
        // Preprocessing
        propertyTracker.generatePropertyNames(for: parameters)
        calledAttributeTracker.generateCalledAttributeNames(for: parameters)
        parameterTracker.generateParameterNames(for: parameters)
        determineIfAnyMethodsThrow(for: parameters)

        // Code generation
        if parameters.includeHeader {
            generateHeader(for: parameters)
            generateSpacing()
        }
        generateImports(for: parameters)
        generateSpacing()
        startClassOrActor(for: parameters)
        if parameters.public {
            generateSpacing()
            generateEmptyPublicInitializer(for: parameters)
        }
        generateSpacing()
        generateProtocolAttributes(for: parameters)
        generateSpacing()
        generateTrackingOptionSets(for: parameters)
        generateSpacing()
        generateParameterAttributes(for: parameters)
        generateSpacing()
        generateReturnValueAttributes(for: parameters)
        generateSpacing()
        generateErrorThrowingAttributes(for: parameters)
        generateSpacing()
        generateShouldCallAttributes(for: parameters)
        generateSpacing()
        generateResetFunction(for: parameters)
        if parameters.trackPropertyActivity {
            generateSpacing()
            generatePropertyImplementations(for: parameters)
        }
        generateSpacing()
        generateProtocolFunctions(for: parameters)
        generateSpacing()
        endClassOrActor(for: parameters)
        generateOptionSetsExtensions(for: parameters)
        generateCustomReflectationExtension(for: parameters)
        return code
    }
}
