//
//  ProtocolSelectorPresenter.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

class ProtocolSelectorPresenter {

    weak private var view: (any ProtocolSelectorViewProtocol)?
    var interactor: (any ProtocolSelectorInteractorInputProtocol)?
    let router: any ProtocolSelectorWireframeProtocol

    init(interface: any ProtocolSelectorViewProtocol, interactor: (any ProtocolSelectorInteractorInputProtocol)?, router: any ProtocolSelectorWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}

extension ProtocolSelectorPresenter: ProtocolSelectorPresenterProtocol {
}

extension ProtocolSelectorPresenter: ProtocolSelectorInteractorOutputProtocol {
}
