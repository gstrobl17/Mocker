//
//  ContentPresenterRouterTests.swift
//  MockerTests
//
//  Created by Greg on 2/24/18.
//

import XCTest
@testable import Mocker

class ContentPresenterRouterTests: XCTestCase {
    
    @MainActor
    func testCreateModule() {
        
        _ = ContentPresenterRouter.createModule()
        
        // Commented out because it produces a warning that the result is always true. XCTAssertTrue(viewController is ContentPresenterInterfaceProtocol)
    }

}
