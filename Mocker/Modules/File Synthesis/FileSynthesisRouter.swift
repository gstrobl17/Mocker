//
//  FileSynthesisRouter.swift
//  Mocker
//
//  Created Greg on 3/2/18.
//

import AppKit

class FileSynthesisRouter: FileSynthesisWireframeProtocol {

    weak var viewController: NSViewController?

    // swiftlint:disable function_parameter_count
    static func createModule(mockName: String,
                             mockCode: String,
                             project: Project,
                             fileSynthesizer: FileSynthesizing,
                             userDefaults: KeyValueStoring,
                             fileManager: FileManaging,
                             destinationGroupSelectorRouterType: DestinationGroupSelectorWireframeProtocol.Type) -> NSViewController {
        
        let storyboard = NSStoryboard(name: .main, bundle: nil)
        // swiftlint:disable force_cast
        let view = storyboard.instantiateController(withIdentifier: .fileSynthesis) as! FileSynthesisViewController
        // swiftlint:enable force_cast
        let interactor = FileSynthesisInteractor(mockName: mockName,
                                                 mockCode: mockCode,
                                                 project: project,
                                                 fileSynthesizer: fileSynthesizer,
                                                 userDefaults: userDefaults,
                                                 fileManager: fileManager,
                                                 destinationGroupSelectorRouterType: destinationGroupSelectorRouterType)
        let router = FileSynthesisRouter()
        let presenter = FileSynthesisPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
   }
    // swiftlint:enable function_parameter_count

}
