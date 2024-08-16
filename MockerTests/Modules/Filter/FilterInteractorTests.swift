//
//  FilterInteractorTests.swift
//  Mocker
//
//  Created Greg on 10/13/18.
//

import AppKit
import Testing
@testable import Mocker
import MacrosForStroblMocks

@MainActor @UsesStroblMocks
struct FilterInteractorTests {

    @StroblMock var presenter: MockFilterInteractorOutput!
    @StroblMock var userDefaults: MockUserDefaults!
    var interactor: FilterInteractor!

    init() async {
        presenter = MockFilterInteractorOutput()
        userDefaults = MockUserDefaults()
        interactor = FilterInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        userDefaults.reset()
        presenter.reset()
    }

    // MARK: - init

    @Test func testInit() {

        let interactor = FilterInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter

        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        #expect(presenter.calledMethods == [.setValueValueCalled])
        #expect(presenter.assignedParameters == [.value])
        #expect(userDefaults.calledMethods == [.stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.sourceFileFilterValue])
    }

    // MARK: - FilterInteractorInputProtocol methods
    
    @Test func viewHasLoaded() {
        
        interactor.viewHasLoaded()

        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        #expect(presenter.calledMethods == [.setValueValueCalled])
        #expect(presenter.assignedParameters == [.value])
        #expect(userDefaults.calledMethods == [.stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.sourceFileFilterValue])
    }
    
    @Test func test_viewHasLoaded_noPresenter() {
        interactor.presenter = nil
        
        interactor.viewHasLoaded()
        
        verifyStroblMocksUnused()
    }

    @Test func filterValueChanged() throws {
        let value = "NEW VALUE"
        
        interactor.filterValueChanged(to: value)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        #expect(userDefaults.calledMethods == [.setValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.sourceFileFilterValue])
        #expect(userDefaults.values.count == 1)
        let values = try #require(userDefaults.values as? [String])
        #expect(values == [value])
    }
    
    // MARK: - FilterInterfaceProtocol methods

    @Test func clear() throws {

        interactor.clear()
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        #expect(presenter.calledMethods == [.setValueValueCalled])
        #expect(presenter.assignedParameters == [.value])
        #expect(presenter.value == "")
        #expect(userDefaults.calledMethods == [.setValueForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.sourceFileFilterValue, UserDefaultsKey.sourceFileFilterValue])
        #expect(userDefaults.values.count == 1)
        let values = try #require(userDefaults.values as? [String])
        #expect(values == [""])
    }
}
