//
//  ProjectFileSelectorProtocols.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

protocol ProjectFileSelectorInterfaceProtocol: AnyObject {
    var delegate: ProjectFileSelectorInterfaceDelegate? { get set }

    func selectProject()
    func canReloadProject() -> Bool
    func reloadProject()
    func showSelectedFile(_ url: URL)
    func renderURLOfSelectedFile(_ url: URL)
}

protocol ProjectFileSelectorInterfaceDelegate: AnyObject {
    func projectFileSelector(_ view: NSViewController & ProjectFileSelectorInterfaceProtocol, fileSelected: URL)
}

// MARK: Wireframe -
protocol ProjectFileSelectorWireframeProtocol: AnyObject {

    var viewController: (NSViewController & ProjectFileSelectorInterfaceProtocol)? { get }
    
    static func createModule(openPanelFactory: OpenPanelFactory) -> (NSViewController & ProjectFileSelectorInterfaceProtocol)
}

// MARK: Presenter -
protocol ProjectFileSelectorPresenterProtocol: AnyObject {

    var interactor: ProjectFileSelectorInteractorInputProtocol? { get set }
    
    func setURL(_ url: URL)
    func selectPressed()
    func reloadPressed()
    func canReloadProject() -> Bool
    func viewHasLoaded()
}

// MARK: Interactor -
protocol ProjectFileSelectorInteractorOutputProtocol: AnyObject { //swiftlint:disable:this type_name

    func showSelectedFile(_ url: URL)

    /* Interactor -> Presenter */
}

protocol ProjectFileSelectorInteractorInputProtocol: AnyObject { //swiftlint:disable:this type_name

    var presenter: ProjectFileSelectorInteractorOutputProtocol? { get set }
    var url: URL? { get }
    
    func setURL(_ url: URL)
    func projectFileSelected(_ url: URL)
    func viewHasLoaded()
    /* Presenter -> Interactor */
}

// MARK: View -
protocol ProjectFileSelectorViewProtocol: AnyObject {

    var presenter: ProjectFileSelectorPresenterProtocol? { get set }
    var delegate: ProjectFileSelectorInterfaceDelegate? { get set }

    func showSelectedFile(_ url: URL)
    func openModalSheet(with openPanel: OpenPanel, completionHandler handler: @escaping (NSApplication.ModalResponse) -> Swift.Void)
    /* Presenter -> ViewController */
}
