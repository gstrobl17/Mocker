//
//  ComparePresenter.swift
//  Mocker
//
//  Created Greg Strobl on 9/27/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import AppKit

@MainActor
class ComparePresenter: NSObject {

    weak internal var view: (any CompareViewProtocol)?
    var interactor: (any CompareInteractorInputProtocol)?
    let router: any CompareWireframeProtocol
    private let openPanelFactory: any OpenPanelFactory
    internal var openPanel: (any OpenPanel)?
    private(set) var userDefaults: any KeyValueStoring

    init(
        view: (any CompareViewProtocol),
        interactor: (any CompareInteractorInputProtocol)?,
        router: any CompareWireframeProtocol,
        openPanelFactory: any OpenPanelFactory,
        userDefaults: any KeyValueStoring
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.openPanelFactory = openPanelFactory
        self.userDefaults = userDefaults
    }

    internal func handleOpenPanelResponse(_ result: NSApplication.ModalResponse) {
        if result == NSApplication.ModalResponse.OK, let selection = openPanel?.url {
            userDefaults.lastDirectoryOfSelectedFileToCompare = openPanel?.directoryURL
            interactor?.fileToCompareSelected(selection)
        }
    }

}

extension ComparePresenter: ComparePresenterProtocol {
    
    func compareButtonPressed() {
        var openPanel = openPanelFactory.create(delegate: self)
        openPanel.directoryURL = userDefaults.lastDirectoryOfSelectedFileToCompare
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.message = "Select Swift File to Compare Mock Against"
        self.openPanel = openPanel
        view?.openModalSheet(with: openPanel, completionHandler: handleOpenPanelResponse)
    }

}

extension ComparePresenter: CompareInteractorOutputProtocol {
    
    func showButton(_ flag: Bool) {
        view?.showButton(flag)
    }
    
    func reportErrorCondition(with messageText: String, and informativeText: String) {
        view?.reportErrorCondition(with: messageText, and: informativeText)
    }

    func mockCodeForCompare() -> String {
        view?.mockCodeForCompare() ?? ""
    }

}

extension ComparePresenter: NSOpenSavePanelDelegate {
    func panel(_ sender: Any, shouldEnable url: URL) -> Bool {
        url.isSwiftFile || url.isDirectory
    }
}
