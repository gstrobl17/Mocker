//
//  FilterPresenterTests.swift
//  Mocker
//
//  Created Greg on 10/13/18.
//

import AppKit
import Testing
@testable import Mocker
import MacrosForStroblMocks

@MainActor @UsesStroblMocks
struct FilterPresenterTests {
    @StroblMock var view: MockFilterView!
    @StroblMock var interactor: MockFilterInteractorInput!
    var router: (any FilterWireframeProtocol)!
    var presenter: FilterPresenter!

    init() async throws {
        view = MockFilterView()
        interactor = MockFilterInteractorInput()
        router = FilterRouter()
        presenter = FilterPresenter(interface: view, interactor: interactor, router: router)
    }
    
    // MARK: - FilterPresenterProtocol methods
    
    @Test func viewHasLoaded() {
        
        presenter.viewHasLoaded()

        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.viewHasLoadedCalled])
        #expect(interactor.assignedParameters == [])
    }

    @Test func filterValueChanged() {
        let value = "FILTER"

        presenter.filterValueChanged(to: value)

        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.filterValueChangedToValueCalled])
        #expect(interactor.assignedParameters == [.value])
        #expect(interactor.value == value)
    }

    // MARK: - FilterInteractorOutputProtocol methods
    
    @Test func setValue() {
        let value = "FILTER"

        presenter.setValue( value)

        verifyStroblMocksUnused(except: [.view])
        #expect(view.calledMethods == [.setValueValueCalled])
        #expect(view.assignedParameters == [.value])
        #expect(view.value == value)
    }

}
