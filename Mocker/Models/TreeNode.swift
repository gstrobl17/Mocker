//
//  TreeNode.swift
//  Mocker
//
//  Created by Greg on 2/18/18.
//

import Foundation

enum TreeNodeType {
    case group
    case file
}

class TreeNode: NSObject {
    
    let type: TreeNodeType
    let name: String       // Either the group name or the file name
    let fileURL: URL?
    let target: String?
    var children: [TreeNode] = []

    init(groupName: String) {
        self.type = .group
        self.name = groupName
        self.fileURL = nil
        self.target = nil
    }
    
    init(fileURL: URL, target: String?) {
        self.type = .file
        self.name = fileURL.lastPathComponent
        self.fileURL = fileURL
        self.target = target
    }
    
    var isSwiftFile: Bool {
        guard let fileURL else { return false }
        return fileURL.pathExtension == "swift"
    }
}
