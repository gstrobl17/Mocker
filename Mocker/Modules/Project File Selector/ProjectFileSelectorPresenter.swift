//
//  ProjectFileSelectorPresenter.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

@MainActor
class ProjectFileSelectorPresenter: NSObject {

    weak private var view: (any ProjectFileSelectorViewProtocol)?
    var interactor: (any ProjectFileSelectorInteractorInputProtocol)?
    let router: any ProjectFileSelectorWireframeProtocol
    private let openPanelFactory: any OpenPanelFactory
    internal var openPanel: (any OpenPanel)?

    init(interface: any ProjectFileSelectorViewProtocol, interactor: (any ProjectFileSelectorInteractorInputProtocol)?, router: any ProjectFileSelectorWireframeProtocol, openPanelFactory: any OpenPanelFactory) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.openPanelFactory = openPanelFactory
    }

    internal func handleOpenPanelResponse(_ result: NSApplication.ModalResponse) {
        if result == NSApplication.ModalResponse.OK, let selection = openPanel?.url {
            self.interactor?.projectFileSelected(selection)
        }
    }
    
}

extension ProjectFileSelectorPresenter: ProjectFileSelectorPresenterProtocol {
    
    func setURL(_ url: URL) {
        interactor?.setURL(url)
    }
    
    func selectPressed() {
        var openPanel = openPanelFactory.create(delegate: self)
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
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

extension ProjectFileSelectorPresenter: ProjectFileSelectorInteractorOutputProtocol {
    func showSelectedFile(_ url: URL) {
        view?.showSelectedFile(url)
    }
    
}

extension ProjectFileSelectorPresenter: NSOpenSavePanelDelegate {
    func panel(_ sender: Any, shouldEnable url: URL) -> Bool {
        url.isXcodeProjectFile || url.isSwiftPackageManifestFile || url.isDirectory
    }
}
