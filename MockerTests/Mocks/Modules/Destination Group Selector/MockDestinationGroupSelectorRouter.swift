//
//  MockDestinationGroupSelectorRouter.swift
//  MockerTests
//
//  Created by Greg on 3/3/18.
//

import AppKit
@testable import Mocker

class MockDestinationGroupSelectorRouter: DestinationGroupSelectorWireframeProtocol {

    weak var viewController: NSViewController?
    
    static func createModule(userDefaults: KeyValueStoring, fileManager: FileManaging) -> (view: NSViewController, interface: DestinationGroupSelectorInterfaceProtocol) {
        
        let view = MockDestinationGroupSelectorView()
        view.reset()
        let interface = MockDestinationGroupSelectorInterface()
        let interactor = MockDestinationGroupSelectorInteractorInput()
        let router = MockDestinationGroupSelectorRouter()
        let presenter = MockDestinationGroupSelectorPresenter()
        
        presenter.interactor = interactor
        router.viewController = view
        view.presenter = presenter
        
        return (view, interface)
    }

}
