//
//  ProtocolSelectorRouter.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

class ProtocolSelectorRouter: ProtocolSelectorWireframeProtocol {

    weak var viewController: (NSViewController & ProtocolSelectorInterfaceProtocol)?

    static func createModule() -> (NSViewController & ProtocolSelectorInterfaceProtocol) {
        
        let storyboard = NSStoryboard(name: .main, bundle: nil)
        // swiftlint:disable force_cast
        let view = storyboard.instantiateController(withIdentifier: .protocolSelector) as! ProtocolSelectorViewController
        // swiftlint:enable force_cast
        let interactor = ProtocolSelectorInteractor()
        let router = ProtocolSelectorRouter()
        let presenter = ProtocolSelectorPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
