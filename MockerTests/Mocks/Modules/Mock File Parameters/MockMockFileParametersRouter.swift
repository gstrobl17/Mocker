//
//  MockMockFileParametersRouter.swift
//  MockerTests
//
//  Created by Greg on 2/25/18.
//

import AppKit
@testable import Mocker

class MockMockFileParametersRouter: MockFileParametersWireframeProtocol {
    
    weak var viewController: (NSViewController & MockFileParametersInterfaceProtocol)?
    
    static func createModule(userDefaults: KeyValueStoring) -> (NSViewController & MockFileParametersInterfaceProtocol) {
        
        let view = MockMockFileParametersView()
        view.reset()
        let interactor = MockMockFileParametersInteractorInput()
        let router = MockMockFileParametersRouter()
        let presenter = MockMockFileParametersPresenter()
        
        presenter.interactor = interactor
        router.viewController = view
        view.presenter = presenter
        
        return view
    }
    
}

