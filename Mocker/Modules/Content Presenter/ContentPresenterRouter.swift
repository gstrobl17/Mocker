//
//  ContentPresenterRouter.swift
//  Mocker
//
//  Created Greg on 2/22/18.
//

import AppKit

@MainActor
class ContentPresenterRouter: ContentPresenterWireframeProtocol {
    
    weak var viewController: (any NSViewController & ContentPresenterInterfaceProtocol)?

    static func createModule() -> any (NSViewController & ContentPresenterInterfaceProtocol) {
        
        let storyboard = NSStoryboard(name: .main, bundle: nil)
        // swiftlint:disable force_cast
        let view = storyboard.instantiateController(withIdentifier: .contentPresenter) as! ContentPresenterViewController
        // swiftlint:enable force_cast
        
        return view
    }
}
