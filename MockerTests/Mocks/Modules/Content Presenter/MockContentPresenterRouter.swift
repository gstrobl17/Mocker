//
//  MockContentPresenterRouter.swift
//  MockerTests
//
//  Created by Greg on 2/24/18.
//

import AppKit
@testable import Mocker

class MockContentPresenterRouter: ContentPresenterWireframeProtocol {
    
    weak var viewController: (any NSViewController & ContentPresenterInterfaceProtocol)?
    
    static func createModule() -> (any NSViewController & ContentPresenterInterfaceProtocol) {
        let view = MockContentPresenterView()
        let router = MockContentPresenterRouter()
        router.viewController = view
        return view
    }
    
}

