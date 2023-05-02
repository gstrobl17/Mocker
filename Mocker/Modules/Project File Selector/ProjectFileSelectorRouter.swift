//
//  ProjectFileSelectorRouter.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

class ProjectFileSelectorRouter: ProjectFileSelectorWireframeProtocol {

    weak var viewController: (NSViewController & ProjectFileSelectorInterfaceProtocol)?

    static func createModule(openPanelFactory: OpenPanelFactory) -> (NSViewController & ProjectFileSelectorInterfaceProtocol) {
        
        let storyboard = NSStoryboard(name: .main, bundle: nil)
        // swiftlint:disable force_cast
        let view = storyboard.instantiateController(withIdentifier: .projectFileSelector) as! ProjectFileSelectorViewController
        // swiftlint:enable force_cast
        let interactor = ProjectFileSelectorInteractor()
        let router = ProjectFileSelectorRouter()
        let presenter = ProjectFileSelectorPresenter(interface: view, interactor: interactor, router: router, openPanelFactory: openPanelFactory)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
