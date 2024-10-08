//
//  ProjectFileSelectorRouterTests.swift
//  MockerTests
//
//  Created by Greg on 2/22/18.
//

import XCTest
@testable import Mocker

@MainActor
class ProjectFileSelectorRouterTests: XCTestCase {

    let openPanelFactory = MockOpenPanelFactory()
    let userDefaults = MockUserDefaults()

    func testCreateModule() {
        
        let viewController = ProjectFileSelectorRouter.createModule(openPanelFactory: openPanelFactory, userDefaults: userDefaults)
        
        XCTAssertTrue(viewController is any ProjectFileSelectorViewProtocol)
        if let viewController = viewController as? any ProjectFileSelectorViewProtocol {
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
