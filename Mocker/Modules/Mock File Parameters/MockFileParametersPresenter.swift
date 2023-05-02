//
//  MockFileParametersPresenter.swift
//  Mocker
//
//  Created Greg on 2/25/18.
//

import AppKit

class MockFileParametersPresenter {

    weak private var view: MockFileParametersViewProtocol?
    var interactor: MockFileParametersInteractorInputProtocol?
    let router: MockFileParametersWireframeProtocol

    init(interface: MockFileParametersViewProtocol, interactor: MockFileParametersInteractorInputProtocol?, router: MockFileParametersWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}

extension MockFileParametersPresenter: MockFileParametersPresenterProtocol {
    
    func setProtocolName(_ protocolName: String) {
        interactor?.setProtocolName(protocolName)
    }

    func prefixUpdated(to prefix: String) {
        interactor?.prefixUpdated(to: prefix)
    }
    
    func stripTrailingProtocolFlagUpdated(to flag: Bool) {
        interactor?.stripTrailingProtocolFlagUpdated(to: flag)
    }
    
    func swiftlintAwareFlagUpdated(to flag: Bool) {
        interactor?.swiftlintAwareFlagUpdated(to: flag)
    }

    func includeTestableImportFlagUpdated(to flag: Bool) {
        interactor?.includeTestableImportFlagUpdated(to: flag)
    }
    
    func trackPropertyActivityFlagUpdated(to flag: Bool) {
        interactor?.trackPropertyActivityFlagUpdated(to: flag)
    }

    func viewHasLoaded() {
        interactor?.viewHasLoaded()
    }

}

extension MockFileParametersPresenter: MockFileParametersInteractorOutputProtocol {
    
    func setParameters(prefix: String,
                       stripTrailingProtocol: Bool,
                       swiftlintAware: Bool,
                       includeTestableImport: Bool,
                       trackPropertyActivity: Bool) {
        view?.setParameters(prefix: prefix,
                            stripTrailingProtocol: stripTrailingProtocol,
                            swiftlintAware: swiftlintAware,
                            includeTestableImport: includeTestableImport,
                            trackPropertyActivity: trackPropertyActivity)
    }
    
    func setName(_ name: String) {
        view?.setName(name)
    }
    
}
