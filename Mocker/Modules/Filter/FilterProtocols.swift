//
//  FilterProtocols.swift
//  Mocker
//
//  Created Greg on 10/13/18.
//

import AppKit

// MARK: Interface -
protocol FilterInterfaceProtocol: AnyObject {
    var delegate: FilterInterfaceDelegate? { get set }

    func clear()
}

protocol FilterInterfaceDelegate: AnyObject {
    func filter(_ filterInterface: FilterInterfaceProtocol, newValue: String)
}

// MARK: Wireframe -
protocol FilterWireframeProtocol: AnyObject {

    var viewController: NSViewController? { get set }

    static func createModule(userDefaults: KeyValueStoring) -> (view: NSViewController, interface: FilterInterfaceProtocol)

}

// MARK: Interactor -
protocol FilterInteractorOutputProtocol: AnyObject {

    /* Interactor -> Presenter */
    func setValue(_ value: String)
}

protocol FilterInteractorInputProtocol: AnyObject {

    var presenter: FilterInteractorOutputProtocol? { get set }

    /* Presenter -> Interactor */
    func viewHasLoaded()
    func filterValueChanged(to value: String)
}

// MARK: Presenter -
protocol FilterPresenterProtocol: AnyObject {

    var interactor: FilterInteractorInputProtocol? { get set }

    /* ViewController -> Presenter */
    func viewHasLoaded()
    func filterValueChanged(to value: String)
}

// MARK: View -
protocol FilterViewProtocol: AnyObject {

    var presenter: FilterPresenterProtocol? { get set }

    /* Presenter -> ViewController */
    func setValue(_ value: String)
}
