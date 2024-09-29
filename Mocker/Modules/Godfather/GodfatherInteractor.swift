//
//  GodfatherInteractor.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit
import SwiftSyntax
import SwiftParser

@MainActor
class GodfatherInteractor {

    weak var presenter: (any GodfatherInteractorOutputProtocol)? {
        didSet {
            presenter?.install(projectFileSelector: projectFileSelector,
                               sourceFileSelector: sourceFileSelector,
                               sourceFileFilter: sourceFileFilterModule.view,
                               protocolSelector: protocolSelector,
                               mockFileParameters: mockFileParameters,
                               contentPresenter: contentPresenter,
                               compare: compare)
            evaluateIfDisplayChoiceIsAvailable()
        }
    }
    
    private var theViewHasAppeared = false
    private(set) var userDefaults: any KeyValueStoring
    let fileManager: any FileManaging
    let dataSourceFactory: any SourceFileDataSourceCreating
    let mockGeneratorFactory: any MockGeneratorFactory
    let projectFileSelector: any NSViewController & ProjectFileSelectorInterfaceProtocol
    let sourceFileSelector: any NSViewController & SourceFileSelectorInterfaceProtocol
    let sourceFileFilterModule: (view: NSViewController, interface: any FilterInterfaceProtocol)
    let protocolSelector: any NSViewController & ProtocolSelectorInterfaceProtocol
    let mockFileParameters: any NSViewController & MockFileParametersInterfaceProtocol
    let contentPresenter: any NSViewController & ContentPresenterInterfaceProtocol
    let compare: any NSViewController & CompareInterfaceProtocol
    let filteringHandler: any AsyncFilteringHandler
    let recentDocumentManager: any RecentDocumentManaging
    let documentController: any DocumentControlling
    let pasteboard: any Pasteboard
    let stringFromURLContentsFactory: any StringFromURLContentsCreating
    internal var currentDataSource: (any SourceFileDataSource)?
    private(set) var targetOfCurrentSourceFile: String? {
        didSet {
            if let target = targetOfCurrentSourceFile {
                mockFileParameters.setup(for: target)
            }
        }
    }
    internal var currentSourceFileCode = ""
    internal var currentSourceFile: SourceFileInformation? {
        didSet {
            let protocols = currentSourceFile?.protocols ?? []
            protocolSelector.present(protocols: protocols)
        }
    }
    internal var currentProtocolDeclaration: ProtocolDeclSyntax?
    private(set) var mockName = ""
    var mockCode = "" {
        didSet {
            contentPresenter.present(text: mockCode)
            presenter?.setDisplayChoice(.mock)
            evaluateIfDisplayChoiceIsAvailable()
        }
    }

    init(
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
        compareRouterType: any CompareWireframeProtocol.Type,
        filteringHandler: any AsyncFilteringHandler,
        recentDocumentManager: any RecentDocumentManaging,
        documentController: any DocumentControlling,
        pasteboard: any Pasteboard = NSPasteboard.general,
        stringFromURLContentsFactory: any StringFromURLContentsCreating = StringFromURLContentsFactory()
    ) {
        
        self.userDefaults = userDefaults
        self.fileManager = fileManager
        self.dataSourceFactory = dataSourceFactory
        self.mockGeneratorFactory = mockGeneratorFactory
        projectFileSelector = projectFileSelectorRouterType.createModule(openPanelFactory: openPanelFactory, userDefaults: userDefaults)
        sourceFileSelector = sourceFileSelectorRouterType.createModule()
        sourceFileFilterModule = sourceFileFilterRouterType.createModule(userDefaults: userDefaults)
        protocolSelector = protocolSelectorRouterType.createModule()
        mockFileParameters = mockFileParametersRouterType.createModule(userDefaults: userDefaults)
        contentPresenter = contentPresenterRouterType.createModule()
        compare = compareRouterType.createModule(openPanelFactory: openPanelFactory, userDefaults: userDefaults)
        self.filteringHandler = filteringHandler
        self.recentDocumentManager = recentDocumentManager
        self.documentController = documentController
        self.pasteboard = pasteboard
        self.stringFromURLContentsFactory = stringFromURLContentsFactory

        projectFileSelector.delegate = self
        sourceFileSelector.delegate = self
        sourceFileFilterModule.interface.delegate = self
        protocolSelector.delegate = self
        mockFileParameters.delegate = self
        compare.delegate = self
    }
    
    private func openProjectFile(_ url: URL) {
        
        userDefaults.projectFilePath = nil

        presenter?.showAsBusy(with: "Loading \(url.lastPathComponent)")
        defer {
            presenter?.clearBusyMessage()
        }
        
        do {
            if let dataSource = try dataSourceFactory.createDataSource(for: url) {
                currentDataSource = dataSource
                userDefaults.projectFilePath = url.path
                renderFilteredSourceFileTree()
                mockFileParameters.setup(for: dataSource)
                mockFileParameters.clearProtocol()
                
                recentDocumentManager.add(url)
                documentController.noteNewRecentDocumentURL(url)
            } else {
                reportProjectLoadFailure()
            }
        } catch {
            presenter?.reportError(error)
        }

    }
    
    private func renderFilteredSourceFileTree() {
        guard let currentDataSource else { return }
        let filter = userDefaults.sourceFileFilterValue ?? ""
        filteringHandler.performFiltering(on: currentDataSource, with: filter) { [weak self] result in
            guard let self, let dataSource = self.currentDataSource else { return }
            
            DispatchQueue.main.async { [dataSource, sourceFileSelector] in
                sourceFileSelector.present(tree: result, for: dataSource)
            }
        }
    }
    
    private func reportProjectLoadFailure() {
        presenter?.reportErrorCondition(with: "Project Load Failed", and: "Unable to load the selected project file")
    }
    
    private func tryToOpenLastProject() {
        if let projectFilePath = userDefaults.projectFilePath, fileManager.fileExists(atPath: projectFilePath) {
            let url = URL(fileURLWithPath: projectFilePath)
            projectFileSelector.showSelectedFile(url)
        }
    }
    
    internal func evaluateIfDisplayChoiceIsAvailable() {
        var canChooseDisplay = false
        
        if currentDataSource != nil && currentSourceFile != nil && currentProtocolDeclaration != nil && !mockCode.isEmpty {
            canChooseDisplay = true
        }

        presenter?.canChooseDisplay(canChooseDisplay)
        compare.enableCompare(canChooseDisplay)
    }
}

extension GodfatherInteractor: GodfatherInteractorInputProtocol {
    
    func selectProject() {
        projectFileSelector.selectProject()
    }

    func canReloadProject() -> Bool {
        projectFileSelector.canReloadProject()
    }
    
    func reloadProject() {
        projectFileSelector.reloadProject()
    }

    func viewHasAppeared() {
        // On the first time the view is opened, try to open the previous project
        if !theViewHasAppeared {
            theViewHasAppeared = true
            tryToOpenLastProject()
        }
    }
    
    func displayChoice(_ choice: DisplayChoice) {
        switch choice {
        case .mock:
            contentPresenter.present(text: mockCode)
        case .source:
            contentPresenter.present(text: currentSourceFileCode)
        }
    }
    
    func copyMockToClipboard() {
        pasteboard.declareTypes([.string], owner: nil)
        pasteboard.setString(mockCode, forType: .string)
        presenter?.mockCopiedToClipboard()
    }

    func openRecentProjectFile(_ url: URL) {
        openProjectFile(url)
        projectFileSelector.renderURLOfSelectedFile(url)
    }

}

extension GodfatherInteractor: ProjectFileSelectorInterfaceDelegate {
    
    func projectFileSelector(_ view: any NSViewController & ProjectFileSelectorInterfaceProtocol, fileSelected url: URL) {
        openProjectFile(url)
    }
    
}

extension GodfatherInteractor: SourceFileSelectorInterfaceDelegate {
    
    func sourceFileSelector(_ view: any (NSViewController & SourceFileSelectorInterfaceProtocol), fileSelected treeNode: SendableTreeNode) {

        targetOfCurrentSourceFile = nil
        currentSourceFileCode = ""
        currentSourceFile = nil
        mockFileParameters.clearProtocol()
        mockCode = ""

        if let fileURL = treeNode.fileURL {
            targetOfCurrentSourceFile = treeNode.target
  
            // Parse the source file
            do {
                currentSourceFileCode = try stringFromURLContentsFactory.string(fromContentsOf: fileURL, encoding: .ascii)
                let sourceFileSyntax = Parser.parse(source: currentSourceFileCode)
                let sourceFileInformation = SourceFileInformation(viewMode: .sourceAccurate)
                sourceFileInformation.walk(sourceFileSyntax)
                currentSourceFile = sourceFileInformation
            } catch let error {
                print(error)
                presenter?.reportError(error)
            }
        }
    }
    
}

extension GodfatherInteractor: ProtocolSelectorInterfaceDelegate {
    
    func protocolSelector(_ view: any (NSViewController & ProtocolSelectorInterfaceProtocol), protocolSelected protocolDeclaration: ProtocolDeclSyntax) {
        currentProtocolDeclaration = protocolDeclaration
        mockFileParameters.setup(for: protocolDeclaration)
    }
    
}

extension GodfatherInteractor: MockFileParametersInterfaceDelegate {
    
    func mockFileParameters(_ view: any (NSViewController & MockFileParametersInterfaceProtocol),   //swiftlint:disable:this function_parameter_count
                            mockName: String,
                            includeHeader: Bool,
                            includeTestableImport: Bool,
                            testableTargetName: String,
                            trackPropertyActivity: Bool,
                            public: Bool) {
        guard let currentDataSource else { return }
        guard let currentSourceFile else { return }
        guard let currentProtocolDeclaration else { return }
        guard !mockName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            self.mockName = ""
            mockCode = ""
            return
        }
        
        self.mockName = mockName
        let parameters = MockGeneratorParameters(dataSource: currentDataSource,
                                                 imports: currentSourceFile.imports,
                                                 protocolDeclaration: currentProtocolDeclaration,
                                                 mockName: mockName, 
                                                 includeHeader: includeHeader,
                                                 includeTestableImport: includeTestableImport,
                                                 testableTargetName: testableTargetName,
                                                 trackPropertyActivity: trackPropertyActivity,
                                                 public: `public`)
        let generator = mockGeneratorFactory.createMockGenerator()
        mockCode = generator.generateMockCode(for: parameters)
    }
    
}

extension GodfatherInteractor: FilterInterfaceDelegate {
    
    func filter(_ filterInterface: any FilterInterfaceProtocol, newValue: String) {
        renderFilteredSourceFileTree()
    }
    
}

extension GodfatherInteractor: CompareInterfaceDelegate {
    
    func mockCodeForCompare(_ view: any NSViewController & CompareInterfaceProtocol) -> String {
        mockCode
    }
    
}
