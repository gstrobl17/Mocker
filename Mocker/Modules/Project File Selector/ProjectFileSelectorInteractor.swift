//
//  ProjectFileSelectorInteractor.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

class ProjectFileSelectorInteractor {

    weak var presenter: (any ProjectFileSelectorInteractorOutputProtocol)? {
        didSet {
            presentSelectedFile()
        }
    }
    
    internal var url: URL?
    
    private func presentSelectedFile() {
        guard let url = url else { return }
        presenter?.showSelectedFile(url)
    }
    
}

extension ProjectFileSelectorInteractor: ProjectFileSelectorInteractorInputProtocol {
    
    func setURL(_ url: URL) {
        self.url = url
    }

    func projectFileSelected(_ url: URL) {
        setURL(url)
        presentSelectedFile()
    }
    
    func viewHasLoaded() {
        presentSelectedFile()
    }
    
}
