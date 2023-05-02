//
//  MockFileParametersRouterTests.swift
//  MockerTests
//
//  Created by Greg on 2/26/18.
//

import XCTest
@testable import Mocker

class MockFileParametersRouterTests: XCTestCase {

    let userDefaults = MockUserDefaults()

    override func setUp() {
        super.setUp()
    }
    
    func testCreateModule() {
        
        let viewController = MockFileParametersRouter.createModule(userDefaults: userDefaults)
        
        XCTAssertTrue(viewController is MockFileParametersViewProtocol)
        if let viewController = viewController as? MockFileParametersViewProtocol {
            XCTAssertNotNil(viewController.presenter)
            if let presenter = viewController.presenter {
                XCTAssertTrue(presenter is MockFileParametersPresenter)
                if let presenter = presenter as? MockFileParametersPresenter {
                    XCTAssertNotNil(presenter.router.viewController)
                    XCTAssertTrue(presenter.router.viewController === viewController)
                }
            }
        }
    }

}
