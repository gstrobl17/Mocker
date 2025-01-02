//
//  ProjectFileSelectorProtocols.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

@MainActor
protocol ProjectFileSelectorInterfaceProtocol: AnyObject {
    var delegate: (any ProjectFileSelectorInterfaceDelegate)? { get set }

    func selectProject()
    func canReloadProject() -> Bool
    func reloadProject()
    func showSelectedFile(_ url: URL)
    func renderURLOfSelectedFile(_ url: URL)
}

@MainActor
protocol ProjectFileSelectorInterfaceDelegate: AnyObject {
    func projectFileSelector(_ view: any NSViewController & ProjectFileSelectorInterfaceProtocol, fileSelected: URL)
}

// MARK: Wireframe -
@MainActor
protocol ProjectFileSelectorWireframeProtocol: AnyObject {

    var viewController: (any NSViewController & ProjectFileSelectorInterfaceProtocol)? { get }
    
    static func createModule(openPanelFactory: any OpenPanelFactory, userDefaults: any KeyValueStoring) -> (any NSViewController & ProjectFileSelectorInterfaceProtocol)
}

// MARK: Presenter -
@MainActor
protocol ProjectFileSelectorPresenterProtocol: AnyObject {

    var interactor: (any ProjectFileSelectorInteractorInputProtocol)? { get set }
    
    func setURL(_ url: URL)
    func selectPressed()
    func reloadPressed()
    func canReloadProject() -> Bool
    func viewHasLoaded()
}

// MARK: Interactor -
@MainActor
protocol ProjectFileSelectorInteractorOutputProtocol: AnyObject { //swiftlint:disable:this type_name

    func showSelectedFile(_ url: URL)

    /* Interactor -> Presenter */
}

@MainActor
protocol ProjectFileSelectorInteractorInputProtocol: AnyObject { //swiftlint:disable:this type_name

    var presenter: (any ProjectFileSelectorInteractorOutputProtocol)? { get set }
    var url: URL? { get }
    
    func setURL(_ url: URL)
    func projectFileSelected(_ url: URL)
    func viewHasLoaded()
    /* Presenter -> Interactor */
}

// MARK: View -
@MainActor
protocol ProjectFileSelectorViewProtocol: AnyObject {

    var presenter: (any ProjectFileSelectorPresenterProtocol)? { get set }
    var delegate: (any ProjectFileSelectorInterfaceDelegate)? { get set }

    func showSelectedFile(_ url: URL)
    func openModalSheet(with openPanel: any OpenPanel, completionHandler handler: @escaping (NSApplication.ModalResponse) -> Swift.Void)
    /* Presenter -> ViewController */
}
