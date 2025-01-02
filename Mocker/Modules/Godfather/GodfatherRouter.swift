//
//  GodfatherRouter.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

@MainActor
class GodfatherRouter: GodfatherWireframeProtocol {

    weak var view: (any GodfatherViewProtocol & GodfatherInterfaceProtocol)?

    // swiftlint:disable:next function_parameter_count
    static func createModule(
        viewController: ViewController,
        userDefaults: any KeyValueStoring,
        fileManager: any FileManaging,
        dataSourceFactory: any SourceFileDataSourceCreating,
        mockGeneratorFactory: any MockGeneratorFactory,
        openPanelFactory: any OpenPanelFactory,
        swiftFileSelectorRouterType: any SwiftFileSelectorWireframeProtocol.Type,
        sourceFileSelectorRouterType: any SourceFileSelectorWireframeProtocol.Type,
        sourceFileFilterRouterType: any FilterWireframeProtocol.Type,
        protocolSelectorRouterType: any ProtocolSelectorWireframeProtocol.Type,
        mockFileParametersRouterType: any MockFileParametersWireframeProtocol.Type,
        contentPresenterRouterType: any ContentPresenterWireframeProtocol.Type,
        compareRouterType: any CompareWireframeProtocol.Type,
        filteringHandler: any AsyncFilteringHandler,
        recentDocumentManager: any RecentDocumentManaging,
        documentController: any DocumentControlling
    ) -> (any GodfatherViewProtocol & GodfatherInterfaceProtocol) {

        let view = GodfatherView(viewController: viewController)
        let interactor = GodfatherInteractor(
            userDefaults: userDefaults,
            fileManager: fileManager, 
            dataSourceFactory: dataSourceFactory,
            mockGeneratorFactory: mockGeneratorFactory,
            openPanelFactory: openPanelFactory,
            swiftFileSelectorRouterType: swiftFileSelectorRouterType,
            sourceFileSelectorRouterType: sourceFileSelectorRouterType,
            sourceFileFilterRouterType: sourceFileFilterRouterType,
            protocolSelectorRouterType: protocolSelectorRouterType,
            mockFileParametersRouterType: mockFileParametersRouterType,
            contentPresenterRouterType: contentPresenterRouterType,
            compareRouterType: compareRouterType,
            filteringHandler: filteringHandler,
            recentDocumentManager: recentDocumentManager,
            documentController: documentController
        )
        let router = GodfatherRouter()
        let presenter = GodfatherPresenter(interface: view,
                                           interactor: interactor,
                                           router: router,
                                           userDefaults: userDefaults)

        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view

        return view
    }
}
