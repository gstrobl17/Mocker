//
//  SwiftFileSelectorInteractor.swift
//  Mocker
//
//  Created Greg on 1/2/25.
//

import AppKit

@MainActor
class SwiftFileSelectorInteractor {

    weak var presenter: (any SwiftFileSelectorInteractorOutputProtocol)? {
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

extension SwiftFileSelectorInteractor: SwiftFileSelectorInteractorInputProtocol {
    
    func setURL(_ url: URL) {
        self.url = url
    }

    func swiftFileSelected(_ url: URL) {
        setURL(url)
        presentSelectedFile()
    }
    
    func viewHasLoaded() {
        presentSelectedFile()
    }
    
}
