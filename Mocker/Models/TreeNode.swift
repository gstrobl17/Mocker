//
//  TreeNode.swift
//  Mocker
//
//  Created by Greg on 2/18/18.
//

import Foundation
import XcodeEditor

enum TreeNodeType {
    case group
    case file
}

class TreeNode: NSObject {
    
    let groupMember: XcodeGroupMember
    let type: TreeNodeType
    var children: [TreeNode] = []
    
    init(groupMember: XcodeGroupMember, type: TreeNodeType) {
        self.groupMember = groupMember
        self.type = type
    }
}
