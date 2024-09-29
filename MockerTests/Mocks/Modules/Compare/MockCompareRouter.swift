//
//  MockCompareRouter.swift
//  Mocker
//
//  Created by Greg Strobl on 9/28/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import AppKit
@testable import Mocker

class MockCompareRouter: CompareWireframeProtocol {
    
    static let view = MockCompareView()
    
    weak var viewController: (any NSViewController & CompareInterfaceProtocol)?
    
    static func createModule(openPanelFactory: any OpenPanelFactory, userDefaults: any KeyValueStoring) -> (any NSViewController & CompareInterfaceProtocol) {
        
        let view = MockCompareRouter.view
        view.reset()
        let interactor = MockCompareInteractorInput()
        let router = MockCompareRouter()
        let presenter = MockComparePresenter()
        
        presenter.interactor = interactor
        router.viewController = view
        view.presenter = presenter
        
        return view
    }
    
}
