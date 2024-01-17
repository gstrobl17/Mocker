//
//  SourceFileSelectorProtocols.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit
import XcodeEditor

protocol SourceFileSelectorInterfaceProtocol: AnyObject {
    var delegate: SourceFileSelectorInterfaceDelegate? { get set }
    
    func present(tree rootTreeNode: TreeNode, for project: Project)
}

protocol SourceFileSelectorInterfaceDelegate: AnyObject {
    func sourceFileSelector(_ view: (NSViewController & SourceFileSelectorInterfaceProtocol), fileSelected treeNode: TreeNode)
}

// MARK: Wireframe -
protocol SourceFileSelectorWireframeProtocol: AnyObject {
    var viewController: (NSViewController & SourceFileSelectorInterfaceProtocol)? { get }
    
    static func createModule() -> (NSViewController & SourceFileSelectorInterfaceProtocol)
}

// MARK: Presenter -
protocol SourceFileSelectorPresenterProtocol: AnyObject {

    var interactor: SourceFileSelectorInteractorInputProtocol? { get set }

    func viewHasLoaded()
}

// MARK: Interactor -
protocol SourceFileSelectorInteractorOutputProtocol: AnyObject {    //swiftlint:disable:this type_name
    
    /* Interactor -> Presenter */
}

protocol SourceFileSelectorInteractorInputProtocol: AnyObject { //swiftlint:disable:this type_name
    
    var presenter: SourceFileSelectorInteractorOutputProtocol? { get set }
    
    func viewHasLoaded()
    /* Presenter -> Interactor */
}

// MARK: View -
protocol SourceFileSelectorViewProtocol: AnyObject {

    var presenter: SourceFileSelectorPresenterProtocol? { get set }
    var delegate: SourceFileSelectorInterfaceDelegate? { get set }
}
