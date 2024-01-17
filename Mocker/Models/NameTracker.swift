//
//  NameTracker.swift
//  Mocker
//
//  Created by Greg on 9/6/18.
//

import Foundation
import SwiftSyntax

private struct NameDefinition {
    let name: String
    let identifier: String
    let uniqueName: String
}

class NameTracker {
    
    typealias Name = String
    
    private struct UniqueNameDefinition {
        let identifier: String
        let name: String
    }
    
    private var nameMapping: [Name: [UniqueNameDefinition]] = [:]
    private(set) var nonStaticUniqueNames: Set<String> = []
    private(set) var staticUniqueNames: Set<String> = []

    private(set) var nonStaticNameCount = 0
    private(set) var staticNameCount = 0

    private func resetState() {
        nameMapping.removeAll()
        nonStaticUniqueNames.removeAll()
        staticUniqueNames.removeAll()
    }
    
    func generateCalledAttributeNames(for parameters: MockGeneratorParameters) {
        resetState()

        parameters.variables.forEach { variable in
            if variable.hasGetter {
                if variable.isStatic {
                    staticNameCount += 1
                    staticUniqueNames.insert(variable.nameForCode)
                } else {
                    nonStaticNameCount += 1
                    nonStaticUniqueNames.insert(variable.nameForCode)
                }
                addTracking(of: variable.calledGetterVariableName, identifiedBy: variable.getterSignatureString)
            }
            if variable.hasSetter {
                if variable.isStatic {
                    staticNameCount += 1
                } else {
                    nonStaticNameCount += 1
                }
                addTracking(of: variable.calledSetterVariableName, identifiedBy: variable.setterSignatureString)
            }
        }
        
        parameters.methods.forEach { method in
            if method.isStatic {
                staticNameCount += 1
            } else {
                nonStaticNameCount += 1
            }
            addTracking(of: method.calledVariableName, identifiedBy: method.signatureString)
        }
    }

    func generateParameterNames(for parameters: MockGeneratorParameters) {
        resetState()
        
        parameters.variables.forEach { variable in
            if variable.hasSetter {
                if variable.isStatic {
                    staticNameCount += 1
                } else {
                    nonStaticNameCount += 1
                }
                addTracking(of: variable.calledSetterVariableName, identifiedBy: variable.setterSignatureString)
            }
        }

        for method in parameters.methods {
            for parameter in method.signature.input.parameterList {
                if method.isStatic {
                    staticNameCount += 1
                } else {
                    nonStaticNameCount += 1
                }
                addTracking(of: parameter.nameForParameter, identifiedBy: parameter.baseTypeNameForParameter)
            }
        }
    }
    
    internal func addTracking(of name: String, identifiedBy identifier: String) {
        
        if var listForName = nameMapping[name] {
            
            let matchingNameDefinition = listForName.first { $0.identifier == identifier }
            if matchingNameDefinition == nil {
            
                let uniqueName = name + String(listForName.count)
                let newDefinition = UniqueNameDefinition(identifier: identifier, name: uniqueName)
                listForName.append(newDefinition)
                nameMapping[name] = listForName
            }
            
        } else {
            
            let newDefinition = UniqueNameDefinition(identifier: identifier, name: name)
            nameMapping[name] = [newDefinition]
        }
        
    }
    
    func uniqueName(for name: String, identifiedBy identifier: String) -> String? {
        var uniqueName: String?
        
        if let listForName = nameMapping[name], let definition = listForName.first(where: { $0.identifier == identifier }) {
            uniqueName = definition.name
        }
        
        return uniqueName
    }
}
