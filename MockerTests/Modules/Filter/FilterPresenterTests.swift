//
//  FilterPresenterTests.swift
//  Mocker
//
//  Created Greg on 10/13/18.
//

import AppKit
import XCTest
@testable import Mocker
import MacrosForStroblMocks

@UsesStroblMocks
class FilterPresenterTests: XCTestCase {

    @StroblMock var view: MockFilterView!
    @StroblMock var interactor: MockFilterInteractorInput!
    var router: (any FilterWireframeProtocol)!
    var presenter: FilterPresenter!

    override func setUp() {
        super.setUp()

        view = MockFilterView()
        interactor = MockFilterInteractorInput()
        router = FilterRouter()
        presenter = FilterPresenter(interface: view, interactor: interactor, router: router)
    }

    // MARK: - FilterPresenterProtocol methods -
   
    func test_viewHasLoaded() {
        
        presenter.viewHasLoaded()
        
        verifyStroblMocksUnused(except: [.interactor])
        XCTAssertEqual(interactor.calledMethods, [.viewHasLoadedCalled])
        XCTAssertEqual(interactor.assignedParameters, [])
        XCTAssertEqual(view.calledMethods, [])
    }

    func test_filterValueChanged() {
        let value = "FILTER"
        
        presenter.filterValueChanged(to: value)
        
        verifyStroblMocksUnused(except: [.interactor])
        XCTAssertEqual(interactor.calledMethods, [.filterValueChangedToValueCalled])
        XCTAssertEqual(interactor.assignedParameters, [.value])
        XCTAssertEqual(interactor.value, value)
        XCTAssertEqual(view.calledMethods, [])
    }
    
    // MARK: - FilterInteractorOutputProtocol methods -

    func test_setValue() {
        let value = "FILTER"
        
        presenter.setValue( value)
        
        verifyStroblMocksUnused(except: [.view])
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [.setValueValueCalled])
        XCTAssertEqual(view.assignedParameters, [.value])
        XCTAssertEqual(view.value, value)
    }

}
