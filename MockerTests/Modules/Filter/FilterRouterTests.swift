//
//  FilterRouterTests.swift
//  Mocker
//
//  Created Greg on 10/13/18.
//

import AppKit
import XCTest
@testable import Mocker

class FilterRouterTests: XCTestCase {

    var userDefaults: MockUserDefaults!
    
    override func setUp() {
        super.setUp()
        
        userDefaults = MockUserDefaults()
    }

    func testCreateModule() {

        let module = FilterRouter.createModule(userDefaults: userDefaults)

        XCTAssertTrue(module.view is FilterViewProtocol)
        if let viewController = module.view as? FilterViewProtocol {
            XCTAssertNotNil(viewController.presenter)
            if let presenter = viewController.presenter {
                XCTAssertTrue(presenter is FilterPresenter)
                if let presenter = presenter as? FilterPresenter {
                    XCTAssertNotNil(presenter.router.viewController)
                    XCTAssertTrue(presenter.router.viewController === viewController)
                }
            }
        }
    }
}
