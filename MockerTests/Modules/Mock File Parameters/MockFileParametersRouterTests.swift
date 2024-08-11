//
//  MockFileParametersRouterTests.swift
//  MockerTests
//
//  Created by Greg on 2/26/18.
//

import XCTest
@testable import Mocker
import MacrosForStroblMocks

@UsesStroblMocks
class MockFileParametersRouterTests: XCTestCase {

    @StroblMock let userDefaults = MockUserDefaults()
    
    func testCreateModule() {
        
        let viewController = MockFileParametersRouter.createModule(userDefaults: userDefaults)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.swiftlintAware, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        XCTAssertTrue(viewController is any MockFileParametersViewProtocol)
        if let viewController = viewController as? any MockFileParametersViewProtocol {
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
