//
//  SourceFileSelectorInteractor.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

class SourceFileSelectorInteractor {
    weak var presenter: (any SourceFileSelectorInteractorOutputProtocol)?
}

extension SourceFileSelectorInteractor: SourceFileSelectorInteractorInputProtocol {
    
    func viewHasLoaded() {
        
    }
    
}
