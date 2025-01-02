//
//  SwiftFileSelectorRouter.swift
//  Mocker
//
//  Created Greg on 1/2/25.
//

import AppKit

class SwiftFileSelectorRouter: SwiftFileSelectorWireframeProtocol {

    weak var viewController: (any NSViewController & SwiftFileSelectorInterfaceProtocol)?

    static func createModule(openPanelFactory: any OpenPanelFactory, userDefaults: any KeyValueStoring) -> (any NSViewController & SwiftFileSelectorInterfaceProtocol) {
        
        let storyboard = NSStoryboard(name: .main, bundle: nil)
        // swiftlint:disable force_cast
        let view = storyboard.instantiateController(withIdentifier: .swiftFileSelector) as! SwiftFileSelectorViewController
        // swiftlint:enable force_cast
        let interactor = SwiftFileSelectorInteractor()
        let router = SwiftFileSelectorRouter()
        let presenter = SwiftFileSelectorPresenter(interface: view, interactor: interactor, router: router, openPanelFactory: openPanelFactory, userDefaults: userDefaults)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
