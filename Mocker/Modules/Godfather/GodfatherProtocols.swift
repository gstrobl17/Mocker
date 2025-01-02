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
    func selectSwiftFile()
    func displayChoice(_ choice: DisplayChoice)
    func copyMockToClipboard()
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
        swiftFileSelectorRouterType: any SwiftFileSelectorWireframeProtocol.Type,
        sourceFileSelectorRouterType: any SourceFileSelectorWireframeProtocol.Type,
        protocolSelectorRouterType: any ProtocolSelectorWireframeProtocol.Type,
        mockFileParametersRouterType: any MockFileParametersWireframeProtocol.Type,
        contentPresenterRouterType: any ContentPresenterWireframeProtocol.Type,
        compareRouterType: any CompareWireframeProtocol.Type,
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

    func selectSwiftFile()
    func displayChoice(_ choice: DisplayChoice)
    func copyMockToClipboard()
    func viewHasAppeared()
}

// MARK: Interactor -
@MainActor
protocol GodfatherInteractorOutputProtocol: AnyObject {
    
    //swiftlint:disable:next function_parameter_count
    func install(swiftFileSelector: NSViewController,
                 sourceFileSelector: NSViewController,
                 protocolSelector: NSViewController,
                 mockFileParameters: NSViewController,
                 contentPresenter: NSViewController,
                 compare: NSViewController)

    func reportError(_ error: any Error)
    func reportErrorCondition(with messageText: String, and informativeText: String)
    func showAsBusy(with message: String)
    func clearBusyMessage()
    func canChooseDisplay(_ flag: Bool)
    func setDisplayChoice(_ choice: DisplayChoice)
    func mockCopiedToClipboard()
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

    func selectSwiftFile()
    func viewHasAppeared()
    func displayChoice(_ choice: DisplayChoice)
    func copyMockToClipboard()
    /* Presenter -> Interactor */
}

// MARK: View -
@MainActor
protocol GodfatherViewProtocol: AnyObject {

    var presenter: (any GodfatherPresenterProtocol)? { get set }

    //swiftlint:disable:next function_parameter_count
    func install(swiftFileSelector: NSViewController,
                 sourceFileSelector: NSViewController,
                 protocolSelector: NSViewController,
                 mockFileParameters: NSViewController,
                 contentPresenter: NSViewController,
                 compare: NSViewController)
    
    func reportError(_ error: any Error)
    func reportErrorCondition(with messageText: String, and informativeText: String)
    func displayActivityIndicator(_ message: String)
    func closeActivityIndicator()
    func enableDisplayChoice(_ flag: Bool)
    func setDisplayChoice(_ choice: DisplayChoice)
    func displayAsSheet(_ viewController: NSViewController)
    func mockCopiedToClipboard()
    /* Presenter -> ViewController */
    
    func viewHasAppeared()
}
