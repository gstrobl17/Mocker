//
//  DestinationGroupSelectorRouter.swift
//  Mocker
//
//  Created Greg on 4/2/18.
//

import AppKit

class DestinationGroupSelectorRouter: DestinationGroupSelectorWireframeProtocol {

    weak var viewController: NSViewController?

    static func createModule(userDefaults: KeyValueStoring,
                             fileManager: FileManaging) -> (view: NSViewController, interface: DestinationGroupSelectorInterfaceProtocol) {
        // swiftlint:disable force_cast
        let storyboard = NSStoryboard(name: .main, bundle: nil)
        let view = storyboard.instantiateController(withIdentifier: .destinationGroupSelector) as! DestinationGroupSelectorViewController
        // swiftlint:enable force_cast
        view.fileManager = fileManager
        let interactor = DestinationGroupSelectorInteractor(userDefaults: userDefaults)
        let router = DestinationGroupSelectorRouter()
        let presenter = DestinationGroupSelectorPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

       return (view, interactor)
     }
}
