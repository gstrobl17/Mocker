//
//  ContentPresenterProtocols.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

@MainActor
protocol ContentPresenterInterfaceProtocol: AnyObject {
    func present(text: String?)
}

// MARK: Wireframe -
@MainActor
protocol ContentPresenterWireframeProtocol: AnyObject {

    var viewController: (any NSViewController & ContentPresenterInterfaceProtocol)? { get }
    
    static func createModule() -> (any NSViewController & ContentPresenterInterfaceProtocol)
}

