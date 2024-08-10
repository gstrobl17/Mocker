//
//  ProtocolSelectorInteractor.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

class ProtocolSelectorInteractor {
    weak var presenter: (any ProtocolSelectorInteractorOutputProtocol)?
}

extension ProtocolSelectorInteractor: ProtocolSelectorInteractorInputProtocol {
    
}
