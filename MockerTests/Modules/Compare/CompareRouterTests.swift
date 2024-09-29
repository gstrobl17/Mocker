//
//  CompareRouterTests.swift
//  MockerTests
//
//  Created by Greg Strobl on 9/29/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import XCTest
@testable import Mocker

@MainActor
final class CompareRouterTests: XCTestCase {

    let openPanelFactory = MockOpenPanelFactory()
    let userDefaults = MockUserDefaults()

    func testCreateModule() {
        
        let viewController = CompareRouter.createModule(openPanelFactory: openPanelFactory, userDefaults: userDefaults)
        
        XCTAssertTrue(viewController is any CompareViewProtocol)
        if let viewController = viewController as? any CompareViewProtocol {
            XCTAssertNotNil(viewController.presenter)
            if let presenter = viewController.presenter {
                XCTAssertTrue(presenter is ComparePresenter)
                if let presenter = presenter as? ComparePresenter {
                    XCTAssertNotNil(presenter.router.viewController)
                    XCTAssertTrue(presenter.router.viewController === viewController)
                }
            }
        }
    }

}
