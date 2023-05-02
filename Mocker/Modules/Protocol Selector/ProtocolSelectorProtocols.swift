//
//  ProtocolSelectorProtocols.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit
import SwiftSyntax

protocol ProtocolSelectorInterfaceProtocol: AnyObject {
    var delegate: ProtocolSelectorInterfaceDelegate? { get set }
    
    func present(protocols: [ProtocolDeclSyntax])
}

protocol ProtocolSelectorInterfaceDelegate: AnyObject {
    func protocolSelector(_ view: (NSViewController & ProtocolSelectorInterfaceProtocol),
                          protocolSelected declaration: ProtocolDeclSyntax)
}

// MARK: Wireframe -
protocol ProtocolSelectorWireframeProtocol: AnyObject {
    var viewController: (NSViewController & ProtocolSelectorInterfaceProtocol)? { get }
    
    static func createModule() -> (NSViewController & ProtocolSelectorInterfaceProtocol)
}

// MARK: Presenter -
protocol ProtocolSelectorPresenterProtocol: AnyObject {

    var interactor: ProtocolSelectorInteractorInputProtocol? { get set }
}

// MARK: Interactor -
protocol ProtocolSelectorInteractorOutputProtocol: AnyObject {

    /* Interactor -> Presenter */
}

protocol ProtocolSelectorInteractorInputProtocol: AnyObject {

    var presenter: ProtocolSelectorInteractorOutputProtocol? { get set }

    /* Presenter -> Interactor */
}

// MARK: View -
protocol ProtocolSelectorViewProtocol: AnyObject {

    var presenter: ProtocolSelectorPresenterProtocol? { get set }
    var delegate: ProtocolSelectorInterfaceDelegate? { get set }

    /* Presenter -> ViewController */
}
