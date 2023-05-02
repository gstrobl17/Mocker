//
//  FileSynthesisPresenter.swift
//  Mocker
//
//  Created Greg on 3/2/18.
//

import AppKit

class FileSynthesisPresenter {

    weak internal var view: FileSynthesisViewProtocol?
    var interactor: FileSynthesisInteractorInputProtocol?
    let router: FileSynthesisWireframeProtocol

    init(interface: FileSynthesisViewProtocol, interactor: FileSynthesisInteractorInputProtocol?, router: FileSynthesisWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    private func setState() {
        guard let view = view else { return }
        let enableCreateButton = (interactor?.group != nil)
        view.enableCreateButton(enableCreateButton)
    }

}

extension FileSynthesisPresenter: FileSynthesisPresenterProtocol {
    
    func createPressed() {
        interactor?.generateMockFile()
    }

    func addNewFileToProjectChanged(_ newValue: Bool) {
        interactor?.addNewFileToProjectChanged(newValue)
    }

    func viewHasLoaded() {
        interactor?.viewHasLoaded()
    }

}

extension FileSynthesisPresenter: FileSynthesisInteractorOutputProtocol {

    func install(destinationGroupSelector: NSViewController) {
        view?.install(destinationGroupSelector: destinationGroupSelector)
    }
    
    func groupWasSelected() {
        setState()
    }

    func setAddNewFileToProjectCheckbox(_ flag: Bool) {
        view?.setAddNewFileToProjectCheckbox(flag)
    }
    
    func mockFileWasCreated() {
        view?.close()
    }

    func mockFileCreationFailed(_ error: Error) {
        let alert = NSAlert(error: error)
        view?.display(alert)
        view?.close()
    }

    func shouldOverwrite(existingFile name: String) -> Bool {
        guard let view = view else { return false }
        return view.shouldOverwrite(existingFile: name)
    }
    
}
