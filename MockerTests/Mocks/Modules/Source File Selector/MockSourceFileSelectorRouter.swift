//
//  MockSourceFileSelectorRouter.swift
//  MockerTests
//
//  Created by Greg on 2/22/18.
//

import AppKit
@testable import Mocker

class MockSourceFileSelectorRouter: SourceFileSelectorWireframeProtocol {
    weak var viewController: (any NSViewController & SourceFileSelectorInterfaceProtocol)?
    
    static func createModule() -> (any NSViewController & SourceFileSelectorInterfaceProtocol) {
        let view = MockSourceFileSelectorView()
        let interactor = MockSourceFileSelectorInteractorInput()
        let router = MockSourceFileSelectorRouter()
        let presenter = MockSourceFileSelectorPresenter()
        
        presenter.interactor = interactor
        router.viewController = view
        view.presenter = presenter
        
        return view
    }

}
