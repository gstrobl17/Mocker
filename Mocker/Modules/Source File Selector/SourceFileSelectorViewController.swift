//
//  SourceFileSelectorViewController.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

class SourceFileSelectorViewController: NSViewController {

    @IBOutlet weak private var outlineView: NSOutlineView!
    
    var presenter: (any SourceFileSelectorPresenterProtocol)?
    weak var delegate: (any SourceFileSelectorInterfaceDelegate)?

    private var rootTreeNode: SendableTreeNode?
    private var dataSource: (any SourceFileDataSource)?

	override func viewDidLoad() {
        super.viewDidLoad()
        outlineView.dataSource = self
        outlineView.delegate = self
        presenter?.viewHasLoaded()
    }

}

extension SourceFileSelectorViewController: SourceFileSelectorViewProtocol {
    
}

extension SourceFileSelectorViewController: SourceFileSelectorInterfaceProtocol {
    
    func present(tree rootTreeNode: SendableTreeNode, for dataSource: any SourceFileDataSource) {
        self.rootTreeNode = rootTreeNode
        self.dataSource = dataSource
        outlineView.reloadData()
        outlineView.expandItem(nil, expandChildren: true)
    }

}

extension SourceFileSelectorViewController: NSOutlineViewDataSource {
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil, let item = rootTreeNode {
            return item.children.count
        } else if let item = item as? SendableTreeNode {
            return item.children.count
        }
        return 0
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil, let item = rootTreeNode {
            return item.children[index]
        } else if let item = item as? SendableTreeNode {
            return item.children[index]
        }
        fatalError("Unexpected item: \(String(describing: item))")
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let item = item as? SendableTreeNode {
            if !item.children.isEmpty {
                return true
            }
        }
        return false
    }
    
}

extension SourceFileSelectorViewController: NSOutlineViewDelegate {
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        guard let item = item as? SendableTreeNode,
            let dataSource,
              !item.name.isEmpty else { return nil }
        let view = SendableTreeNodeView(sendableTreeNode: item, dataSource: dataSource)
        return view
    }
    
    func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool {
        if let item = item as? SendableTreeNode {
            if item.type == .file {
                return true
            }
        }
        return false
    }

    func outlineViewSelectionDidChange(_ notification: Notification) {
        let row = outlineView.selectedRow
        let item = outlineView.item(atRow: row)
        if let item = item as? SendableTreeNode {
            delegate?.sourceFileSelector(self, fileSelected: item)
        }
    }
    
    func outlineView(_ outlineView: NSOutlineView, shouldCollapseItem item: Any) -> Bool {
        if let item = item as? SendableTreeNode {
            if item.type == .group {
                return true
            }
        }
        return false
    }
    
}
