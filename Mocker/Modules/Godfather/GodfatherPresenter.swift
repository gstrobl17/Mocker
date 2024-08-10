//
//  GodfatherPresenter.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

class GodfatherPresenter {

    weak private var view: (any GodfatherViewProtocol)?
    var interactor: (any GodfatherInteractorInputProtocol)?
    let router: any GodfatherWireframeProtocol
    
    let userDefaults: any KeyValueStoring

    init(interface: any GodfatherViewProtocol,
         interactor: (any GodfatherInteractorInputProtocol)?,
         router: any GodfatherWireframeProtocol,
         userDefaults: any KeyValueStoring) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.userDefaults = userDefaults
    }

}

extension GodfatherPresenter: GodfatherPresenterProtocol {
    
    func selectProject() {
        interactor?.selectProject()
    }
    
    func canReloadProject() -> Bool {
        interactor?.canReloadProject() ?? false
    }
    
    func reloadProject() {
        interactor?.reloadProject()
    }

    func displayChoice(_ choice: DisplayChoice) {
        interactor?.displayChoice(choice)
    }

    func copyMockToClipboard() {
        interactor?.copyMockToClipboard()
    }

    func viewHasAppeared() {
        interactor?.viewHasAppeared()
    }
    
    func openRecentProjectFile(_ url: URL) {
        interactor?.openRecentProjectFile(url)
    }

}

extension GodfatherPresenter: GodfatherInteractorOutputProtocol {
    
    //swiftlint:disable:next function_parameter_count
    func install(projectFileSelector: NSViewController,
                 sourceFileSelector: NSViewController,
                 sourceFileFilter: NSViewController,
                 protocolSelector: NSViewController,
                 mockFileParameters: NSViewController,
                 contentPresenter: NSViewController) {
        view?.install(projectFileSelector: projectFileSelector,
                      sourceFileSelector: sourceFileSelector,
                      sourceFileFilter: sourceFileFilter,
                      protocolSelector: protocolSelector,
                      mockFileParameters: mockFileParameters,
                      contentPresenter: contentPresenter)
    }

    func reportError(_ error: any Error) {
        let alert = NSAlert(error: error)
        view?.display(alert)
    }
    
    func reportErrorCondition(with messageText: String, and informativeText: String) {
        let alert = NSAlert()
        alert.messageText = messageText
        alert.informativeText = informativeText
        alert.alertStyle = .critical
        alert.addButton(withTitle: "Continue")
        view?.display(alert)
    }
    
    func showAsBusy(with message: String) {
        view?.displayActivityIndicator(message)
    }
    
    func clearBusyMessage() {
        view?.closeActivityIndicator()
    }

    func canChooseDisplay(_ flag: Bool) {
        view?.enableDisplayChoice(flag)
    }
    
    func setDisplayChoice(_ choice: DisplayChoice) {
        view?.setDisplayChoice(choice)
    }

}
