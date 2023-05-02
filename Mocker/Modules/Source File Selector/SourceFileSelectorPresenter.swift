//
//  SourceFileSelectorPresenter.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

class SourceFileSelectorPresenter {

    weak private var view: SourceFileSelectorViewProtocol?
    var interactor: SourceFileSelectorInteractorInputProtocol?
    let router: SourceFileSelectorWireframeProtocol

    init(interface: SourceFileSelectorViewProtocol, interactor: SourceFileSelectorInteractorInputProtocol?, router: SourceFileSelectorWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}

extension SourceFileSelectorPresenter: SourceFileSelectorPresenterProtocol {
    
    func viewHasLoaded() {
        interactor?.viewHasLoaded()
    }
    
}

extension SourceFileSelectorPresenter: SourceFileSelectorInteractorOutputProtocol {
}
