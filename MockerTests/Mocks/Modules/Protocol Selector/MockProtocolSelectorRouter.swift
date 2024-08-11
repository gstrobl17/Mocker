//
//  MockProtocolSelectorRouter.swift
//  MockerTests
//
//  Created by Greg on 2/25/18.
//

import AppKit
@testable import Mocker

class MockProtocolSelectorRouter: ProtocolSelectorWireframeProtocol {
    weak var viewController: (any NSViewController & ProtocolSelectorInterfaceProtocol)?
    
    static func createModule() -> (any NSViewController & ProtocolSelectorInterfaceProtocol) {
        let view = MockProtocolSelectorView()
        let interactor = MockProtocolSelectorInteractorInput()
        let router = MockProtocolSelectorRouter()
        let presenter = MockProtocolSelectorPresenter()
        
        presenter.interactor = interactor
        router.viewController = view
        view.presenter = presenter
        
        return view
    }
    
}
