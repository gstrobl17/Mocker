//
//  PackageInitializerInformation.swift
//  Mocker
//
//  Created by Greg Strobl on 5/16/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation
import SwiftSyntax

enum PackageInitializerInformationError: Error, LocalizedError {
    case unexpectedSituation(String)
    
    var errorDescription: String? {
        switch self {
        case .unexpectedSituation(let message):
            return "Error parsing \(SwiftPackageConstant.File.manifestFileName): \(message)"
        }
    }
}

class PackageInitializerInformation {
    
    let name: String?
    let targets: [String]

    //swiftlint:disable:next cyclomatic_complexity
    init(decl: VariableDeclSyntax) throws {
        
        // Verify that the definition looks like:
        //      let package = Package(
        guard decl.bindings.count == 1 else { throw PackageInitializerInformationError.unexpectedSituation("Unexpected Binding Count(\(decl.bindings.count))") }
        guard let binding = decl.bindings.first else { throw PackageInitializerInformationError.unexpectedSituation("Unexpected Binding Count(\(decl.bindings.count))") }
        guard binding.pattern.description.trimmingCharacters(in: .whitespacesAndNewlines) == SwiftPackageConstant.Manifest.requiredVariableName else {
            throw PackageInitializerInformationError.unexpectedSituation("Unexpected variable name: (\(binding.pattern.description) (expecting \(SwiftPackageConstant.Manifest.requiredVariableName))")
        }
        guard let initializer = binding.initializer else { throw PackageInitializerInformationError.unexpectedSituation("Type not found for variable") }
        guard let functionCall = initializer.value.as(FunctionCallExprSyntax.self) else { throw PackageInitializerInformationError.unexpectedSituation("Initializer value not an instance of FunctionCallExprSyntax") }
        guard let identifier = functionCall.calledExpression.as(DeclReferenceExprSyntax.self) else { throw PackageInitializerInformationError.unexpectedSituation("Function Call calledExpression is not IdentifierExprSyntax") }
        guard identifier.baseName.text == SwiftPackageConstant.Manifest.requiredTypeOfVariableName else {
            throw PackageInitializerInformationError.unexpectedSituation("Unexpected type for variable \"\(SwiftPackageConstant.Manifest.requiredVariableName)\": (\(identifier.baseName.text) (expecting \(SwiftPackageConstant.Manifest.requiredTypeOfVariableName))")
        }
     
        // Iterate through the argument list. We are looking for "name" and "targets",
        var parsedName: String?
        var parsedNTargets = [TargetDetail]()
        functionCall.arguments.forEach { argument in
            guard let argumentName = argument.label?.text else { return }
            switch argumentName {
            case SwiftPackageConstant.Manifest.ArgumentName.name:
                parsedName = argument.stringLiteral
            case SwiftPackageConstant.Manifest.ArgumentName.targets:
                parsedNTargets = argument.arrayOfTargetInformation
            default:
                break
            }
        }

        self.name = parsedName
        self.targets = parsedNTargets.map { $0.name }
    }
}

/*(
 
 let package = Package(
     name: "FoundationAbstractions",
     platforms: [
         .iOS(.v15)
     ],
     products: [
         // Products define the executables and libraries a package produces, making them visible to other packages.
         .library(
             name: "FoundationAbstractions",
             targets: ["FoundationAbstractions"]),
         .library(
             name: "TestResources",
             targets: ["TestResources"]),
     ],
     targets: [
         // Targets are the basic building blocks of a package, defining a module or a test suite.
         // Targets can depend on other targets in this package and products from dependencies.
         .target(
             name: "FoundationAbstractions"),
         .target(
             name: "TestResources",
             dependencies: ["FoundationAbstractions"]),
         .testTarget(
             name: "FoundationAbstractionsTests",
             dependencies: ["FoundationAbstractions"]),
     ]
 )

 */
