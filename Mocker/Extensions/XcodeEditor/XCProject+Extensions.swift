//
//  XCProject+Extensions.swift
//  Mocker
//
//  Created by Greg on 2/21/18.
//

import Foundation
import XcodeEditor

private let logTraversalInformation = false

extension XCProject: Project { }

extension XCProject {
    
    func traverse(filteredBy filter: String, monitoredBy monitor: CancelMonitoring) -> (fileTree: TreeNode, groupTree: TreeNode) {
        
        let rootTreeNode = TreeNode(groupName: "Root")
        traverse(self.rootGroup(), at: 0, treeNode: rootTreeNode, filteredby: filter.lowercased(), monitoredBy: monitor)
        
        if monitor.isCancelled {
            // Return what we have now. (It will probably be disacarded anyway.)
            return (fileTree: rootTreeNode, groupTree: rootTreeNode)
        } else {
            
            // Process the tree into a tree with the files and tree with only the groups
            let rootFileTreeNode = filterIntoFileTree(rootTreeNode)
            let rootGroupTreeNode = filterIntoGroupTree(rootTreeNode)

            return (fileTree: rootFileTreeNode, groupTree: rootGroupTreeNode)
        }
    }
    
    private func generateIndentation(for depth: Int) -> String {
        var indentation = ""
        for _ in 0...depth {
            indentation += "  "
        }
        return indentation
    }
    
    //swiftlint:disable:next cyclomatic_complexity
    private func traverse(_ group: XCGroup, at depth: Int, treeNode parent: TreeNode, filteredby filter: String, monitoredBy monitor: CancelMonitoring) {
        guard !monitor.isCancelled else { return }

        if logTraversalInformation {
            let indentation = generateIndentation(for: depth)
            let key = group.key ?? "Key??"
            let name = group.displayName() ?? "Name?"
            let path = group.pathRelativeToProjectRoot() ?? "Path?"
            let type = NSString.xce_string(from: group.groupMemberType()) ?? "Type?"
            print("\(indentation) \(type) \(key) \(name) \(path)")
        }
        
        for key in group.children {
            guard !monitor.isCancelled else { break }
            guard let childKey = key as? String else {
                print("Unexpected type for key")
                continue
            }
            if let child = self.groupMember(withKey: childKey) {
                
                let indentation = generateIndentation(for: depth + 1)
                
                if let child = child as? XCGroup {
                    let treeNode = TreeNode(groupName: child.displayName() ?? "")
                    parent.children.append(treeNode)
                    traverse(child, at: depth + 1, treeNode: treeNode, filteredby: filter, monitoredBy: monitor)
                } else {
                    let key = child.key() ?? "Key??"
                    let name = child.displayName() ?? "Name?"
                    if logTraversalInformation {
                        let path = child.pathRelativeToProjectRoot() ?? "Path?"
                        let type = NSString.xce_string(from: child.groupMemberType()) ?? "Type?"
                        print("\(indentation) \(type) \(key) \(name) \(path)")
                    }
                    
                    if child.groupMemberType() == PBXFileReferenceType, let sourceFile = self.file(withKey: key) {
                        if sourceFile.type == XcodeSourceFileType.SourceCodeSwift {
                            let passesFilter = filter.isEmpty || name.lowercased().contains(filter)
                            if passesFilter {
                                if let fileURL = child.url(in: self) {
                                    let treeNode = TreeNode(
                                        fileURL: fileURL,
                                        target: child.target(in: self)?.nameForCode
                                    )
                                    parent.children.append(treeNode)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private func filterIntoFileTree(_ rootTreeNode: TreeNode) -> TreeNode {
        assert(rootTreeNode.type == .group)
        let rootFileTreeNode = TreeNode(groupName: rootTreeNode.name)
        for child in rootTreeNode.children {
            filter(fileTreeCandidate: child, parent: rootFileTreeNode)
        }
        return rootFileTreeNode
    }

    private func filter(fileTreeCandidate treeNode: TreeNode, parent: TreeNode) {
        if treeNode.type == .group {
            let newTreeNode = TreeNode(groupName: treeNode.name)
            for child in treeNode.children {
                filter(fileTreeCandidate: child, parent: newTreeNode)
            }
            if !newTreeNode.children.isEmpty {
                parent.children.append(newTreeNode)
            }
        } else if treeNode.type == .file, let fileURL = treeNode.fileURL {
            let newTreeNode = TreeNode(fileURL: fileURL, target: treeNode.target)
            assert(treeNode.children.isEmpty)
            parent.children.append(newTreeNode)
        }
    }

    private func filterIntoGroupTree(_ rootTreeNode: TreeNode) -> TreeNode {
        assert(rootTreeNode.type == .group)
        let rootGroupTreeNode = TreeNode(groupName: rootTreeNode.name)
        for child in rootTreeNode.children {
            filter(groupTreeCandidate: child, parent: rootGroupTreeNode)
        }
        return rootGroupTreeNode
    }
    
    private func filter(groupTreeCandidate treeNode: TreeNode, parent: TreeNode) {
        if treeNode.type == .group {
            let newTreeNode = TreeNode(groupName: treeNode.name)
            parent.children.append(newTreeNode)
            for child in treeNode.children {
                filter(groupTreeCandidate: child, parent: newTreeNode)
            }
        }
    }
    
}
