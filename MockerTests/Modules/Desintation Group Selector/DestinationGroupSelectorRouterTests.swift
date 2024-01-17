//
//  DestinationGroupSelectorRouterTests.swift
//  MockerTests
//
//  Created by Greg on 3/3/18.
//

import XCTest
@testable import Mocker

class DestinationGroupSelectorRouterTests: XCTestCase {
    
    let userDefaults = MockUserDefaults()
    let fileManager = MockFileManager()
    
    func testCreateModule() {
        
        let module = DestinationGroupSelectorRouter.createModule(userDefaults: userDefaults, fileManager: fileManager)
        
        XCTAssertTrue(module.view is DestinationGroupSelectorViewProtocol)
        if let viewController = module.view as? DestinationGroupSelectorViewProtocol {
            XCTAssertNotNil(viewController.presenter)
            if let presenter = viewController.presenter {
                XCTAssertTrue(presenter is DestinationGroupSelectorPresenter)
                if let presenter = presenter as? DestinationGroupSelectorPresenter {
                    XCTAssertNotNil(presenter.router.viewController)
                    XCTAssertTrue(presenter.router.viewController === viewController)
                }
            }
        }
    }

}
