//
//  SwiftFileSelectorPresenter.swift
//  Mocker
//
//  Created Greg on 1/2/25.
//

import AppKit

@MainActor
class SwiftFileSelectorPresenter: NSObject {

    weak private var view: (any SwiftFileSelectorViewProtocol)?
    var interactor: (any SwiftFileSelectorInteractorInputProtocol)?
    let router: any SwiftFileSelectorWireframeProtocol
    private let openPanelFactory: any OpenPanelFactory
    internal var openPanel: (any OpenPanel)?
    private(set) var userDefaults: any KeyValueStoring

    init(
        interface: any SwiftFileSelectorViewProtocol,
        interactor: (any SwiftFileSelectorInteractorInputProtocol)?,
        router: any SwiftFileSelectorWireframeProtocol,
        openPanelFactory: any OpenPanelFactory,
        userDefaults: any KeyValueStoring
    ) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.openPanelFactory = openPanelFactory
        self.userDefaults = userDefaults
    }

    internal func handleOpenPanelResponse(_ result: NSApplication.ModalResponse) {
        if result == NSApplication.ModalResponse.OK, let selection = openPanel?.url {
            userDefaults.lastDirectoryOfSelectedProject = openPanel?.directoryURL
// This may need to change
            userDefaults.lastDirectoryOfSelectedFileToCompare = openPanel?.directoryURL // Reset to project just loaded
            self.interactor?.swiftFileSelected(selection)
        }
    }
    
}

extension SwiftFileSelectorPresenter: SwiftFileSelectorPresenterProtocol {
    
    func setURL(_ url: URL) {
        interactor?.setURL(url)
    }
    
    func selectPressed() {
        var openPanel = openPanelFactory.create(delegate: self)
        openPanel.directoryURL = userDefaults.lastDirectoryOfSelectedProject
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.message = "Select Swift File to Open"
        self.openPanel = openPanel
        view?.openModalSheet(with: openPanel, completionHandler: handleOpenPanelResponse)
    }
    
    func reloadPressed() {
        if let url = interactor?.url {
            view?.showSelectedFile(url)
        }
    }
    
    func canReloadProject() -> Bool {
        (interactor?.url != nil)
    }

    func viewHasLoaded() {
        interactor?.viewHasLoaded()
    }
    
}

extension SwiftFileSelectorPresenter: SwiftFileSelectorInteractorOutputProtocol {
    func showSelectedFile(_ url: URL) {
        view?.showSelectedFile(url)
    }
    
}

extension SwiftFileSelectorPresenter: NSOpenSavePanelDelegate {
    func panel(_ sender: Any, shouldEnable url: URL) -> Bool {
        url.isSwiftFile || url.isDirectory
    }
}
