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

protocol GodfatherInterfaceProtocol: AnyObject {
    func selectProject()
    func canReloadProject() -> Bool
    func reloadProject()
    func displayChoice(_ choice: DisplayChoice)
    func copyMockToClipboard()
    func openRecentProjectFile(_ url: URL)
}

// MARK: Wireframe -
protocol GodfatherWireframeProtocol: AnyObject {
    var view: (GodfatherViewProtocol & GodfatherInterfaceProtocol)? { get }
    
    // swiftlint:disable function_parameter_count
    static func createModule(
        viewController: ViewController,
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
        destinationGroupSelectorRouterType: DestinationGroupSelectorWireframeProtocol.Type,
        filteringHandler: AsyncFilteringHandler,
        recentDocumentManager: RecentDocumentManaging,
        documentController: DocumentControlling
    ) -> (GodfatherViewProtocol & GodfatherInterfaceProtocol)
    // swiftlint:enable function_parameter_count
}

// MARK: Presenter -
protocol GodfatherPresenterProtocol: AnyObject {

    var interactor: GodfatherInteractorInputProtocol? { get set }

    func selectProject()
    func canReloadProject() -> Bool
    func reloadProject()
    func displayChoice(_ choice: DisplayChoice)
    func copyMockToClipboard()
    func viewHasAppeared()
    func openRecentProjectFile(_ url: URL)
}

// MARK: Interactor -
protocol GodfatherInteractorOutputProtocol: AnyObject {
    
    //swiftlint:disable:next function_parameter_count
    func install(projectFileSelector: NSViewController,
                 sourceFileSelector: NSViewController,
                 sourceFileFilter: NSViewController,
                 protocolSelector: NSViewController,
                 mockFileParameters: NSViewController,
                 contentPresenter: NSViewController)

    func reportError(_ error: Error)
    func reportErrorCondition(with messageText: String, and informativeText: String)
    func showAsBusy(with message: String)
    func clearBusyMessage()
    func canChooseDisplay(_ flag: Bool)
    func setDisplayChoice(_ choice: DisplayChoice)
    /* Interactor -> Presenter */
}

protocol GodfatherInteractorInputProtocol: AnyObject {

    var presenter: GodfatherInteractorOutputProtocol? { get set }
    
    var userDefaults: KeyValueStoring { get }
    var fileManager: FileManaging { get }
    var currentProject: Project? { get }
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
protocol GodfatherViewProtocol: AnyObject {

    var presenter: GodfatherPresenterProtocol? { get set }

    //swiftlint:disable:next function_parameter_count
    func install(projectFileSelector: NSViewController,
                 sourceFileSelector: NSViewController,
                 sourceFileFilter: NSViewController,
                 protocolSelector: NSViewController,
                 mockFileParameters: NSViewController,
                 contentPresenter: NSViewController)
    
    func display(_ alert: NSAlert)
    func displayActivityIndicator(_ message: String)
    func closeActivityIndicator()
    func enableDisplayChoice(_ flag: Bool)
    func setDisplayChoice(_ choice: DisplayChoice)
    func displayAsSheet(_ viewController: NSViewController)
    /* Presenter -> ViewController */
    
    func viewHasAppeared()
}
