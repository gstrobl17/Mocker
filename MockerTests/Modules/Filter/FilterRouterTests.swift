//
//  FilterRouterTests.swift
//  Mocker
//
//  Created Greg on 10/13/18.
//

import AppKit
import XCTest
@testable import Mocker
import MacrosForStroblMocks

//TODO: resolve
//@UsesStroblMocks
//class FilterRouterTests: XCTestCase {
//
//    @StroblMock var userDefaults: MockUserDefaults!
//    
//    override func setUp() {
//        super.setUp()
//        
//        userDefaults = MockUserDefaults()
//    }
//
//    func testCreateModule() {
//
//        let module = FilterRouter.createModule(userDefaults: userDefaults)
//
//        verifyStroblMocksUnused(except: [.userDefaults])
//        XCTAssertEqual(userDefaults.calledMethods, [.stringForKeyDefaultNameCalled])
//        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName])
//        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.sourceFileFilterValue])
//        XCTAssertTrue(module.view is any FilterViewProtocol)
//        if let viewController = module.view as? any FilterViewProtocol {
//            XCTAssertNotNil(viewController.presenter)
//            if let presenter = viewController.presenter {
//                XCTAssertTrue(presenter is FilterPresenter)
//                if let presenter = presenter as? FilterPresenter {
//                    XCTAssertNotNil(presenter.router.viewController)
//                    XCTAssertTrue(presenter.router.viewController === viewController)
//                }
//            }
//        }
//    }
//}
