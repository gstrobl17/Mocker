//
//  ProjectFileSelectorRouterTests.swift
//  MockerTests
//
//  Created by Greg on 2/22/18.
//

import XCTest
@testable import Mocker

class ProjectFileSelectorRouterTests: XCTestCase {

    let openPanelFactory = MockOpenPanelFactory()
    
    override func setUp() {
        super.setUp()
    }

    func testCreateModule() {
        
        let viewController = ProjectFileSelectorRouter.createModule(openPanelFactory: openPanelFactory)
        
        XCTAssertTrue(viewController is ProjectFileSelectorViewProtocol)
        if let viewController = viewController as? ProjectFileSelectorViewProtocol {
            XCTAssertNotNil(viewController.presenter)
            if let presenter = viewController.presenter {
                XCTAssertTrue(presenter is ProjectFileSelectorPresenter)
                if let presenter = presenter as? ProjectFileSelectorPresenter {
                    XCTAssertNotNil(presenter.router.viewController)
                    XCTAssertTrue(presenter.router.viewController === viewController)
                }
            }
        }
    }

}
