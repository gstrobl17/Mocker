//
//  ProtocolSelectorRouterTests.swift
//  MockerTests
//
//  Created by Greg on 2/25/18.
//

import XCTest
@testable import Mocker

class ProtocolSelectorRouterTests: XCTestCase {
    
    @MainActor
    func testCreateModule() {
        
        let viewController = ProtocolSelectorRouter.createModule()
        
        XCTAssertTrue(viewController is any ProtocolSelectorViewProtocol)
        if let viewController = viewController as? any ProtocolSelectorViewProtocol {
            XCTAssertNotNil(viewController.presenter)
            if let presenter = viewController.presenter {
                XCTAssertTrue(presenter is ProtocolSelectorPresenter)
                if let presenter = presenter as? ProtocolSelectorPresenter {
                    XCTAssertNotNil(presenter.router.viewController)
                    XCTAssertTrue(presenter.router.viewController === viewController)
                }
            }
        }
    }

}
