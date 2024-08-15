//
//  MockFileParametersRouter.swift
//  Mocker
//
//  Created Greg on 2/25/18.
//

import AppKit

@MainActor
class MockFileParametersRouter: MockFileParametersWireframeProtocol {

    weak var viewController: (any NSViewController & MockFileParametersInterfaceProtocol)?

    static func createModule(userDefaults: any KeyValueStoring) -> (any NSViewController & MockFileParametersInterfaceProtocol) {
        
        let storyboard = NSStoryboard(name: .main, bundle: nil)
        // swiftlint:disable force_cast
        let view = storyboard.instantiateController(withIdentifier: .mockFileParameters) as! MockFileParametersViewController
        // swiftlint:enable force_cast
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        let router = MockFileParametersRouter()
        let presenter = MockFileParametersPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
