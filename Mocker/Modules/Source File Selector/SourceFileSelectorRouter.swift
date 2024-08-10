//
//  SourceFileSelectorRouter.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

class SourceFileSelectorRouter: SourceFileSelectorWireframeProtocol {
    
    weak var viewController: (any NSViewController & SourceFileSelectorInterfaceProtocol)?
    
    static func createModule() -> (any NSViewController & SourceFileSelectorInterfaceProtocol) {
        
        let storyboard = NSStoryboard(name: .main, bundle: nil)
        // swiftlint:disable force_cast
        let view = storyboard.instantiateController(withIdentifier: .sourceFileSelector) as! SourceFileSelectorViewController
        // swiftlint:enable force_cast
        let interactor = SourceFileSelectorInteractor()
        let router = SourceFileSelectorRouter()
        let presenter = SourceFileSelectorPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
