//
//  FilterRouter.swift
//  Mocker
//
//  Created Greg on 10/13/18.
//

import AppKit

class FilterRouter: FilterWireframeProtocol {

    weak var viewController: NSViewController?

    static func createModule(userDefaults: any KeyValueStoring) -> (view: NSViewController, interface: any FilterInterfaceProtocol) {
        let storyboard = NSStoryboard(name: .main, bundle: nil)
        let view = storyboard.instantiateController(withIdentifier: .filter) as! FilterViewController //swiftlint:disable:this force_cast
        let interactor = FilterInteractor(userDefaults: userDefaults)
        let router = FilterRouter()
        let presenter = FilterPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

       return (view, interactor)
     }
}
