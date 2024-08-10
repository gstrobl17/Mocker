//
//  ProtocolSelectorProtocols.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit
import SwiftSyntax

protocol ProtocolSelectorInterfaceProtocol: AnyObject {
    var delegate: (any ProtocolSelectorInterfaceDelegate)? { get set }
    
    func present(protocols: [ProtocolDeclSyntax])
}

protocol ProtocolSelectorInterfaceDelegate: AnyObject {
    func protocolSelector(_ view: (any NSViewController & ProtocolSelectorInterfaceProtocol),
                          protocolSelected declaration: ProtocolDeclSyntax)
}

// MARK: Wireframe -
protocol ProtocolSelectorWireframeProtocol: AnyObject {
    var viewController: (any NSViewController & ProtocolSelectorInterfaceProtocol)? { get }
    
    static func createModule() -> (any NSViewController & ProtocolSelectorInterfaceProtocol)
}

// MARK: Presenter -
protocol ProtocolSelectorPresenterProtocol: AnyObject {

    var interactor: (any ProtocolSelectorInteractorInputProtocol)? { get set }
}

// MARK: Interactor -
protocol ProtocolSelectorInteractorOutputProtocol: AnyObject {

    /* Interactor -> Presenter */
}

protocol ProtocolSelectorInteractorInputProtocol: AnyObject {

    var presenter: (any ProtocolSelectorInteractorOutputProtocol)? { get set }

    /* Presenter -> Interactor */
}

// MARK: View -
protocol ProtocolSelectorViewProtocol: AnyObject {

    var presenter: (any ProtocolSelectorPresenterProtocol)? { get set }
    var delegate: (any ProtocolSelectorInterfaceDelegate)? { get set }

    /* Presenter -> ViewController */
}
