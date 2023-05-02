//
//  DestinationGroupSelectorInteractor.swift
//  Mocker
//
//  Created Greg on 4/2/18.
//

import AppKit
import XcodeEditor

class DestinationGroupSelectorInteractor {

    weak var presenter: DestinationGroupSelectorInteractorOutputProtocol? {
        didSet {
            lookForPreviouslySelectedGroup()
        }
    }
    
    weak var delegate: DestinationGroupSelectorInterfaceDelegate? 
    
    private var userDefaults: KeyValueStoring
    private var project: Project?
    private var rootTreeNode: TreeNode?
    private(set) var selectedNode: TreeNode?
    
    init(userDefaults: KeyValueStoring) {
        self.userDefaults = userDefaults
    }
    
    private func lookForPreviouslySelectedGroup() {
        guard let project = project else { return }
        guard let rootTreeNode = rootTreeNode else { return }
        presenter?.present(tree: rootTreeNode, for: project)

        guard let path = userDefaults.previousSelectedGroupPath else { return }
        if let treeNode = findNode(for: path, in: rootTreeNode) {
            selectedNode = treeNode
            presenter?.select(treeNode: treeNode)
        }
    }

}

extension DestinationGroupSelectorInteractor: TreeNodeContaining { }

extension DestinationGroupSelectorInteractor: DestinationGroupSelectorInteractorInputProtocol {
    
    func nodeSelected(_ treeNode: TreeNode) {
        if let group = treeNode.groupMember as? XCGroup, let path = group.pathRelativeToProjectRoot() {
            selectedNode = treeNode
            userDefaults.previousSelectedGroupPath = path
            delegate?.destinationGroupSelector(self, groupSelected: treeNode)
        }
    }
    
    func viewHasLoaded() {
        lookForPreviouslySelectedGroup()
    }
}

extension DestinationGroupSelectorInteractor: DestinationGroupSelectorInterfaceProtocol {
    
    func present(tree rootTreeNode: TreeNode, for project: Project) {
        self.project = project
        self.rootTreeNode = rootTreeNode
        lookForPreviouslySelectedGroup()
    }

}
