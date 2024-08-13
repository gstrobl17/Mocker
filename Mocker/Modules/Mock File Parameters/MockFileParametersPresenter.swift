//
//  MockFileParametersPresenter.swift
//  Mocker
//
//  Created Greg on 2/25/18.
//

import AppKit

class MockFileParametersPresenter {

    weak private var view: (any MockFileParametersViewProtocol)?
    var interactor: (any MockFileParametersInteractorInputProtocol)?
    let router: any MockFileParametersWireframeProtocol

    init(interface: any MockFileParametersViewProtocol, interactor: (any MockFileParametersInteractorInputProtocol)?, router: any MockFileParametersWireframeProtocol) {
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
    
    func includeHeaderFlagUpdated(to flag: Bool) {
        interactor?.includeHeaderFlagUpdated(to: flag)
    }
    
    func stripTrailingProtocolFlagUpdated(to flag: Bool) {
        interactor?.stripTrailingProtocolFlagUpdated(to: flag)
    }

    func includeTestableImportFlagUpdated(to flag: Bool) {
        interactor?.includeTestableImportFlagUpdated(to: flag)
    }
    
    func trackPropertyActivityFlagUpdated(to flag: Bool) {
        interactor?.trackPropertyActivityFlagUpdated(to: flag)
    }

    func publicFlagUpdated(to flag: Bool) {
        interactor?.publicFlagUpdated(to: flag)
    }
    
    func viewHasLoaded() {
        interactor?.viewHasLoaded()
    }

}

extension MockFileParametersPresenter: MockFileParametersInteractorOutputProtocol {
    
    //swiftlint:disable:next function_parameter_count
    func setParameters(prefix: String,
                       includeHeader: Bool,
                       stripTrailingProtocol: Bool,
                       includeTestableImport: Bool,
                       trackPropertyActivity: Bool,
                       public: Bool) {
        view?.setParameters(prefix: prefix,
                            includeHeader: includeHeader,
                            stripTrailingProtocol: stripTrailingProtocol,
                            includeTestableImport: includeTestableImport,
                            trackPropertyActivity: trackPropertyActivity,
                            public: `public`)
    }
    
    func setName(_ name: String) {
        view?.setName(name)
    }
    
}
