//
//  ContentPresenterRouterTests.swift
//  MockerTests
//
//  Created by Greg on 2/24/18.
//

import Testing
@testable import Mocker

@MainActor
struct ContentPresenterRouterTests {
    
    @Test func createModule() {
        
        _ = ContentPresenterRouter.createModule()
        
        // Commented out because it produces a warning that the result is always true.
        // #expect(viewController is any ContentPresenterInterfaceProtocol)
    }

}
