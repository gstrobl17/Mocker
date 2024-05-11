//
//  GodfatherInteractor.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit
import XcodeEditor
import SwiftSyntax
import SwiftSyntaxParser

class GodfatherInteractor {

    weak var presenter: GodfatherInteractorOutputProtocol? {
        didSet {
            presenter?.install(projectFileSelector: projectFileSelector,
                               sourceFileSelector: sourceFileSelector,
                               sourceFileFilter: sourceFileFilterModule.view,
                               protocolSelector: protocolSelector,
                               mockFileParameters: mockFileParameters,
                               contentPresenter: contentPresenter)
            evaluateIfDisplayChoiceIsAvailable()
        }
    }
    
    private var theViewHasAppeared = false
    private(set) var userDefaults: KeyValueStoring
    let fileManager: FileManaging
    let projectFactory: ProjectFactory
    let mockGeneratorFactory: MockGeneratorFactory
    let projectFileSelector: NSViewController & ProjectFileSelectorInterfaceProtocol
    let sourceFileSelector: NSViewController & SourceFileSelectorInterfaceProtocol
    let sourceFileFilterModule: (view: NSViewController, interface: FilterInterfaceProtocol)
    let protocolSelector: NSViewController & ProtocolSelectorInterfaceProtocol
    let mockFileParameters: NSViewController & MockFileParametersInterfaceProtocol
    let contentPresenter: NSViewController & ContentPresenterInterfaceProtocol
    let filteringHandler: AsyncFilteringHandler
    let recentDocumentManager: RecentDocumentManaging
    let documentController: DocumentControlling
    internal var currentProject: Project?
    private(set) var targetOfCurrentSourceFile: XCTarget? {
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
    private(set) var mockCode = "" {
        didSet {
            contentPresenter.present(text: mockCode)
            presenter?.setDisplayChoice(.mock)
            evaluateIfDisplayChoiceIsAvailable()
        }
    }

    init(
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
        filteringHandler: AsyncFilteringHandler,
        recentDocumentManager: RecentDocumentManaging,
        documentController: DocumentControlling
    ) {
        
        self.userDefaults = userDefaults
        self.fileManager = fileManager
        self.projectFactory = projectFactory
        self.mockGeneratorFactory = mockGeneratorFactory
        projectFileSelector = projectFileSelectorRouterType.createModule(openPanelFactory: openPanelFactory)
        sourceFileSelector = sourceFileSelectorRouterType.createModule()
        sourceFileFilterModule = sourceFileFilterRouterType.createModule(userDefaults: userDefaults)
        protocolSelector = protocolSelectorRouterType.createModule()
        mockFileParameters = mockFileParametersRouterType.createModule(userDefaults: userDefaults)
        contentPresenter = contentPresenterRouterType.createModule()
        self.filteringHandler = filteringHandler
        self.recentDocumentManager = recentDocumentManager
        self.documentController = documentController

        projectFileSelector.delegate = self
        sourceFileSelector.delegate = self
        sourceFileFilterModule.interface.delegate = self
        protocolSelector.delegate = self
        mockFileParameters.delegate = self
    }
    
    private func openProjectFile(_ url: URL) {
        
        userDefaults.projectFilePath = nil

        presenter?.showAsBusy(with: "Loading \(url.lastPathComponent)")
        defer {
            presenter?.clearBusyMessage()
        }
        
        if let project = projectFactory.createProject(for: url.path) {
            currentProject = project
            userDefaults.projectFilePath = url.path
            renderFilteredSourceFileTree()
            mockFileParameters.setup(for: project)
            mockFileParameters.clearProtocol()
            
            recentDocumentManager.add(url)
            documentController.noteNewRecentDocumentURL(url)
        } else {
            reportProjectLoadFailure()
        }

    }
    
    private func renderFilteredSourceFileTree() {
        guard let currentProject = currentProject else { return }
        let filter = userDefaults.sourceFileFilterValue ?? ""
        filteringHandler.performFiltering(on: currentProject, with: filter) { [weak self] result in
            DispatchQueue.main.async {
                guard let strongSelf = self, let project = strongSelf.currentProject else { return }
                strongSelf.sourceFileSelector.present(tree: result.fileTree, for: project)
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
    
    private func evaluateIfDisplayChoiceIsAvailable() {
        var canChooseDisplay = false
        
        if currentProject != nil && currentSourceFile != nil && currentProtocolDeclaration != nil && !mockCode.isEmpty {
            canChooseDisplay = true
        }

        presenter?.canChooseDisplay(canChooseDisplay)
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
    
    func openRecentProjectFile(_ url: URL) {
        openProjectFile(url)
        projectFileSelector.renderURLOfSelectedFile(url)
    }

}

extension GodfatherInteractor: ProjectFileSelectorInterfaceDelegate {
    
    func projectFileSelector(_ view: NSViewController & ProjectFileSelectorInterfaceProtocol, fileSelected url: URL) {
        openProjectFile(url)
    }
    
}

extension GodfatherInteractor: SourceFileSelectorInterfaceDelegate {
    
    func sourceFileSelector(_ view: (NSViewController & SourceFileSelectorInterfaceProtocol), fileSelected treeNode: TreeNode) {

        targetOfCurrentSourceFile = nil
        currentSourceFileCode = ""
        currentSourceFile = nil
        mockFileParameters.clearProtocol()
        mockCode = ""

        if let currentProject = currentProject, let fileURL = treeNode.groupMember.url(in: currentProject) {
            
            // Try to find the target of the selected file
            if let target = treeNode.groupMember.target(in: currentProject) {
                targetOfCurrentSourceFile = target
            }
  
            // Parse the source file
            do {
                currentSourceFileCode = try String(contentsOf: fileURL)
                let sourceFileSyntax = try SyntaxParser.parse(fileURL)
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
    
    func protocolSelector(_ view: (NSViewController & ProtocolSelectorInterfaceProtocol), protocolSelected protocolDeclaration: ProtocolDeclSyntax) {
        currentProtocolDeclaration = protocolDeclaration
        mockFileParameters.setup(for: protocolDeclaration)
    }
    
}

extension GodfatherInteractor: MockFileParametersInterfaceDelegate {
    
    func mockFileParameters(_ view: (NSViewController & MockFileParametersInterfaceProtocol),   //swiftlint:disable:this function_parameter_count
                            mockName: String,
                            includeHeader: Bool,
                            includeTestableImport: Bool,
                            swiftlintAware: Bool,
                            testableTargetName: String,
                            trackPropertyActivity: Bool) {
        guard let currentProject = currentProject else { return }
        guard let currentSourceFile = currentSourceFile else { return }
        guard let currentProtocolDeclaration = currentProtocolDeclaration else { return }
        guard !mockName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            self.mockName = ""
            mockCode = ""
            return
        }
        
        self.mockName = mockName
        let parameters = MockGeneratorParameters(project: currentProject,
                                                 imports: currentSourceFile.imports,
                                                 protocolDeclaration: currentProtocolDeclaration,
                                                 mockName: mockName, 
                                                 includeHeader: includeHeader,
                                                 includeTestableImport: includeTestableImport,
                                                 testableTargetName: testableTargetName,
                                                 trackPropertyActivity: trackPropertyActivity)
        let generator = mockGeneratorFactory.createMockGenerator(swiftlintAware: swiftlintAware)
        mockCode = generator.generateMockCode(for: parameters)
    }
    
}

extension GodfatherInteractor: FilterInterfaceDelegate {
    
    func filter(_ filterInterface: FilterInterfaceProtocol, newValue: String) {
        renderFilteredSourceFileTree()
    }
    
}
