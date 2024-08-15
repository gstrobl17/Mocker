//
//  FilterRouterTests.swift
//  Mocker
//
//  Created Greg on 10/13/18.
//

import AppKit
@testable import Mocker
//import MacrosForStroblMocks   //TODO: Update for Swift Testing and implement
import Testing

@MainActor
struct FilterRouterTests {
    var userDefaults: MockUserDefaults!
    
    init() async throws {
        userDefaults = try #require(MockUserDefaults())
    }
    
    @Test func createModule() throws {
        
        let module = FilterRouter.createModule(userDefaults: userDefaults)

//        verifyStroblMocksUnused(except: [.userDefaults])
        #expect(userDefaults.calledMethods == [.stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.sourceFileFilterValue])
        let viewController = try #require(module.view as? any FilterViewProtocol)
        let presenter = try #require(viewController.presenter as? FilterPresenter)
        let presenterViewController = try #require(presenter.router.viewController)
        #expect(presenterViewController === viewController)
    }
}
 
