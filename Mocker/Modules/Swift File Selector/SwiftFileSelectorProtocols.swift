//
//  SwiftFileSelectorProtocols.swift
//  Mocker
//
//  Created Greg on 1/2/25.
//

import AppKit

@MainActor
protocol SwiftFileSelectorInterfaceProtocol: AnyObject {
    var delegate: (any SwiftFileSelectorInterfaceDelegate)? { get set }

    func selectSwiftFile()
    func showSelectedFile(_ url: URL)
    func renderURLOfSelectedFile(_ url: URL)
}

@MainActor
protocol SwiftFileSelectorInterfaceDelegate: AnyObject {
    func swiftFileSelector(_ view: any NSViewController & SwiftFileSelectorInterfaceProtocol, fileSelected: URL)
}

// MARK: Wireframe -
@MainActor
protocol SwiftFileSelectorWireframeProtocol: AnyObject {

    var viewController: (any NSViewController & SwiftFileSelectorInterfaceProtocol)? { get }
    
    static func createModule(openPanelFactory: any OpenPanelFactory, userDefaults: any KeyValueStoring) -> (any NSViewController & SwiftFileSelectorInterfaceProtocol)
}

// MARK: Presenter -
@MainActor
protocol SwiftFileSelectorPresenterProtocol: AnyObject {

    var interactor: (any SwiftFileSelectorInteractorInputProtocol)? { get set }
    
    func setURL(_ url: URL)
    func selectPressed()
    func viewHasLoaded()
}

// MARK: Interactor -
@MainActor
protocol SwiftFileSelectorInteractorOutputProtocol: AnyObject { //swiftlint:disable:this type_name

    func showSelectedFile(_ url: URL)

    /* Interactor -> Presenter */
}

@MainActor
protocol SwiftFileSelectorInteractorInputProtocol: AnyObject {

    var presenter: (any SwiftFileSelectorInteractorOutputProtocol)? { get set }
    var url: URL? { get }
    
    func setURL(_ url: URL)
    func swiftFileSelected(_ url: URL)
    func viewHasLoaded()
    /* Presenter -> Interactor */
}

// MARK: View -
@MainActor
protocol SwiftFileSelectorViewProtocol: AnyObject {

    var presenter: (any SwiftFileSelectorPresenterProtocol)? { get set }
    var delegate: (any SwiftFileSelectorInterfaceDelegate)? { get set }

    func showSelectedFile(_ url: URL)
    func openModalSheet(with openPanel: any OpenPanel, completionHandler handler: @escaping (NSApplication.ModalResponse) -> Swift.Void)
    /* Presenter -> ViewController */
}
