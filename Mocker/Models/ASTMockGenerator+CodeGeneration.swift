//swiftlint:disable file_length
//
//  ASTMockGenerator+CodeGeneration.swift
//  Mocker
//
//  Created by Greg Strobl on 6/23/22.
//

import Foundation
import SwiftSyntax

extension ASTMockGenerator {
    
    // MARK: - Code generation methods -

    func generateSpacing(lines: Int = 1) {
        guard contentGenerated == true else { return }
        for _ in 0..<lines {
            code += "\n"
        }
        contentGenerated = false
    }

    func generateMark(with comment: String, includeTrailingCarriageReturn: Bool = true) {
        code += "\(indentation)// MARK: - \(comment)\n"
        if includeTrailingCarriageReturn {
            code += "\n"
        }
    }

    func generateComment(with comment: String, includeTrailingCarriageReturn: Bool = true) {
        comment.split(separator: "\n").forEach { line in
            code += "\(indentation)// \(line)\n"
        }
        if includeTrailingCarriageReturn {
            code += "\n"
        }
    }

    func generateHeader(for parameters: MockGeneratorParameters) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none

        contentGenerated = true

        code += "//\n"
        code += "//  \(parameters.mockName).swift\n"
        if let projectName = parameters.dataSource.projectName {
            code += "//  \(projectName)\n"
        }
        code += "//\n"
        code += "// Created by \(fullNameProvider.name) on \(formatter.string(from: dateFactory.now)).\n"
        var organizationName = ""
        if let projectOrganizationName = parameters.dataSource.organizationName {
            organizationName = " \(projectOrganizationName)"
        }

        code += "// Copyright © \(Calendar.current.component(.year, from: dateFactory.now))\(organizationName). All rights reserved.\n"
        code += "//\n"
    }

    func generateImports(for parameters: MockGeneratorParameters) {

        if parameters.includeTestableImport == true && !parameters.testableTargetName.isEmpty {
            contentGenerated = true
            code += "@testable import \(parameters.testableTargetName)\n"
        }

        for importDeclaration in parameters.imports {
            contentGenerated = true
            code += "import \(importDeclaration.path)\n"
        }
    }

    func startClassOrActor(for parameters: MockGeneratorParameters) {
        contentGenerated = true
        if parameters.protocolDeclaration.hasMainActorAnnotation {
            code += "@MainActor\n"
        }
        let keyword = parameters.isActor ? "actor" : "class"
        code += "\(publicAccessQualifier)\(keyword) \(parameters.mockName): \(parameters.protocolDeclaration.name.text) {\n"
    }

    func generateEmptyPublicInitializer(for parameters: MockGeneratorParameters) {
        contentGenerated = true
        code += "\(indentation)\(publicAccessQualifier)init() { }\n"
    }

    func generateProtocolAttributes(for parameters: MockGeneratorParameters) {

        var first = true
        for variable in parameters.variables {
            contentGenerated = true
            
            if parameters.trackPropertyActivity {
                if first {
                    first = false
                    generateMark(with: "Variables for Properties Used for Protocol Conformance", includeTrailingCarriageReturn: false)
                    if parameters.isActor {
                        generateComment(with: "Use these properties to get the properties without registering a method call")
                    } else {
                        generateComment(with: "Use these properties to get/set/initialize the properties without registering a method call")
                    }
                }
                let prefix = variable.isStatic ? "static " : ""
                code += "\(indentation)\(publicAccessQualifier)\(prefix)var \(variable.internalNameForCode)\(variable.typeForCode)\n"
            } else {
                if first {
                    first = false
                    generateMark(with: "Variables for Protocol Conformance")
                }
                let prefix = variable.isStatic ? "static " : ""
                code += "\(indentation)\(publicAccessQualifier)\(prefix)var \(variable.nameForCode)\(variable.typeForCode)\n"
            }
        }

        if parameters.isActor && parameters.trackPropertyActivity {
            first = true
            for variable in parameters.variables {
                contentGenerated = true
                
                if first {
                    first = false
                    generateSpacing()
                    generateComment(with: "Use these methods to set the properties without registering a method call")
                }
                let prefix = variable.isStatic ? "static " : ""
                code += "\(indentation)\(publicAccessQualifier)\(prefix)func set\(variable.internalNameForCode)(_ value\(variable.typeForCode)) { \(variable.internalNameForCode) = value }\n"
            }
        }
    }

    func generateTrackingOptionSets(for parameters: MockGeneratorParameters) {
        var first = true
        if calledAttributeTracker.nonStaticNameCount > 0 || calledAttributeTracker.staticNameCount > 0 {
            generateMark(with: "Variables for Trackings Method Invocation")
        }
        if calledAttributeTracker.nonStaticNameCount > 0 {
            generateNonStaticMethodCalledOptionSet(for: parameters)
            first = false
        }
        if calledAttributeTracker.staticNameCount > 0 {
            if !first {
                generateSpacing()
            }
            generateStaticMethodCalledOptionSet(for: parameters)
            first = false
        }
        if parameterTracker.nonStaticNameCount > 0 {
            if !first {
                generateSpacing()
            }
            generateNonStaticMethodParamterAssignedOptionSet(for: parameters)
            first = false
        }
        if parameterTracker.staticNameCount > 0 {
            if !first {
                generateSpacing()
            }
            generateStaticMethodParamterAssignedOptionSet(for: parameters)
            first = false
        }
    }
    
    func startOptionSetDeclaration(name: String, count: Int, with parameters: MockGeneratorParameters) {
        code += "\(indentation)\(publicAccessQualifier)struct \(name): OptionSet, Sendable {\n"
        let optionalTodo = (count > UInt.bitWidth) ? "  // TODO: Increase the size of OptionSet storage. There are more options (\(count)) than bits (\(UInt.bitWidth))." : ""
        code += "\(indentation)\(indentation)\(publicAccessQualifier)let rawValue: UInt" + optionalTodo + "\n"
        if parameters.public {
            code += "\(indentation)\(indentation)\(publicAccessQualifier)init(rawValue: UInt) { self.rawValue = rawValue }\n"
        }
    }

    func generateNonStaticMethodCalledOptionSet(for parameters: MockGeneratorParameters) {
        contentGenerated = true
        
        // Pre-generate the individual options (so that we know the count when we declare the option set)
        var options = ""
        var valueNumber = 0
        if parameters.trackPropertyActivity {
            for variable in parameters.variables where !variable.isStatic {
                if variable.hasGetter, let calledAttributeName = getterCalledAttributeName(for: variable) {
                    options += "\(indentation)\(indentation)\(publicAccessQualifier)static let \(calledAttributeName) = \(TypeName.Method)(rawValue: 1 << \(valueNumber))\n"
                    valueNumber += 1
                }
                if !parameters.isActor {
                    if variable.hasSetter, let calledAttributeName = setterCalledAttributeName(for: variable) {
                        options += "\(indentation)\(indentation)\(publicAccessQualifier)static let \(calledAttributeName) = \(TypeName.Method)(rawValue: 1 << \(valueNumber))\n"
                        valueNumber += 1
                    }
                }
            }
        }
        for method in parameters.methods where !method.isStatic {
            guard let calledAttributeName = calledAttributeName(for: method) else { continue }
            options += "\(indentation)\(indentation)\(publicAccessQualifier)static let \(calledAttributeName) = \(TypeName.Method)(rawValue: 1 << \(valueNumber))\n"
            valueNumber += 1
        }

        startOptionSetDeclaration(name: TypeName.Method, count: valueNumber, with: parameters)
        code += options
        code += "\(indentation)}\n"
        code += "\(indentation)private(set) \(publicAccessQualifier)var \(VariableName.calledMethods) = \(TypeName.Method)()\n"
    }

    func generateStaticMethodCalledOptionSet(for parameters: MockGeneratorParameters) {
        contentGenerated = true
        
        // Pre-generate the individual options (so that we know the count when we declare the option set)
        var options = ""
        var valueNumber = 0
        if parameters.trackPropertyActivity {
            for variable in parameters.variables where variable.isStatic {
                if variable.hasGetter, let calledAttributeName = getterCalledAttributeName(for: variable) {
                    options += "\(indentation)\(indentation)\(publicAccessQualifier)static let \(calledAttributeName) = \(TypeName.Method)(rawValue: 1 << \(valueNumber))\n"
                    valueNumber += 1
                }
                if variable.hasSetter, let calledAttributeName = setterCalledAttributeName(for: variable) {
                    options += "\(indentation)\(indentation)\(publicAccessQualifier)static let \(calledAttributeName) = \(TypeName.Method)(rawValue: 1 << \(valueNumber))\n"
                    valueNumber += 1
                }
            }
        }
        for method in parameters.methods where method.isStatic {
            guard let calledAttributeName = calledAttributeName(for: method) else { continue }
            options += "\(indentation)\(indentation)\(publicAccessQualifier)static let \(calledAttributeName) = \(TypeName.StaticMethod)(rawValue: 1 << \(valueNumber))\n"
            valueNumber += 1
        }

        startOptionSetDeclaration(name: TypeName.StaticMethod, count: valueNumber, with: parameters)
        code += options
        code += "\(indentation)}\n"
        code += "\(indentation)private(set) \(publicAccessQualifier)static var \(VariableName.calledStaticMethods) = \(TypeName.StaticMethod)()\n"
    }

    func generateNonStaticMethodParamterAssignedOptionSet(for parameters: MockGeneratorParameters) {
        var usedNames: Set<String> = []
        contentGenerated = true
        
        // Pre-generate the individual options (so that we know the count when we declare the option set)
        var options = ""
        var valueNumber = 0
        if parameters.trackPropertyActivity && !parameters.isActor {
            for variable in parameters.variables where variable.hasSetter && !variable.isStatic && !usedNames.contains(variable.setterCaptureValueVariableName) {
                options += "\(indentation)\(indentation)\(publicAccessQualifier)static let \(variable.setterCaptureValueVariableName) = \(TypeName.MethodParameter)(rawValue: 1 << \(valueNumber))\n"
                valueNumber += 1
                usedNames.insert(variable.setterCaptureValueVariableName)
            }
        }
        for method in parameters.methods where !method.isStatic {
            for parameter in method.signature.parameterClause.parameters {
                guard let parameterName = parameterName(for: parameter, in: method) else { continue }
                if !usedNames.contains(parameterName) {
                    options += "\(indentation)\(indentation)\(publicAccessQualifier)static let \(parameterName) = \(TypeName.MethodParameter)(rawValue: 1 << \(valueNumber))\n"
                    valueNumber += 1
                    usedNames.insert(parameterName)
                }
            }
        }

        startOptionSetDeclaration(name: TypeName.MethodParameter, count: valueNumber, with: parameters)
        code += options
        code += "\(indentation)}\n"
        code += "\(indentation)private(set) \(publicAccessQualifier)var \(VariableName.assignedParameters) = \(TypeName.MethodParameter)()\n"
    }

    func generateStaticMethodParamterAssignedOptionSet(for parameters: MockGeneratorParameters) {
        var usedNames: Set<String> = []
        contentGenerated = true
        
        // Pre-generate the individual options (so that we know the count when we declare the option set)
        var options = ""
        var valueNumber = 0
        if parameters.trackPropertyActivity {
            for variable in parameters.variables where variable.hasSetter && variable.isStatic && !usedNames.contains(variable.setterCaptureValueVariableName) {
                options += "\(indentation)\(indentation)\(publicAccessQualifier)static let \(variable.setterCaptureValueVariableName) = \(TypeName.StaticMethodParameter)(rawValue: 1 << \(valueNumber))\n"
                valueNumber += 1
                usedNames.insert(variable.setterCaptureValueVariableName)
            }
        }
        for method in parameters.methods where method.isStatic {
            for parameter in method.signature.parameterClause.parameters {
                guard let parameterName = parameterName(for: parameter, in: method) else { continue }
                if !usedNames.contains(parameterName) {
                    options += "\(indentation)\(indentation)\(publicAccessQualifier)static let \(parameterName) = \(TypeName.StaticMethodParameter)(rawValue: 1 << \(valueNumber))\n"
                    valueNumber += 1
                    usedNames.insert(parameterName)
                }
            }
        }

        startOptionSetDeclaration(name: TypeName.StaticMethodParameter, count: valueNumber, with: parameters)
        code += options
        code += "\(indentation)}\n"
        code += "\(indentation)private(set) \(publicAccessQualifier)static var \(VariableName.assignedStaticParameters) = \(TypeName.StaticMethodParameter)()\n"
    }

    func generateParameterAttributes(for parameters: MockGeneratorParameters) {
        var first = true
        func generateHeader() {
            if first {
                generateMark(with: "Variables for Captured Parameter Values")
                first = false
            }
        }
        
        var usedNames: Set<String> = []
        
        if parameters.trackPropertyActivity && !parameters.isActor {
            for variable in parameters.variables where variable.hasSetter && !usedNames.contains(variable.setterCaptureValueVariableName) {
                contentGenerated = true
                generateHeader()
                let modifier = variable.isStatic ? "static " : ""
                let optionalModifier = variable.isOptional ? "" : "?"
                let typeWrapperStart = variable.isSomeOrAnyType ? "(" : ""
                let typeWrapperEnd = variable.isSomeOrAnyType ? ")" : ""
                code += "\(indentation)private(set) \(publicAccessQualifier)\(modifier)var \(variable.setterCaptureValueVariableName): \(typeWrapperStart)\(variable.processedTypeNameForCode)\(typeWrapperEnd)\(optionalModifier)\n"
                
                usedNames.insert(variable.setterCaptureValueVariableName)
            }
        }

        for method in parameters.methods {
            for parameter in method.signature.parameterClause.parameters {
                guard let parameterName = parameterName(for: parameter, in: method) else { continue }
                
                if !usedNames.contains(parameterName) {
                    contentGenerated = true
                    generateHeader()
                    let modifier = method.isStatic ? "static " : ""
                    let optionalModifier = parameter.isOptional ? "" : "?"
                    var typeWrapperStart = ""
                    var typeWrapperEnd = ""
                    if parameter.type.is(SomeOrAnyTypeSyntax.self) || parameter.isFunction {
                        typeWrapperStart = "("
                        typeWrapperEnd = ")"
                    }
                    code += "\(indentation)private(set) \(publicAccessQualifier)\(modifier)var \(parameterName): \(typeWrapperStart)\(parameter.nonEscapingTypeNameForParameter)\(typeWrapperEnd)\(optionalModifier)\n"
                    
                    usedNames.insert(parameterName)
                }
            }
        }
    }

    func generateReturnValueAttributes(for parameters: MockGeneratorParameters) {
        var first = true
        
        for method in parameters.methods {
            guard let returnType = method.signature.returnClause?.type else { continue }
            
            contentGenerated = true
            if first {
                generateMark(with: "Variables to Use as Method Return Values")
                first = false
            }
            let modifier = method.isStatic ? "static " : ""
            let implicitlyUnwrappedOptionalModifier = returnType.isOptional ? "" : "!"
            let typeWrapperStart = returnType.is(SomeOrAnyTypeSyntax.self) ? "(" : ""
            let typeWrapperEnd = returnType.is(SomeOrAnyTypeSyntax.self) ? ")" : ""
            code += "\(indentation)\(publicAccessQualifier)\(modifier)var \(method.returnValueVariableName): \(typeWrapperStart)\(returnType.processedTypeName(removeExclamationMark: true, removeEscaping: true))\(typeWrapperEnd)\(implicitlyUnwrappedOptionalModifier)\n"
        }
        
        // Add setters for the return value attributes if the protocol is an Actor
        if parameters.isActor && !parameters.methods.isEmpty {
            generateSpacing()

            for method in parameters.methods {
                guard let returnType = method.signature.returnClause?.type else { continue }
                
                let modifier = method.isStatic ? "static " : ""
                code += "\(indentation)\(publicAccessQualifier)\(modifier)func set\(method.returnValueVariableName.firstUppercased)(_ value: \(returnType.processedTypeName(removeExclamationMark: true, removeEscaping: true))) { \(method.returnValueVariableName) = value }\n"
            }
        }
    }

    func generateErrorThrowingAttributes(for parameters: MockGeneratorParameters) {
        guard generateClassErrorToThrowVariable || generateInstanceErrorToThrowVariable else { return }
        contentGenerated = true

        if generateClassErrorToThrowVariable {
            code += "\(indentation)\(publicAccessQualifier)static var \(VariableName.staticErrorToThrow): (any Error)!\n"
        }
        if generateInstanceErrorToThrowVariable {
            code += "\(indentation)\(publicAccessQualifier)var \(VariableName.instanceErrorToThrow): (any Error)!\n"
        }

        for method in parameters.methods where method.signature.throwsOrRethrows {
            let modifier = method.isStatic ? "static " : ""
            code += "\(indentation)\(publicAccessQualifier)\(modifier)var \(method.shouldThrowErrorVariableName) = false\n"
        }
    }

    func generateShouldCallAttributes(for parameters: MockGeneratorParameters) { //swiftlint:disable:this cyclomatic_complexity
        var firstShouldCallVariable = true
        var usedNames: Set<String> = []

        contentGenerated = true

        // "General" completion handler result variables
        for method in parameters.methods {
            for parameter in method.signature.parameterClause.parameters where parameter.isFunction {
                contentGenerated = true
                let shouldCallVariableName = parameter.shouldCallVariableName

                if !usedNames.contains(shouldCallVariableName) {
                    generateMark(with: "Variables to Use to Control Completion Handlers")
                    code += "\(indentation)\(publicAccessQualifier)var \(shouldCallVariableName) = false\n"
                    usedNames.insert(shouldCallVariableName)
                }

                if case let FunctionParameterSyntax.ResultCompletionHandlerAnswer.yes(details) = parameter.isResultCompletionHandler {
                    let resultVariableName = completionHandlerResultVariableName(for: details)

                    if !usedNames.contains(resultVariableName) {
                        code += "\(indentation)\(publicAccessQualifier)var \(resultVariableName) = .failure(MockError)\n"
                        usedNames.insert(resultVariableName)
                    }
                }
            }
        }
        
        // Specific completion handler result variables
        for method in parameters.methods {
            for parameter in method.signature.parameterClause.parameters where parameter.isFunction {
                if case let FunctionParameterSyntax.ResultCompletionHandlerAnswer.yes(detail) = parameter.isResultCompletionHandler {
                    
                    contentGenerated = true
                    let shouldCallVariableName = method.shouldCallCompletionHandlerVariableName

                    if !usedNames.contains(shouldCallVariableName) {
                        if firstShouldCallVariable {
                            firstShouldCallVariable = false
                            code += "\n"
                        }
                        
                        code += "\(indentation)\(publicAccessQualifier)var \(shouldCallVariableName) = false\n"
                        usedNames.insert(shouldCallVariableName)
                    }

                    let resultVariableName = method.completionHandlerResultVariableName

                    if !usedNames.contains(resultVariableName) {
                        code += "\(indentation)\(publicAccessQualifier)var \(resultVariableName): \(parameter.typeNameForDetail(detail)) = .failure(MockError)\n"
                        usedNames.insert(resultVariableName)
                    }
                }
            }
        }
    }

    func generateResetFunction(for parameters: MockGeneratorParameters) {
        var usedNames: Set<String> = []
        contentGenerated = true
        code += "\(indentation)\(publicAccessQualifier)func reset() {\n"

        // Called attributes
        if calledAttributeTracker.nonStaticNameCount > 0 {
            code += "\(indentation)\(indentation)\(VariableName.calledMethods) = []\n"
        }
        if calledAttributeTracker.staticNameCount > 0 {
            code += "\(indentation)\(indentation)\(parameters.mockName).\(VariableName.calledStaticMethods) = []\n"
        }
        if parameterTracker.nonStaticNameCount > 0 {
            code += "\(indentation)\(indentation)\(VariableName.assignedParameters) = []\n"
        }
        if parameterTracker.staticNameCount > 0 {
            code += "\(indentation)\(indentation)\(parameters.mockName).\(VariableName.assignedStaticParameters) = []\n"
        }

        if parameters.trackPropertyActivity && !parameters.isActor {
            for variable in parameters.variables where variable.hasSetter && !usedNames.contains(variable.setterCaptureValueVariableName) {
                let modifier = variable.isStatic ? "\(parameters.mockName)." : ""
                code += "\(indentation)\(indentation)\(modifier)\(variable.setterCaptureValueVariableName) = nil\n"
                usedNames.insert(variable.setterCaptureValueVariableName)
            }
        }

        for method in parameters.methods {
            for parameter in method.signature.parameterClause.parameters {
                guard let parameterName = parameterName(for: parameter, in: method) else { continue }

                if !usedNames.contains(parameterName) {
                    let modifier = method.isStatic ? "\(parameters.mockName)." : ""
                    code += "\(indentation)\(indentation)\(modifier)\(parameterName) = nil\n"
                    usedNames.insert(parameterName)
                }
            }
        }

        code += "\(indentation)}\n"
    }

    func generatePropertyImplementations(for parameters: MockGeneratorParameters) {
        assert(parameters.trackPropertyActivity)
        var first = true

        func generateGetter(with indentation: String, for variable: VariableDeclSyntax) {
            guard let calledAttributeName = getterCalledAttributeName(for: variable) else { return }
            let optionSetVariableName = (variable.isStatic) ? VariableName.calledStaticMethods : VariableName.calledMethods
            code += "\(indentation)\(optionSetVariableName).insert(.\(calledAttributeName))\n"
            code += "\(indentation)return \(variable.internalNameForCode)\n"
        }
        
        for variable in parameters.variables {
            if contentGenerated {
                generateSpacing()
            }
            contentGenerated = true
            if first {
                generateMark(with: "Properties for Protocol Conformance")
                first = false
            }

            let prefix = variable.isStatic ? "static " : ""
            code += "\(indentation)\(publicAccessQualifier)\(prefix)var \(variable.nameForCode)\(variable.typeForCode) {\n"
            if variable.hasGetter && (!variable.hasSetter || parameters.isActor) {
                generateGetter(with: "\(indentation)\(indentation)", for: variable)
                
            } else {
                if variable.hasGetter {
                    code += "\(indentation)\(indentation)get {\n"
                    generateGetter(with: "\(indentation)\(indentation)\(indentation)", for: variable)
                    code += "\(indentation)\(indentation)}\n"
                }
                if variable.hasSetter {
                    code += "\(indentation)\(indentation)set {\n"
                    
                    guard let calledAttributeName = setterCalledAttributeName(for: variable) else { continue }
                    let optionSetVariableName = (variable.isStatic) ? VariableName.calledStaticMethods : VariableName.calledMethods
                    code += "\(indentation)\(indentation)\(indentation)\(optionSetVariableName).insert(.\(calledAttributeName))\n"

                    code += "\(indentation)\(indentation)\(indentation)\(variable.internalNameForCode) = newValue\n"
                    
                    code += "\(indentation)\(indentation)\(indentation)self.\(variable.setterCaptureValueVariableName) = newValue\n"
                    let capturedValueOptionSetVariableName = (variable.isStatic) ? VariableName.assignedStaticParameters : VariableName.assignedParameters
                    code += "\(indentation)\(indentation)\(indentation)\(capturedValueOptionSetVariableName).insert(.\(variable.setterCaptureValueVariableName))\n"

                    code += "\(indentation)\(indentation)}\n"
                }
            }
            code += "\(indentation)}\n"
        }
    }

    func generateProtocolFunctions(for parameters: MockGeneratorParameters) {
        var first = true

        for method in parameters.methods {
            if contentGenerated {
                generateSpacing()
            }
            contentGenerated = true
            if first {
                generateMark(with: "Methods for Protocol Conformance")
                first = false
            }

            // Method declaration
            code += "\(indentation)\(publicAccessQualifier)\(method.signatureString) {\n"

            // Method called recording
            guard let calledAttributeName = calledAttributeName(for: method) else { continue }
            let optionSetVariableName = (method.isStatic) ? VariableName.calledStaticMethods : VariableName.calledMethods
            code += "\(indentation)\(indentation)\(optionSetVariableName).insert(.\(calledAttributeName))\n"

            // Parameter value capture
            for parameter in method.signature.parameterClause.parameters {
                let parameterName = self.parameterName(for: parameter, in: method) ?? parameter.nameForParameter
                code += "\(indentation)\(indentation)self.\(parameterName) = \(parameter.nameForParameter)\n"
                let optionSetVariableName = (method.isStatic) ? VariableName.assignedStaticParameters : VariableName.assignedParameters
                code += "\(indentation)\(indentation)\(optionSetVariableName).insert(.\(parameterName))\n"
            }

            // Error throwing handling. Put before block invocation handling. Error throwing takes precedence.
            if method.signature.throwsOrRethrows {
                let errorVariableName = method.isStatic ? VariableName.staticErrorToThrow : VariableName.instanceErrorToThrow
                code += "\(indentation)\(indentation)if \(method.shouldThrowErrorVariableName) && \(errorVariableName) != nil {\n"
                code += "\(indentation)\(indentation)\(indentation)throw \(errorVariableName)\n"
                code += "\(indentation)\(indentation)}\n"
            }

            // Block invocation handling
            for parameter in method.signature.parameterClause.parameters where parameter.isFunction {
                code += "\(indentation)\(indentation)if \(parameter.shouldCallVariableName) {\n"
                code += "\(indentation)\(indentation)\(indentation)\(parameter.nameForParameter)("
                if case let FunctionParameterSyntax.ResultCompletionHandlerAnswer.yes(details) = parameter.isResultCompletionHandler {
                    let resultVariableName = completionHandlerResultVariableName(for: details)
                    code += resultVariableName
                }
                code += ")\n"
                code += "\(indentation)\(indentation)}\n"

                // Specific invocation handling
                if case FunctionParameterSyntax.ResultCompletionHandlerAnswer.yes(_) = parameter.isResultCompletionHandler {

                    code += "\(indentation)\(indentation)if \(method.shouldCallCompletionHandlerVariableName) {\n"
                    code += "\(indentation)\(indentation)\(indentation)\(parameter.nameForParameter)("
                    code += method.completionHandlerResultVariableName
                    code += ")\n"
                    code += "\(indentation)\(indentation)}\n"
                }
            }

            // Return value handling
            if method.signature.returnClause?.type != nil {
                code += "\(indentation)\(indentation)return \(method.returnValueVariableName)\n"
            }
            code += "\(indentation)}\n"
        }

    }

    func endClassOrActor(for parameters: MockGeneratorParameters) {
        contentGenerated = true
        
        if parameters.isActor {
            generateComment(with: "Parameter used by MacrosForStroblMocks to detect an actor", includeTrailingCarriageReturn: false)
            code += "\(indentation)\(publicAccessQualifier)let isMockActor = true\n"
        }
        
        code += "}\n"
    }

    func generateBeginningOfOptionSetExtension(with name: String) {
        code += "extension \(name): CustomStringConvertible {\n"
        code += "\(indentation)\(publicAccessQualifier)var description: String {\n"
        code += "\(indentation)\(indentation)var value = \"[\"\n"
        code += "\(indentation)\(indentation)var first = true\n"
        code += "\(indentation)\(indentation)func handleFirst() {\n"
        code += "\(indentation)\(indentation)\(indentation)if first {\n"
        code += "\(indentation)\(indentation)\(indentation)\(indentation)first = false\n"
        code += "\(indentation)\(indentation)\(indentation)} else {\n"
        code += "\(indentation)\(indentation)\(indentation)\(indentation)value += \", \"\n"
        code += "\(indentation)\(indentation)\(indentation)}\n"
        code += "\(indentation)\(indentation)}\n"
        code += "\n"
    }

    func generateEndingOfOptionSetExtension() {
        code += "\n"
        code += "\(indentation)\(indentation)value += \"]\"\n"
        code += "\(indentation)\(indentation)return value\n"
        code += "\(indentation)}\n"
        code += "}\n"
    }

    func generateOptionSetsExtensions(for parameters: MockGeneratorParameters) {
        if calledAttributeTracker.nonStaticNameCount > 0 {
            generateSpacing()
            generateNonStaticMethodCalledOptionSetExtension(for: parameters)
        }
        if calledAttributeTracker.staticNameCount > 0 {
            generateSpacing()
            generateStaticMethodCalledOptionSetExtension(for: parameters)
        }
        if parameterTracker.nonStaticNameCount > 0 {
            generateSpacing()
            generateNonStaticMethodParamterAssignedOptionSetExtension(for: parameters)
        }
        if parameterTracker.staticNameCount > 0 {
            generateSpacing()
            generateStaticMethodParamterAssignedOptionSetExtension(for: parameters)
        }
    }

    func generateOptionSetContainsBlock(for name: String) {
        code += "\(indentation)\(indentation)if self.contains(.\(name)) {\n"
        code += "\(indentation)\(indentation)\(indentation)handleFirst()\n"
        code += "\(indentation)\(indentation)\(indentation)value += \".\(name)\"\n"
        code += "\(indentation)\(indentation)}\n"
    }
    
    func generateNonStaticMethodCalledOptionSetExtension(for parameters: MockGeneratorParameters) {
        contentGenerated = true
        generateBeginningOfOptionSetExtension(with: "\(parameters.mockName).\(TypeName.Method)")
        if parameters.trackPropertyActivity {
            for variable in parameters.variables where !variable.isStatic {
                if variable.hasGetter, let calledAttributeName = getterCalledAttributeName(for: variable) {
                    generateOptionSetContainsBlock(for: calledAttributeName)
                }
                if !parameters.isActor {
                    if variable.hasSetter, let calledAttributeName = setterCalledAttributeName(for: variable) {
                        generateOptionSetContainsBlock(for: calledAttributeName)
                    }
                }
            }
        }
        for method in parameters.methods where !method.isStatic {
            guard let calledAttributeName = calledAttributeName(for: method) else { continue }
            generateOptionSetContainsBlock(for: calledAttributeName)
        }
        generateEndingOfOptionSetExtension()
    }

    func generateStaticMethodCalledOptionSetExtension(for parameters: MockGeneratorParameters) {
        contentGenerated = true
        generateBeginningOfOptionSetExtension(with: "\(parameters.mockName).\(TypeName.StaticMethod)")
        if parameters.trackPropertyActivity {
            for variable in parameters.variables where variable.isStatic {
                if variable.hasGetter, let calledAttributeName = getterCalledAttributeName(for: variable) {
                    generateOptionSetContainsBlock(for: calledAttributeName)
                }
                if variable.hasSetter, let calledAttributeName = setterCalledAttributeName(for: variable) {
                    generateOptionSetContainsBlock(for: calledAttributeName)
                }
            }
        }
        for method in parameters.methods where method.isStatic {
            guard let calledAttributeName = calledAttributeName(for: method) else { continue }
            generateOptionSetContainsBlock(for: calledAttributeName)
        }
        generateEndingOfOptionSetExtension()
    }

    func generateNonStaticMethodParamterAssignedOptionSetExtension(for parameters: MockGeneratorParameters) {
        var usedNames: Set<String> = []
        contentGenerated = true
        generateBeginningOfOptionSetExtension(with: "\(parameters.mockName).\(TypeName.MethodParameter)")
        if parameters.trackPropertyActivity && !parameters.isActor {
            for variable in parameters.variables where variable.hasSetter && !variable.isStatic && !usedNames.contains(variable.setterCaptureValueVariableName) {
                generateOptionSetContainsBlock(for: variable.setterCaptureValueVariableName)
                usedNames.insert(variable.setterCaptureValueVariableName)
            }
        }
        for method in parameters.methods where !method.isStatic {
            for parameter in method.signature.parameterClause.parameters {
                guard let parameterName = parameterName(for: parameter, in: method) else { continue }
                if !usedNames.contains(parameterName) {
                    generateOptionSetContainsBlock(for: parameterName)
                    usedNames.insert(parameterName)
                }
            }
        }
        generateEndingOfOptionSetExtension()
    }

    func generateStaticMethodParamterAssignedOptionSetExtension(for parameters: MockGeneratorParameters) {
        var usedNames: Set<String> = []
        contentGenerated = true
        generateBeginningOfOptionSetExtension(with: "\(parameters.mockName).\(TypeName.StaticMethodParameter)")
        if parameters.trackPropertyActivity {
            for variable in parameters.variables where variable.hasSetter && variable.isStatic && !usedNames.contains(variable.setterCaptureValueVariableName) {
                generateOptionSetContainsBlock(for: variable.setterCaptureValueVariableName)
                usedNames.insert(variable.setterCaptureValueVariableName)
            }
        }
        for method in parameters.methods where method.isStatic {
            for parameter in method.signature.parameterClause.parameters {
                guard let parameterName = parameterName(for: parameter, in: method) else { continue }
                if !usedNames.contains(parameterName) {
                    generateOptionSetContainsBlock(for: parameterName)
                    usedNames.insert(parameterName)
                }
            }
        }
        generateEndingOfOptionSetExtension()
    }
    
    func generateCustomReflectationExtension(for parameters: MockGeneratorParameters) {
        guard !parameters.isActor else { return }
        guard calledAttributeTracker.nonStaticNameCount > 0 || calledAttributeTracker.staticNameCount > 0 || parameterTracker.nonStaticNameCount > 0 || parameterTracker.staticNameCount > 0 else { return }
        
        let possiblePreconcurrencyAnnotation = parameters.protocolDeclaration.hasMainActorAnnotation ? "@preconcurrency " : ""
        
        code += "\n"
        code += "extension \(parameters.mockName): \(possiblePreconcurrencyAnnotation)CustomReflectable {\n"
        code += "\(indentation)\(publicAccessQualifier)var customMirror: Mirror {\n"
        code += "\(indentation)\(indentation)Mirror(self,\n"
        code += "\(indentation)\(indentation)       children: [\n"
        
        if calledAttributeTracker.nonStaticNameCount > 0 {
            var possibleTrailingComma = ""
            if calledAttributeTracker.staticNameCount > 0 || parameterTracker.nonStaticNameCount > 0 || parameterTracker.staticNameCount > 0 {
                possibleTrailingComma = ","
            }
            code += "\(indentation)\(indentation)        \"calledMethods\": calledMethods\(possibleTrailingComma)\n"
        }
        
        if calledAttributeTracker.staticNameCount > 0 {
            var possibleTrailingComma = ""
            if parameterTracker.nonStaticNameCount > 0 || parameterTracker.staticNameCount > 0 {
                possibleTrailingComma = ","
            }
            code += "\(indentation)\(indentation)        \"calledStaticMethods\": \(parameters.mockName).calledStaticMethods\(possibleTrailingComma)\n"
        }
        
        if parameterTracker.nonStaticNameCount > 0 {
            var possibleTrailingComma = ""
            if parameterTracker.staticNameCount > 0 {
                possibleTrailingComma = ","
            }
            code += "\(indentation)\(indentation)        \"assignedParameters\": assignedParameters\(possibleTrailingComma)\n"
        }
        
        if parameterTracker.staticNameCount > 0 {
            let possibleTrailingComma = ""
            code += "\(indentation)\(indentation)        \"assignedStaticParameters\": \(parameters.mockName).assignedStaticParameters\(possibleTrailingComma)\n"
        }
        code += "\(indentation)\(indentation)       ],\n"
        code += "\(indentation)\(indentation)       displayStyle: .none\n"
        code += "\(indentation)\(indentation))\n"
        code += "\(indentation)}\n"
        code += "}\n"
    }

}
