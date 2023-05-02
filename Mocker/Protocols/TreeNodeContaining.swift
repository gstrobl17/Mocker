//
//  TreeNodeContaining.swift
//  Mocker
//
//  Created by Greg on 3/5/18.
//

import Foundation
import XcodeEditor

protocol TreeNodeContaining {
}

extension TreeNodeContaining {
 
    func findNode(for path: String, in treeNode: TreeNode) -> TreeNode? {
        
        if let group = treeNode.groupMember as? XCGroup, let pathOfGroup = group.pathRelativeToProjectRoot() {
            if pathOfGroup == path {
                return treeNode
            }
        }
        
        for child in treeNode.children {
            if let matchingNode = findNode(for: path, in: child) {
                return matchingNode
            }
        }
        
        return nil
    }

}
