//
//  MockFileSynthesisRouter.swift
//  MockerTests
//
//  Created by Greg on 3/4/18.
//

import AppKit
@testable import Mocker

class MockFileSynthesisRouter: FileSynthesisWireframeProtocol {
    
    weak var viewController: NSViewController?
    
    // swiftlint:disable function_parameter_count
    static func createModule(mockName: String,
                             mockCode: String,
                             project: Project,
                             fileSynthesizer: FileSynthesizing,
                             userDefaults: KeyValueStoring,
                             fileManager: FileManaging,
                             destinationGroupSelectorRouterType: DestinationGroupSelectorWireframeProtocol.Type) -> NSViewController {
        
        let view = MockFileSynthesisView()
        view.reset()
        let interactor = MockFileSynthesisInteractorInput()
        let router = MockFileSynthesisRouter()
        let presenter = MockFileSynthesisPresenter()
        
        presenter.interactor = interactor
        router.viewController = view
        view.presenter = presenter
        
        return view
    }
    // swiftlint:enable function_parameter_count

}

