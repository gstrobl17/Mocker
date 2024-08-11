//
//  MockFilterWireframe.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit

class MockFilterWireframe: FilterWireframeProtocol {

    var viewController: NSViewController?

    static func createModule(userDefaults: any KeyValueStoring) -> (view: NSViewController, interface: any FilterInterfaceProtocol) {

        let view = MockFilterView()
        view.reset()
        let interface = MockFilterInterface()
        let interactor = MockFilterInteractorInput()
        let router = MockFilterWireframe()
        let presenter = MockFilterPresenter()
        
        presenter.interactor = interactor
        router.viewController = view
        view.presenter = presenter
        
        return (view, interface)
    }

}
