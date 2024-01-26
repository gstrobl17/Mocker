//
//  ASTMockGenerator.swift
//  Mocker
//
//  Created by Greg on 2/27/18.
//

import Foundation
import SwiftSyntax

class ASTMockGenerator: MockGenerating {

    let swiftlintAware: Bool
    let dateFactory: DateCreating
    let fullNameProvider: FullNameProviding
    internal var code = ""
    internal var contentGenerated = false
    internal let indentation = "    "
    internal let propertyTracker = NameTracker()
    internal let calledAttributeTracker = NameTracker()
    internal let parameterTracker = NameTracker()
    internal var generateInstanceErrorToThrowVariable = false
    internal var generateClassErrorToThrowVariable = false

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
        swiftlintAware: Bool,
        dateFactory: DateCreating = DateFactory(),
        fullNameProvider: FullNameProviding = FullNameProvider()
    ) {
        self.swiftlintAware = swiftlintAware
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

    func completionHandlerVariableName(for detail: FunctionParameterSyntax.ResultCompletionHandlerDetail) -> String {
        // Start with the type
        var name = "UNDETERMINED"

        // Prefix the name of the variable with the type
        if let arrayType = detail.successType.as(ArrayTypeSyntax.self), let type = arrayType.elementType.as(SimpleTypeIdentifierSyntax.self) {
            let lastCharacter = type.name.text.last
            
            if lastCharacter == "s" {
                name = type.name.text.firstLowercased + "es"
            } else {
                name = type.name.text.firstLowercased + "s"
            }
        }

        if let type = detail.successType.as(SimpleTypeIdentifierSyntax.self) {
            name = type.name.text.firstLowercased
        }

        if let optional = detail.successType.as(OptionalTypeSyntax.self), let type = optional.wrappedType.as(SimpleTypeIdentifierSyntax.self) {
            name = "optional" + type.name.text.firstUppercased
        }

        if let type = detail.successType.as(TupleTypeSyntax.self) {
            name = type.concatenatedVariableName
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

        // Preprocessing
        propertyTracker.generatePropertyNames(for: parameters)
        calledAttributeTracker.generateCalledAttributeNames(for: parameters)
        parameterTracker.generateParameterNames(for: parameters)
        determineIfAnyMethodsThrow(for: parameters)

        // Code generation
        generateHeader(for: parameters)
        generateSpacing()
        generateImports(for: parameters)
        generateSpacing()
        startClass(for: parameters)
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
        endClass()
        generateOptionSetsExtensions(for: parameters)

        return code
    }

    // MARK: - swiftlint support methods -
    
    private func areMethodNamesValid(for methods: [FunctionDeclSyntax]) -> Bool {
        var valid = true
        for method in methods {
            guard let calledAttributeName = calledAttributeName(for: method) else { continue }
            if !isNameValid(calledAttributeName) {
                valid = false
                break
            }
        }
        return valid
    }

    func areNonStaticMethodNamesValid(for parameters: MockGeneratorParameters) -> Bool {
        areMethodNamesValid(for: parameters.methods.filter { !$0.isStatic })
    }

    func areStaticMethodNamesValid(for parameters: MockGeneratorParameters) -> Bool {
        areMethodNamesValid(for: parameters.methods.filter { $0.isStatic })
    }

    private func areParameterNamesValid(for methods: [FunctionDeclSyntax], isMethodStatic: Bool) -> Bool {
        var valid = true
        for method in methods {
            for parameter in method.signature.input.parameterList {
                guard let parameterName = parameterName(for: parameter, in: method) else { continue }
                if !isNameValid(parameterName) {
                    valid = false
                    break
                }
            }
        }
        return valid
    }

    func areNonStaticMethodParamterAssignedNamesValid(for parameters: MockGeneratorParameters) -> Bool {
        areParameterNamesValid(for: parameters.methods.filter { !$0.isStatic }, isMethodStatic: false)
    }

    func areStaticMethodParamterAssignedNamesValid(for parameters: MockGeneratorParameters) -> Bool {
        areParameterNamesValid(for: parameters.methods.filter { $0.isStatic }, isMethodStatic: false)
    }

    func areShouldCallAndResultVariableNamesValid(for parameters: MockGeneratorParameters) -> Bool {
        var valid = true
        for method in parameters.methods {
            for parameter in method.signature.input.parameterList where parameter.isFunction {
                let shouldCallVariableName = parameter.shouldCallVariableName
                if !isNameValid(shouldCallVariableName) {
                    valid = false
                    break
                }
                
                if case let FunctionParameterSyntax.ResultCompletionHandlerAnswer.yes(details) = parameter.isResultCompletionHandler {
                    let resultVariableName = completionHandlerResultVariableName(for: details)
                    if !isNameValid(resultVariableName) {
                        valid = false
                        break
                    }
                    
                    let methodResultVariableName = method.completionHandlerResultVariableName
                    let shouldCallVariableName = method.shouldCallCompletionHandlerVariableName
                    assert(shouldCallVariableName.count > methodResultVariableName.count)
                    if !isNameValid(shouldCallVariableName) {
                        valid = false
                        break
                    }
                }
            }
        }
        return valid
    }
                
    func isNameValid(_ name: String) -> Bool {
        !(name.count < SwiftlintSupport.IdentifierName.minLength || name.count > SwiftlintSupport.IdentifierName.maxLength)
    }
}
