//
//  DestinationGroupSelectorPresenter.swift
//  Mocker
//
//  Created Greg on 4/2/18.
//

import AppKit

class DestinationGroupSelectorPresenter {

    weak internal var view: DestinationGroupSelectorViewProtocol?
    var interactor: DestinationGroupSelectorInteractorInputProtocol?
    let router: DestinationGroupSelectorWireframeProtocol

    init(interface: DestinationGroupSelectorViewProtocol, interactor: DestinationGroupSelectorInteractorInputProtocol?, router: DestinationGroupSelectorWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func setSate() {
        var enableNewGroupButton = false
        if interactor?.selectedNode != nil {
            enableNewGroupButton = true
        }
        view?.enableNewGroupButton(enableNewGroupButton)
    }
}

extension DestinationGroupSelectorPresenter: DestinationGroupSelectorPresenterProtocol {
    
    func nodeSelected(_ treeNode: TreeNode) {
        interactor?.nodeSelected(treeNode)
        setSate()
    }
    
    func viewHasLoaded() {
        interactor?.viewHasLoaded()
        setSate()
    }

}

extension DestinationGroupSelectorPresenter: DestinationGroupSelectorInteractorOutputProtocol {
    
    func present(tree rootTreeNode: TreeNode, for project: Project) {
        view?.present(tree: rootTreeNode, for: project)
    }

    func select(treeNode: TreeNode) {
        view?.select(treeNode: treeNode)
        setSate()
    }

}
