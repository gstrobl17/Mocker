//
//  MockFileParametersRouterTests.swift
//  MockerTests
//
//  Created by Greg on 2/26/18.
//

import Testing
@testable import Mocker
import MacrosForStroblMocks

@MainActor @UsesStroblMocks
struct MockFileParametersRouterTests {

    @StroblMock var userDefaults: MockUserDefaults!
    
    init() async {
        userDefaults = MockUserDefaults()
    }
    
    @Test func createModule() throws {
        
        let viewController = MockFileParametersRouter.createModule(userDefaults: userDefaults)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        let routerViewController = try #require(viewController as? any MockFileParametersViewProtocol)
        let presenter = try #require(routerViewController.presenter as? MockFileParametersPresenter)
        #expect(presenter.router.viewController === viewController)
    }

}
