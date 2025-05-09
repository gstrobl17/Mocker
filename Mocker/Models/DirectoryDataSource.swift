//
//  DirectoryDataSource.swift
//  Mocker
//
//  Created by Greg Strobl on 5/9/25.
//  Copyright © 2025 Goodman Productions. All rights reserved.
//

import Foundation

private let logTraversalInformation = true

struct DirectoryDataSource: SourceFileDataSource {
    
    let projectName: String?
    let projectDirectoryURL: URL?
    let organizationName: String?
    let targets: [String]
    
    init?(
        directoryURL: URL,
        fileManager: any FileManaging
    ) throws {
        // Assume the name of the directoy is the project name
        self.projectName = directoryURL.lastPathComponent
        self.projectDirectoryURL = directoryURL
        self.organizationName = nil
        
        // Assume that directories right under the top directory are targets
        var intermediateTargets: [String] = []
        if let children = try? fileManager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: [.isDirectoryKey], options: .skipsHiddenFiles) {
            children.forEach { child in
                if child.isNonXcodeFileDirectory {
                    intermediateTargets.append(child.lastPathComponent)
                }
            }
        }
        self.targets = intermediateTargets.sorted()
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
                    
                    // Ignore Xcode project and workspace bundle directories
                    if !child.isXcodeProjectFile && !child.isXcodeWorkspaceFile {
                        
                        // Determine if this child should be a target
                        var newTarget = currentTarget
                        if depth == 2,
                           parent.fileURL?.lastPathComponent == SwiftPackageConstant.File.sourcesDirectory,
                           targets.contains(child.lastPathComponent) {
                            newTarget = child.lastPathComponent
                        }
                        
                        let treeNode = TreeNode(groupName: child.lastPathComponent)
                        traverse(child, at: depth + 1, treeNode: treeNode, filteredby: filter, monitoredBy: monitor, currentTarget: newTarget, fileManager: fileManager)
                        
                        // Only add the node to the parent if the node contains any swift files
                        if treeNode.containsSwiftFiles {
                            parent.children.append(treeNode)
                        }
                    }
                    
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
