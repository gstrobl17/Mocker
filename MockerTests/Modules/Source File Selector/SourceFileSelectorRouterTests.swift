//
//  SourceFileSelectorRouterTests.swift
//  MockerTests
//
//  Created by Greg on 2/23/18.
//

import XCTest
@testable import Mocker

class SourceFileSelectorRouterTests: XCTestCase {

    func testCreateModule() {
        
        let viewController = SourceFileSelectorRouter.createModule()
        
        XCTAssertTrue(viewController is SourceFileSelectorViewProtocol)
        if let viewController = viewController as? SourceFileSelectorViewProtocol {
            XCTAssertNotNil(viewController.presenter)
            if let presenter = viewController.presenter {
                XCTAssertTrue(presenter is SourceFileSelectorPresenter)
                if let presenter = presenter as? SourceFileSelectorPresenter {
                    XCTAssertNotNil(presenter.router.viewController)
                    XCTAssertTrue(presenter.router.viewController === viewController)
                }
            }
        }
    }

}
