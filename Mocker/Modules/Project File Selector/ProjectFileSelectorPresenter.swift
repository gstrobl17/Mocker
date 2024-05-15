//
//  ProjectFileSelectorPresenter.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

class ProjectFileSelectorPresenter: NSObject {

    weak private var view: ProjectFileSelectorViewProtocol?
    var interactor: ProjectFileSelectorInteractorInputProtocol?
    let router: ProjectFileSelectorWireframeProtocol
    private let openPanelFactory: OpenPanelFactory
    internal var openPanel: OpenPanel?

    init(interface: ProjectFileSelectorViewProtocol, interactor: ProjectFileSelectorInteractorInputProtocol?, router: ProjectFileSelectorWireframeProtocol, openPanelFactory: OpenPanelFactory) {
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
