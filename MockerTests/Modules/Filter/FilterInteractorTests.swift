//
//  FilterInteractorTests.swift
//  Mocker
//
//  Created Greg on 10/13/18.
//

import AppKit
import XCTest
@testable import Mocker

class FilterInteractorTests: XCTestCase {

    var presenter: MockFilterInteractorOutput!
    var userDefaults: MockUserDefaults!

    override func setUp() {
        super.setUp()

        presenter = MockFilterInteractorOutput()
        userDefaults = MockUserDefaults()
    }

    override func tearDown() {
        // Put teardown code here. 
        // This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // MARK: - init -

    func testInit() {

        let interactor = FilterInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter

        XCTAssertEqual(presenter.calledMethods, [.setValueValueCalled])
        XCTAssertEqual(presenter.assignedParameters, [.value])
    }

    // MARK: - FilterInteractorInputProtocol methods -
    
    func test_viewHasLoaded() {
        let interactor = FilterInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.viewHasLoaded()

        XCTAssertEqual(presenter.calledMethods, [.setValueValueCalled])
        XCTAssertEqual(presenter.assignedParameters, [.value])
    }
    
    func test_viewHasLoaded_noPresenter() {
        let interactor = FilterInteractor(userDefaults: userDefaults)
        
        interactor.viewHasLoaded()
        
        XCTAssertEqual(presenter.calledMethods, [])
    }

    func test_filterValueChanged() {
        let value = "NEW VALUE"
        let interactor = FilterInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.filterValueChanged(to: value)
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(userDefaults.sourceFileFilterValue, value)
    }
    
    // MARK: - FilterInterfaceProtocol methods -

    func test_clear() {
        let interactor = FilterInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()

        interactor.clear()
        
        XCTAssertEqual(presenter.calledMethods, [.setValueValueCalled])
        XCTAssertEqual(presenter.assignedParameters, [.value])
        XCTAssertEqual(presenter.value, "")
        XCTAssertEqual(userDefaults.sourceFileFilterValue, "")
    }
}
