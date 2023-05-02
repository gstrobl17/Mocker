//
//  DestinationGroupSelectorProtocols.swift
//  Mocker
//
//  Created Greg on 4/2/18.
//

import AppKit

// MARK: Interface -
protocol DestinationGroupSelectorInterfaceProtocol: AnyObject {

    var delegate: DestinationGroupSelectorInterfaceDelegate? { get set }
    
    func present(tree rootTreeNode: TreeNode, for project: Project)
}

protocol DestinationGroupSelectorInterfaceDelegate: AnyObject {
    func destinationGroupSelector(_ interface: DestinationGroupSelectorInterfaceProtocol, groupSelected treeNode: TreeNode)
}

// MARK: Wireframe -
protocol DestinationGroupSelectorWireframeProtocol: AnyObject {

    var viewController: NSViewController? { get set }

    static func createModule(userDefaults: KeyValueStoring,
                             fileManager: FileManaging) -> (view: NSViewController, interface: DestinationGroupSelectorInterfaceProtocol)

}

// MARK: Interactor -
protocol DestinationGroupSelectorInteractorOutputProtocol: AnyObject {

    func present(tree rootTreeNode: TreeNode, for project: Project)
    func select(treeNode: TreeNode)
    /* Interactor -> Presenter */
}

protocol DestinationGroupSelectorInteractorInputProtocol: AnyObject {

    var presenter: DestinationGroupSelectorInteractorOutputProtocol? { get set }
    var selectedNode: TreeNode? { get }

    func nodeSelected(_ treeNode: TreeNode)
    func viewHasLoaded()
    /* Presenter -> Interactor */
}

// MARK: Presenter -
protocol DestinationGroupSelectorPresenterProtocol: AnyObject {

    var interactor: DestinationGroupSelectorInteractorInputProtocol? { get set }

    func nodeSelected(_ treeNode: TreeNode)
    func viewHasLoaded()
    /* ViewController -> Presenter */
}

// MARK: View -
protocol DestinationGroupSelectorViewProtocol: AnyObject {

    var presenter: DestinationGroupSelectorPresenterProtocol? { get set }

    func present(tree rootTreeNode: TreeNode, for project: Project)
    func select(treeNode: TreeNode)
    func enableNewGroupButton(_ flag: Bool)
    /* Presenter -> ViewController */
}
