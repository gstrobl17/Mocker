//
//  GodfatherProtocols.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

enum DisplayChoice: Int {
    case mock
    case source
}

@MainActor
protocol GodfatherInterfaceProtocol: AnyObject {
    func selectProject()
    func canReloadProject() -> Bool
    func reloadProject()
    func displayChoice(_ choice: DisplayChoice)
    func copyMockToClipboard()
    func openRecentProjectFile(_ url: URL)
}

// MARK: Wireframe -
@MainActor
protocol GodfatherWireframeProtocol: AnyObject {
    var view: (any GodfatherViewProtocol & GodfatherInterfaceProtocol)? { get }
    
    // swiftlint:disable function_parameter_count
    static func createModule(
        viewController: ViewController,
        userDefaults: any KeyValueStoring,
        fileManager: any FileManaging,
        dataSourceFactory: any SourceFileDataSourceCreating,
        mockGeneratorFactory: any MockGeneratorFactory,
        openPanelFactory: any OpenPanelFactory,
        projectFileSelectorRouterType: any ProjectFileSelectorWireframeProtocol.Type,
        sourceFileSelectorRouterType: any SourceFileSelectorWireframeProtocol.Type,
        sourceFileFilterRouterType: any FilterWireframeProtocol.Type,
        protocolSelectorRouterType: any ProtocolSelectorWireframeProtocol.Type,
        mockFileParametersRouterType: any MockFileParametersWireframeProtocol.Type,
        contentPresenterRouterType: any ContentPresenterWireframeProtocol.Type,
        filteringHandler: any AsyncFilteringHandler,
        recentDocumentManager: any RecentDocumentManaging,
        documentController: any DocumentControlling
    ) -> (any GodfatherViewProtocol & GodfatherInterfaceProtocol)
    // swiftlint:enable function_parameter_count
}

// MARK: Presenter -
@MainActor
protocol GodfatherPresenterProtocol: AnyObject {

    var interactor: (any GodfatherInteractorInputProtocol)? { get set }

    func selectProject()
    func canReloadProject() -> Bool
    func reloadProject()
    func displayChoice(_ choice: DisplayChoice)
    func copyMockToClipboard()
    func viewHasAppeared()
    func openRecentProjectFile(_ url: URL)
}

// MARK: Interactor -
@MainActor
protocol GodfatherInteractorOutputProtocol: AnyObject {
    
    //swiftlint:disable:next function_parameter_count
    func install(projectFileSelector: NSViewController,
                 sourceFileSelector: NSViewController,
                 sourceFileFilter: NSViewController,
                 protocolSelector: NSViewController,
                 mockFileParameters: NSViewController,
                 contentPresenter: NSViewController)

    func reportError(_ error: any Error)
    func reportErrorCondition(with messageText: String, and informativeText: String)
    func showAsBusy(with message: String)
    func clearBusyMessage()
    func canChooseDisplay(_ flag: Bool)
    func setDisplayChoice(_ choice: DisplayChoice)
    /* Interactor -> Presenter */
}

@MainActor
protocol GodfatherInteractorInputProtocol: AnyObject {

    var presenter: (any GodfatherInteractorOutputProtocol)? { get set }
    
    var userDefaults: any KeyValueStoring { get }
    var fileManager: any FileManaging { get }
    var currentDataSource: (any SourceFileDataSource)? { get }
    var mockName: String { get }
    var mockCode: String { get }

    func selectProject()
    func canReloadProject() -> Bool
    func reloadProject()
    func viewHasAppeared()
    func displayChoice(_ choice: DisplayChoice)
    func copyMockToClipboard()
    func openRecentProjectFile(_ url: URL)
    /* Presenter -> Interactor */
}

// MARK: View -
@MainActor
protocol GodfatherViewProtocol: AnyObject {

    var presenter: (any GodfatherPresenterProtocol)? { get set }

    //swiftlint:disable:next function_parameter_count
    func install(projectFileSelector: NSViewController,
                 sourceFileSelector: NSViewController,
                 sourceFileFilter: NSViewController,
                 protocolSelector: NSViewController,
                 mockFileParameters: NSViewController,
                 contentPresenter: NSViewController)
    
    func reportError(_ error: any Error)
    func reportErrorCondition(with messageText: String, and informativeText: String)
    func displayActivityIndicator(_ message: String)
    func closeActivityIndicator()
    func enableDisplayChoice(_ flag: Bool)
    func setDisplayChoice(_ choice: DisplayChoice)
    func displayAsSheet(_ viewController: NSViewController)
    /* Presenter -> ViewController */
    
    func viewHasAppeared()
}
