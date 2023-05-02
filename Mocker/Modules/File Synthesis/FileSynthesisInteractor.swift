//
//  FileSynthesisInteractor.swift
//  Mocker
//
//  Created Greg on 3/2/18.
//

import AppKit
import XcodeEditor

class FileSynthesisInteractor {

    weak var presenter: FileSynthesisInteractorOutputProtocol? {
        didSet {
            setupUI()
        }
    }
    
    let mockName: String
    let mockCode: String
    let project: Project
    let fileSynthesizer: FileSynthesizing
    private var userDefaults: KeyValueStoring
    private let fileManager: FileManaging
    let destinationGroupSelectorView: NSViewController
    let destinationGroupSelectorInterface: DestinationGroupSelectorInterfaceProtocol
    internal var group: XCGroup? {
        didSet {
            presenter?.groupWasSelected()
        }
    }
    private(set) var addNewFileToProject = true

    init(mockName: String,
         mockCode: String,
         project: Project,
         fileSynthesizer: FileSynthesizing,
         userDefaults: KeyValueStoring,
         fileManager: FileManaging,
         destinationGroupSelectorRouterType: DestinationGroupSelectorWireframeProtocol.Type) {
        
        self.mockName = mockName
        self.mockCode = mockCode
        self.project = project
        self.fileSynthesizer = fileSynthesizer
        self.userDefaults = userDefaults
        self.fileManager = fileManager
        let destinationGroupSelectorModule = destinationGroupSelectorRouterType.createModule(userDefaults: userDefaults, fileManager: fileManager)
        self.destinationGroupSelectorView = destinationGroupSelectorModule.view
        self.destinationGroupSelectorInterface = destinationGroupSelectorModule.interface
        addNewFileToProject = userDefaults.addNewFileToProject
        
        self.destinationGroupSelectorInterface.delegate = self
    }
    
    private func setupUI() {
        guard let presenter = presenter else { return }
        presenter.install(destinationGroupSelector: destinationGroupSelectorView)
        let result = project.traverse(filteredBy: "", monitoredBy: NeverCancelledMonitor())
        destinationGroupSelectorInterface.present(tree: result.groupTree, for: project)
        setUIState()
    }

    private func setUIState() {
        presenter?.groupWasSelected()
        presenter?.setAddNewFileToProjectCheckbox(addNewFileToProject)
    }
}

extension FileSynthesisInteractor: FileSynthesisInteractorInputProtocol {
    
    func generateMockFile() {
        guard let group = group else { return }
        do {
            fileSynthesizer.delegate = self
            let result = try fileSynthesizer.synthesize(file: mockName,
                                                        with: mockCode,
                                                        in: group,
                                                        containedIn: project,
                                                        using: fileManager,
                                                        addNewFileToProject: addNewFileToProject)
            if result == .fileCreated {
                presenter?.mockFileWasCreated()
            }
        } catch let error {
            presenter?.mockFileCreationFailed(error)
        }
    }

    func addNewFileToProjectChanged(_ newValue: Bool) {
        addNewFileToProject = newValue
        userDefaults.addNewFileToProject = newValue
    }

    func viewHasLoaded() {
        setupUI()
    }
    
}

extension FileSynthesisInteractor: FileSynthesizingDelegate {
    
    func fileSynthesizerShouldOverwrite(_ fileSynthesizer: FileSynthesizing, existingFile name: String) -> Bool {
        guard let presenter = presenter else { return false }
        return presenter.shouldOverwrite(existingFile: name)
    }
    
}

extension FileSynthesisInteractor: DestinationGroupSelectorInterfaceDelegate {
    
    func destinationGroupSelector(_ interface: DestinationGroupSelectorInterfaceProtocol, groupSelected treeNode: TreeNode) {
        if let group = treeNode.groupMember as? XCGroup {
            self.group = group
        }
    }
    
}

