//
//  MockProjectFileSelectorRouter.swift
//  MockerTests
//
//  Created by Greg on 2/22/18.
//

import AppKit
@testable import Mocker

class MockProjectFileSelectorRouter: ProjectFileSelectorWireframeProtocol {
    static let view = MockProjectFileSelectorView()
    
    weak var viewController: (NSViewController & ProjectFileSelectorInterfaceProtocol)?
    
    static func createModule(openPanelFactory: OpenPanelFactory) -> (NSViewController & ProjectFileSelectorInterfaceProtocol) {
        
        let view = MockProjectFileSelectorRouter.view
        view.reset()
        let interactor = MockProjectFileSelectorInteractorInput()
        let router = MockProjectFileSelectorRouter()
        let presenter = MockProjectFileSelectorPresenter()
        
        presenter.interactor = interactor
        router.viewController = view
        view.presenter = presenter
        
        return view
    }
    
}
