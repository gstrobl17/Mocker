//
//  GodfatherPresenter.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

@MainActor
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
                 contentPresenter: NSViewController,
                 compare: NSViewController) {
        view?.install(projectFileSelector: projectFileSelector,
                      sourceFileSelector: sourceFileSelector,
                      sourceFileFilter: sourceFileFilter,
                      protocolSelector: protocolSelector,
                      mockFileParameters: mockFileParameters,
                      contentPresenter: contentPresenter,
                      compare: compare)
    }

    func reportError(_ error: any Error) {
        view?.reportError(error)
    }
    
    func reportErrorCondition(with messageText: String, and informativeText: String) {
        view?.reportErrorCondition(with: messageText, and: informativeText)
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

    func mockCopiedToClipboard() {
        view?.mockCopiedToClipboard()
    }
    
}
