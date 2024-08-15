//
//  FilterInteractorTests.swift
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
//class FilterInteractorTests: XCTestCase {
//
//    @StroblMock var presenter: MockFilterInteractorOutput!
//    @StroblMock var userDefaults: MockUserDefaults!
//    var interactor: FilterInteractor!
//
//    override func setUp() {
//        super.setUp()
//
//        presenter = MockFilterInteractorOutput()
//        userDefaults = MockUserDefaults()
//        interactor = FilterInteractor(userDefaults: userDefaults)
//        interactor.presenter = presenter
//        userDefaults.reset()
//        presenter.reset()
//    }
//
//    // MARK: - init -
//
//    func testInit() {
//
//        let interactor = FilterInteractor(userDefaults: userDefaults)
//        interactor.presenter = presenter
//
//        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
//        XCTAssertEqual(presenter.calledMethods, [.setValueValueCalled])
//        XCTAssertEqual(presenter.assignedParameters, [.value])
//        XCTAssertEqual(userDefaults.calledMethods, [.stringForKeyDefaultNameCalled])
//        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName])
//        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.sourceFileFilterValue])
//    }
//
//    // MARK: - FilterInteractorInputProtocol methods -
//    
//    func test_viewHasLoaded() {
//        
//        interactor.viewHasLoaded()
//
//        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
//        XCTAssertEqual(presenter.calledMethods, [.setValueValueCalled])
//        XCTAssertEqual(presenter.assignedParameters, [.value])
//        XCTAssertEqual(userDefaults.calledMethods, [.stringForKeyDefaultNameCalled])
//        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName])
//        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.sourceFileFilterValue])
//    }
//    
//    func test_viewHasLoaded_noPresenter() {
//        interactor.presenter = nil
//        
//        interactor.viewHasLoaded()
//        
//        verifyStroblMocksUnused()
//        XCTAssertEqual(presenter.calledMethods, [])
//    }
//
//    func test_filterValueChanged() {
//        let value = "NEW VALUE"
//        
//        interactor.filterValueChanged(to: value)
//        
//        verifyStroblMocksUnused(except: [.userDefaults])
//        XCTAssertEqual(userDefaults.calledMethods, [.setValueForKeyDefaultNameCalled])
//        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .value])
//        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.sourceFileFilterValue])
//        XCTAssertEqual(userDefaults.values.count, 1)
//        XCTAssertTrue(userDefaults.values is [String])
//        if let values = userDefaults.values as? [String] {
//            XCTAssertEqual(values, [value])
//        }
//    }
//    
//    // MARK: - FilterInterfaceProtocol methods -
//
//    func test_clear() {
//
//        interactor.clear()
//        
//        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
//        XCTAssertEqual(presenter.calledMethods, [.setValueValueCalled])
//        XCTAssertEqual(presenter.assignedParameters, [.value])
//        XCTAssertEqual(presenter.value, "")
//        XCTAssertEqual(userDefaults.calledMethods, [.setValueForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
//        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .value])
//        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.sourceFileFilterValue, UserDefaultsKey.sourceFileFilterValue])
//        XCTAssertEqual(userDefaults.values.count, 1)
//        XCTAssertTrue(userDefaults.values is [String])
//        if let values = userDefaults.values as? [String] {
//            XCTAssertEqual(values, [""])
//        }
//    }
//}
