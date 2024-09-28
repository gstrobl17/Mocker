//
//  CompareProtocols.swift
//  Mocker
//
//  Created Greg Strobl on 9/27/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import AppKit

// MARK: Interface -
@MainActor
protocol CompareInterfaceProtocol: AnyObject {

    var delegate: (any CompareInterfaceDelegate)? { get set }
    
    func enableCompare(_ flag: Bool)
}

@MainActor
protocol CompareInterfaceDelegate: AnyObject {
    func mockCodeForCompare(_ view: any NSViewController & CompareInterfaceProtocol) -> String
}

// MARK: Wireframe -
@MainActor
protocol CompareWireframeProtocol: AnyObject {

    var viewController: NSViewController? { get set }

    static func createModule(openPanelFactory: any OpenPanelFactory, userDefaults: any KeyValueStoring) -> (any NSViewController & CompareInterfaceProtocol)

}

// MARK: Interactor -
@MainActor
protocol CompareInteractorOutputProtocol: AnyObject {

    /* Interactor -> Presenter */
    func showButton(_ flag: Bool)
    func reportErrorCondition(with messageText: String, and informativeText: String)
    func mockCodeForCompare() -> String
}

@MainActor
protocol CompareInteractorInputProtocol: AnyObject {

    var presenter: (any CompareInteractorOutputProtocol)? { get set }

    /* Presenter -> Interactor */
    func fileToCompareSelected(_ url: URL)
}

// MARK: Presenter -
@MainActor
protocol ComparePresenterProtocol: AnyObject {

    var interactor: (any CompareInteractorInputProtocol)? { get set }

    /* ViewController -> Presenter */
    func compareButtonPressed()
}

// MARK: View -
@MainActor
protocol CompareViewProtocol: AnyObject {

    var presenter: (any ComparePresenterProtocol)? { get set }

    /* Presenter -> ViewController */
    func showButton(_ flag: Bool)

    func openModalSheet(with openPanel: any OpenPanel, completionHandler handler: @escaping (NSApplication.ModalResponse) -> Swift.Void)
    func reportErrorCondition(with messageText: String, and informativeText: String)
    func mockCodeForCompare() -> String

}
