//
//  DestinationGroupSelectorViewController.swift
//  Mocker
//
//  Created Greg on 4/2/18.
//

import AppKit
import XcodeEditor

class DestinationGroupSelectorViewController: NSViewController {

	var presenter: DestinationGroupSelectorPresenterProtocol?

    @IBOutlet weak private var outlineView: NSOutlineView!
    @IBOutlet weak private var newGroupButton: NSButton!

    var fileManager: FileManaging!
    private var rootTreeNode: TreeNode?
    private var selectedNode: TreeNode?
    private var project: Project?

	override func viewDidLoad() {
        super.viewDidLoad()
        outlineView.headerView = nil
        outlineView.dataSource = self
        outlineView.delegate = self
        presenter?.viewHasLoaded()
    }

    @IBAction private func newGroupPressed(_ sender: Any) {
        
        let prompt = NSAlert()
        prompt.messageText = "Please enter name of new Group"
        prompt.addButton(withTitle: "Create")
        prompt.addButton(withTitle: "Cancel")
        
        let inputTextField = NSTextField(frame: NSRect(x: 0, y: 0, width: 300, height: 24))
        inputTextField.placeholderString = "Enter Group Name"
        prompt.accessoryView = inputTextField
        
        let response = prompt.runModal()
        if response == .alertFirstButtonReturn {
            let groupName = inputTextField.stringValue.trimmingCharacters(in: .whitespaces)
            if !groupName.isEmpty {
                createGroup(named: groupName)
            }
        }
    }
    
    // swiftlint:disable cyclomatic_complexity
    private func createGroup(named groupName: String) {
        guard fileManager != nil else {
            assertionFailure("File manager not set")
            return
        }
        guard let rootTreeNode = rootTreeNode else { return }
        guard let parentNode = selectedNode else { return }
        guard let project = project else { return }
        guard let group = parentNode.groupMember as? XCGroup else { return }
        guard let pathForGroupRelativeToProjectRoot = group.pathRelativeToProjectRoot() else { return }
        guard let parentURL = group.url(in: project) else { return }
        
        let groupURL = parentURL.appendingPathComponent(groupName, isDirectory: true)
        
        // Create the directory for the group (if it doesn't already exist)
        if !fileManager.fileExists(atPath: groupURL.path) {
            do {
                try fileManager.createDirectory(at: groupURL, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                let alert = NSAlert(error: error)
                alert.runModal()
            }
        }
        
        // Create the Group (if it doesn't already exist)
        if let relativeURL = URL(string: pathForGroupRelativeToProjectRoot)?.appendingPathComponent(groupName) {
            if project.groupWithPath(fromRoot: relativeURL.path) != nil {
                // Group already exists
                if let existingTreeNode = findNode(for: relativeURL.path, in: rootTreeNode) {
                    select(treeNode: existingTreeNode)
                } else {
                    assertionFailure("Tree node not found that was expected to exist")
                }
            } else {
                // Create a new group
                if let newGroup = group.add(withPath: groupName) {
                    let treeNode = TreeNode(groupMember: newGroup, type: .group)
                    parentNode.children.append(treeNode)
                    outlineView.reloadData()
                    outlineView.expandItem(nil, expandChildren: true)
                    select(treeNode: treeNode)
                }
            }
        }
    }
    // swiftlint:enable cyclomatic_complexity
}

extension DestinationGroupSelectorViewController: TreeNodeContaining { }

extension DestinationGroupSelectorViewController: DestinationGroupSelectorViewProtocol {
    
    func present(tree rootTreeNode: TreeNode, for project: Project) {
        self.rootTreeNode = rootTreeNode
        self.project = project
        guard outlineView != nil else { return }
        outlineView.reloadData()
        outlineView.expandItem(nil, expandChildren: true)
    }

    func enableNewGroupButton(_ flag: Bool) {
        guard outlineView != nil else { return }
        if outlineView.selectedRow > 0 {
            newGroupButton.isEnabled = flag
        } else {
            newGroupButton.isEnabled = false
        }
    }
    
    func select(treeNode: TreeNode) {
        guard outlineView != nil else { return }
        outlineView.deselectAll(nil)
        
        let row = outlineView.row(forItem: treeNode)
        if row > 0 {
            selectedNode = treeNode
            let indexes = IndexSet(integer: row)
            outlineView.selectRowIndexes(indexes, byExtendingSelection: true)
            let rect = outlineView.rect(ofRow: row)
            outlineView.scroll(rect.origin)
        }
    }

}

extension DestinationGroupSelectorViewController: NSOutlineViewDataSource {
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil, let item = rootTreeNode {
            return item.children.count
        } else if let item = item as? TreeNode {
            return item.children.count
        }
        return 0
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil, let item = rootTreeNode {
            return item.children[index]
        } else if let item = item as? TreeNode {
            return item.children[index]
        }
        fatalError("Unexpected item: \(String(describing: item))")
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let item = item as? TreeNode {
            if !item.children.isEmpty {
                return true
            }
        }
        return false
    }
    
}

extension DestinationGroupSelectorViewController: NSOutlineViewDelegate {
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        guard let item = item as? TreeNode,
            let project = project,
            item.groupMember.displayName() != nil else { return nil }
        let view = TreeNodeView(treeNode: item, project: project)
        return view
    }
    
    func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool {
        if let item = item as? TreeNode {
            if item.type == .group {
                return true
            }
        }
        return false
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        let row = outlineView.selectedRow
        let item = outlineView.item(atRow: row)
        if let item = item as? TreeNode {
            selectedNode = item
            presenter?.nodeSelected(item)
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, shouldCollapseItem item: Any) -> Bool {
        if let item = item as? TreeNode {
            if item.type == .group {
                return true
            }
        }
        return false
    }
    
}
