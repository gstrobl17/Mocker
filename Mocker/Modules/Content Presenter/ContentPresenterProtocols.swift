//
//  ContentPresenterProtocols.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

protocol ContentPresenterInterfaceProtocol: AnyObject {
    func present(text: String?)
}

// MARK: Wireframe -
protocol ContentPresenterWireframeProtocol: AnyObject {

    var viewController: (any NSViewController & ContentPresenterInterfaceProtocol)? { get }
    
    static func createModule() -> (any NSViewController & ContentPresenterInterfaceProtocol)
}

