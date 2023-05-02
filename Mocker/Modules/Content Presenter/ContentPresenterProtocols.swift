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

    var viewController: (NSViewController & ContentPresenterInterfaceProtocol)? { get }
    
    static func createModule() -> (NSViewController & ContentPresenterInterfaceProtocol)
}

