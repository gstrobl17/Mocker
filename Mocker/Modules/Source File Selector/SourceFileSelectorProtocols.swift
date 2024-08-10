//
//  SourceFileSelectorProtocols.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit
import XcodeEditor

protocol SourceFileSelectorInterfaceProtocol: AnyObject {
    var delegate: (any SourceFileSelectorInterfaceDelegate)? { get set }
    
    func present(tree rootTreeNode: TreeNode, for dataSource: any SourceFileDataSource)
}

protocol SourceFileSelectorInterfaceDelegate: AnyObject {
    func sourceFileSelector(_ view: (any NSViewController & SourceFileSelectorInterfaceProtocol), fileSelected treeNode: TreeNode)
}

// MARK: Wireframe -
protocol SourceFileSelectorWireframeProtocol: AnyObject {
    var viewController: (any NSViewController & SourceFileSelectorInterfaceProtocol)? { get }
    
    static func createModule() -> (any NSViewController & SourceFileSelectorInterfaceProtocol)
}

// MARK: Presenter -
protocol SourceFileSelectorPresenterProtocol: AnyObject {

    var interactor: (any SourceFileSelectorInteractorInputProtocol)? { get set }

    func viewHasLoaded()
}

// MARK: Interactor -
protocol SourceFileSelectorInteractorOutputProtocol: AnyObject {    //swiftlint:disable:this type_name
    
    /* Interactor -> Presenter */
}

protocol SourceFileSelectorInteractorInputProtocol: AnyObject { //swiftlint:disable:this type_name
    
    var presenter: (any SourceFileSelectorInteractorOutputProtocol)? { get set }
    
    func viewHasLoaded()
    /* Presenter -> Interactor */
}

// MARK: View -
protocol SourceFileSelectorViewProtocol: AnyObject {

    var presenter: (any SourceFileSelectorPresenterProtocol)? { get set }
    var delegate: (any SourceFileSelectorInterfaceDelegate)? { get set }
}
