//
//  ProtocolSelectorPresenter.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

class ProtocolSelectorPresenter {

    weak private var view: ProtocolSelectorViewProtocol?
    var interactor: ProtocolSelectorInteractorInputProtocol?
    let router: ProtocolSelectorWireframeProtocol

    init(interface: ProtocolSelectorViewProtocol, interactor: ProtocolSelectorInteractorInputProtocol?, router: ProtocolSelectorWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}

extension ProtocolSelectorPresenter: ProtocolSelectorPresenterProtocol {
}

extension ProtocolSelectorPresenter: ProtocolSelectorInteractorOutputProtocol {
}
