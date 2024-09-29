//
//  CompareRouter.swift
//  Mocker
//
//  Created Greg Strobl on 9/27/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import AppKit

class CompareRouter: CompareWireframeProtocol {

    weak var viewController: (any NSViewController & CompareInterfaceProtocol)?

    static func createModule(openPanelFactory: any OpenPanelFactory, userDefaults: any KeyValueStoring) -> (any NSViewController & CompareInterfaceProtocol) {
        let storyboard = NSStoryboard(name: .main, bundle: nil)
        // swiftlint:disable force_cast
        let view = storyboard.instantiateController(withIdentifier: .compare) as! CompareViewController
        // swiftlint:enable force_cast
        let interactor = CompareInteractor()
        let router = CompareRouter()
        let presenter = ComparePresenter(view: view, interactor: interactor, router: router, openPanelFactory: openPanelFactory, userDefaults: userDefaults)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
