//
//  SourceFileSelectorPresenter.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

class SourceFileSelectorPresenter {

    weak private var view: (any SourceFileSelectorViewProtocol)?
    var interactor: (any SourceFileSelectorInteractorInputProtocol)?
    let router: any SourceFileSelectorWireframeProtocol

    init(interface: any SourceFileSelectorViewProtocol, interactor: (any SourceFileSelectorInteractorInputProtocol)?, router: any SourceFileSelectorWireframeProtocol) {
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
