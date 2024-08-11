//
//  SwiftPackageDataSource.swift
//  Mocker
//
//  Created by Greg Strobl on 5/15/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation
import SwiftSyntax
import SwiftParser

private let logTraversalInformation = false

enum SwiftPackageDataSourceError: Error, LocalizedError {
    case missingImportOfPackageDescription
    case missingVariableNamedPackage
    case packageVariableNotOfTypePackage
    
    var errorDescription: String? {
        switch self {
        case .missingImportOfPackageDescription:
            return "Did not find \"import \(SwiftPackageConstant.Manifest.requiredImportedModuleName)\" in \(SwiftPackageConstant.File.manifestFileName)"
        case .missingVariableNamedPackage:
            return "Did not find the variable \"\(SwiftPackageConstant.Manifest.requiredVariableName)\" in \(SwiftPackageConstant.File.manifestFileName)"
        case .packageVariableNotOfTypePackage:
            return "Did not variable \"\(SwiftPackageConstant.Manifest.requiredVariableName)\" was not of type \"\(SwiftPackageConstant.Manifest.requiredTypeOfVariableName)\" in \(SwiftPackageConstant.File.manifestFileName)"
        }
    }
}

struct SwiftPackageDataSource: SourceFileDataSource {

    let projectName: String?
    let projectDirectoryURL: URL?
    let organizationName: String?
    let targets: [String]

    init?(
        fileURL: URL
    ) throws {
        let packageInitializerInformation: PackageInitializerInformation

        // Parse the manifest file
        let sourceCode = try String(contentsOf: fileURL)
        let sourceFileSyntax = Parser.parse(source: sourceCode)
        let manifestInformation = SwiftPackageManifestInformation(viewMode: .sourceAccurate)
        manifestInformation.walk(sourceFileSyntax)
        
        // The manifest must have an import of "PackageDescription" and a variable
        //  named "package" of type "Package"
        var importFound = false
        manifestInformation.imports.forEach { importDecl in
            let importedModule = "\(importDecl.path)"
            if importedModule == SwiftPackageConstant.Manifest.requiredImportedModuleName {
                importFound = true
            }
        }
        guard importFound else { throw SwiftPackageDataSourceError.missingImportOfPackageDescription}
        
        var packageVariableFound = false
        var variableOfCorrectType = false
        var packageVariableDecl: VariableDeclSyntax?
        manifestInformation.variables.forEach { variableDecl in
            if variableDecl.nameForCode.trimmingCharacters(in: .whitespacesAndNewlines) == SwiftPackageConstant.Manifest.requiredVariableName {
                packageVariableFound = true
                if variableDecl.typeFromInitializerClause == SwiftPackageConstant.Manifest.requiredTypeOfVariableName {
                    variableOfCorrectType = true
                    packageVariableDecl = variableDecl
                }
            }
        }
        guard packageVariableFound else { throw SwiftPackageDataSourceError.missingVariableNamedPackage}
        guard variableOfCorrectType, let packageVariableDecl else { throw SwiftPackageDataSourceError.packageVariableNotOfTypePackage}

        // Parse the package declaration to get the relevant information for the data source
        packageInitializerInformation = try PackageInitializerInformation(decl: packageVariableDecl)

        self.projectName = packageInitializerInformation.name
        self.projectDirectoryURL = fileURL.deletingLastPathComponent()
        self.organizationName = nil //I haven't found a source for this in SwiftPackages
        self.targets = packageInitializerInformation.targets
    }
    
    func traverse(
        filteredBy filter: String,
        monitoredBy monitor: any CancelMonitoring,
        fileManager: any FileManaging
    ) -> SendableTreeNode {
        let node = TreeNode(groupName: "root")
        if let projectDirectoryURL {
            traverse(projectDirectoryURL, at: 1, treeNode: node, filteredby: filter, monitoredBy: monitor, currentTarget: nil, fileManager: fileManager)
        }
        return node.sendable
    }
 
    private func generateIndentation(for depth: Int) -> String {
        var indentation = ""
        for _ in 0...depth {
            indentation += "  "
        }
        return indentation
    }

    //swiftlint:disable:next function_parameter_count
    private func traverse(
        _ item: URL,
        at depth: Int,
        treeNode parent: TreeNode,
        filteredby filter: String,
        monitoredBy monitor: any CancelMonitoring,
        currentTarget: String?,
        fileManager: any FileManaging
    ) {
        guard !monitor.isCancelled else { return }

        let indentation = generateIndentation(for: depth)
        
        if logTraversalInformation {
            print("\(indentation)\(item.lastPathComponent)")
        }

        if let children = try? fileManager.contentsOfDirectory(at: item, includingPropertiesForKeys: [.isDirectoryKey], options: .skipsHiddenFiles) {
            let sortedChildren = children.sorted { $0.lastPathComponent < $1.lastPathComponent }
            sortedChildren.forEach { child in
        
                if child.isDirectory {
                    
                    // Determine if this child should be a target
                    var newTarget = currentTarget
                    if depth == 2,
                        parent.fileURL?.lastPathComponent == SwiftPackageConstant.File.sourcesDirectory,
                       targets.contains(child.lastPathComponent) {
                        newTarget = child.lastPathComponent
                    }
                    
                    let treeNode = TreeNode(groupName: child.lastPathComponent)
                    parent.children.append(treeNode)
                    traverse(child, at: depth + 1, treeNode: treeNode, filteredby: filter, monitoredBy: monitor, currentTarget: newTarget, fileManager: fileManager)
                    
                } else {
                    
                    if logTraversalInformation {
                        print("\(indentation)\(child.lastPathComponent)")
                    }
                    
                    if child.pathExtension == SwiftPackageConstant.File.swiftFileExtension {
                        let passesFilter = filter.isEmpty || child.lastPathComponent.lowercased().contains(filter.lowercased())
                        if passesFilter {
                            let treeNode = TreeNode(
                                fileURL: child,
                                target: currentTarget
                            )
                            parent.children.append(treeNode)
                        }
                    }

                }
            }
        }
    }
}
