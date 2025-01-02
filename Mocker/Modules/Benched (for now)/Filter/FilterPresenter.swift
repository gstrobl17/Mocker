//
//  FilterPresenter.swift
//  Mocker
//
//  Created Greg on 10/13/18.
//

import AppKit

class FilterPresenter {

    weak internal var view: (any FilterViewProtocol)?
    var interactor: (any FilterInteractorInputProtocol)?
    let router: any FilterWireframeProtocol

    init(interface: any FilterViewProtocol, interactor: (any FilterInteractorInputProtocol)?, router: any FilterWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}

extension FilterPresenter: FilterPresenterProtocol {
    
    func viewHasLoaded() {
        interactor?.viewHasLoaded()
    }
    
    func filterValueChanged(to value: String) {
        interactor?.filterValueChanged(to: value)
    }

}

extension FilterPresenter: FilterInteractorOutputProtocol {
    
    func setValue(_ value: String) {
        view?.setValue(value)
    }

}
