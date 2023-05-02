//
//  GodfatherRouter.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

class GodfatherRouter: GodfatherWireframeProtocol {

    weak var view: (GodfatherViewProtocol & GodfatherInterfaceProtocol)?

    // swiftlint:disable:next function_parameter_count
    static func createModule(viewController: ViewController,
                             userDefaults: KeyValueStoring,
                             fileManager: FileManaging,
                             projectFactory: ProjectFactory,
                             mockGeneratorFactory: MockGeneratorFactory,
                             openPanelFactory: OpenPanelFactory,
                             projectFileSelectorRouterType: ProjectFileSelectorWireframeProtocol.Type,
                             sourceFileSelectorRouterType: SourceFileSelectorWireframeProtocol.Type,
                             sourceFileFilterRouterType: FilterWireframeProtocol.Type,
                             protocolSelectorRouterType: ProtocolSelectorWireframeProtocol.Type,
                             mockFileParametersRouterType: MockFileParametersWireframeProtocol.Type,
                             contentPresenterRouterType: ContentPresenterWireframeProtocol.Type,
                             fileSynthesisRouterRouterType: FileSynthesisWireframeProtocol.Type,
                             destinationGroupSelectorRouterType: DestinationGroupSelectorWireframeProtocol.Type,
                             filteringHandler: AsyncFilteringHandler) -> (GodfatherViewProtocol & GodfatherInterfaceProtocol) {

        let view = GodfatherView(viewController: viewController)
        let interactor = GodfatherInteractor(userDefaults: userDefaults,
                                             fileManager: fileManager,
                                             projectFactory: projectFactory,
                                             mockGeneratorFactory: mockGeneratorFactory,
                                             openPanelFactory: openPanelFactory,
                                             projectFileSelectorRouterType: projectFileSelectorRouterType,
                                             sourceFileSelectorRouterType: sourceFileSelectorRouterType,
                                             sourceFileFilterRouterType: sourceFileFilterRouterType,
                                             protocolSelectorRouterType: protocolSelectorRouterType,
                                             mockFileParametersRouterType: mockFileParametersRouterType,
                                             contentPresenterRouterType: contentPresenterRouterType,
                                             filteringHandler: filteringHandler)
        let router = GodfatherRouter()
        let presenter = GodfatherPresenter(interface: view,
                                           interactor: interactor,
                                           router: router,
                                           userDefaults: userDefaults,
                                           fileSynthesisRouterRouterType: fileSynthesisRouterRouterType,
                                           destinationGroupSelectorRouterType: destinationGroupSelectorRouterType)

        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view

        return view
    }
}
