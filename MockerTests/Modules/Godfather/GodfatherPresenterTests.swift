//
//  GodfatherPresenterTests.swift
//  MockerTests
//
//  Created by Greg on 2/24/18.
//

import XCTest
import AppKit
@testable import Mocker
import MacrosForStroblMocks

//TODO: resolve
//@UsesStroblMocks
//class GodfatherPresenterTests: XCTestCase {
//    
//    @StroblMock var view: MockGodfatherView!
//    @StroblMock var interactor: MockGodfatherInteractorInput!
//    var router: (any GodfatherWireframeProtocol)!
//    var presenter: GodfatherPresenter!
//    @StroblMock var userDefaults: MockUserDefaults!
//
//    override func setUp() {
//        super.setUp()
//        
//        view = MockGodfatherView()
//        interactor = MockGodfatherInteractorInput()
//        router = GodfatherRouter()
//        userDefaults = MockUserDefaults()
//        presenter = GodfatherPresenter(interface: view,
//                                       interactor: interactor,
//                                       router: router,
//                                       userDefaults: userDefaults)
//    }
//
//    // MARK: - GodfatherPresenterProtocol methods -
//    
//    func test_viewHasAppeared() {
//        
//        presenter.viewHasAppeared()
//        
//        verifyStroblMocksUnused(except: [.interactor])
//        XCTAssertEqual(interactor.calledMethods, [.viewHasAppearedCalled])
//        XCTAssertEqual(interactor.assignedParameters, [])
//    }
//    
//    func test_selectProject() {
//        
//        presenter.selectProject()
//        
//        verifyStroblMocksUnused(except: [.interactor])
//        XCTAssertEqual(interactor.calledMethods, [.selectProjectCalled])
//        XCTAssertEqual(interactor.assignedParameters, [])
//    }
//    
//    func test_canReloadProject_noInteractorReturnsFalse() {
//        presenter.interactor = nil
//        
//        let flag = presenter.canReloadProject()
//        
//        XCTAssertEqual(flag, false)
//        verifyStroblMocksUnused()
//    }
//
//    func test_canReloadProject_returnsFalse() {
//        interactor.canReloadProjectReturnValue = false
//        
//        let flag = presenter.canReloadProject()
//        
//        XCTAssertEqual(flag, false)
//        verifyStroblMocksUnused(except: [.interactor])
//        XCTAssertEqual(interactor.calledMethods, [.canReloadProjectCalled])
//        XCTAssertEqual(interactor.assignedParameters, [])
//    }
//    
//    func test_canReloadProject_returnsTrue() {
//        interactor.canReloadProjectReturnValue = true
//        
//        let flag = presenter.canReloadProject()
//        
//        XCTAssertEqual(flag, true)
//        verifyStroblMocksUnused(except: [.interactor])
//        XCTAssertEqual(interactor.calledMethods, [.canReloadProjectCalled])
//        XCTAssertEqual(interactor.assignedParameters, [])
//    }
//    
//    func test_reloadProject() {
//        
//        presenter.reloadProject()
//        
//        verifyStroblMocksUnused(except: [.interactor])
//        XCTAssertEqual(interactor.calledMethods, [.reloadProjectCalled])
//        XCTAssertEqual(interactor.assignedParameters, [])
//    }
//    
//    func test_displayChoice() {
//        
//        presenter.displayChoice(.mock)
//        
//        verifyStroblMocksUnused(except: [.interactor])
//        XCTAssertEqual(interactor.calledMethods, [.displayChoiceChoiceCalled])
//        XCTAssertEqual(interactor.assignedParameters, [.choice])
//        XCTAssertEqual(interactor.choice, .mock)
//    }
//    
//    func test_copyMockToClipboard() {
//        
//        presenter.copyMockToClipboard()
//        
//        verifyStroblMocksUnused(except: [.interactor])
//        XCTAssertEqual(interactor.calledMethods, [.copyMockToClipboardCalled])
//        XCTAssertEqual(interactor.assignedParameters, [])
//    }
//
//    func test_openRecentProjectFile() throws {
//        let url = try XCTUnwrap(URL(string: "b.txt"))
//        
//        presenter.openRecentProjectFile(url)
//        
//        verifyStroblMocksUnused(except: [.interactor])
//        XCTAssertEqual(interactor.calledMethods, [.openRecentProjectFileUrlCalled])
//        XCTAssertEqual(interactor.assignedParameters, [.url])
//        XCTAssertEqual(interactor.url, url)
//    }
//
//    // MARK: - GodfatherInteractorOutputProtocol methods -
//
//    func test_install() {
//        let projectFileSelector = NSViewController()
//        let sourceFileSelector = NSViewController()
//        let sourceFileFilter = NSViewController()
//        let protocolSelector = NSViewController()
//        let mockFileParameters = NSViewController()
//        let contentPresenter = NSViewController()
//
//        presenter.install(projectFileSelector: projectFileSelector,
//                          sourceFileSelector: sourceFileSelector,
//                          sourceFileFilter: sourceFileFilter,
//                          protocolSelector: protocolSelector,
//                          mockFileParameters: mockFileParameters,
//                          contentPresenter: contentPresenter)
//
//        verifyStroblMocksUnused(except: [.view])
//        XCTAssertEqual(view.calledMethods, [.installProjectFileSelectorSourceFileSelectorSourceFileFilterProtocolSelectorMockFileParametersContentPresenterCalled])
//        XCTAssertEqual(view.assignedParameters, [.projectFileSelector, .sourceFileSelector, .sourceFileFilter, .protocolSelector, .mockFileParameters, .contentPresenter])
//        XCTAssertTrue(view.projectFileSelector === projectFileSelector)
//        XCTAssertTrue(view.sourceFileSelector === sourceFileSelector)
//        XCTAssertTrue(view.sourceFileFilter === sourceFileFilter)
//        XCTAssertTrue(view.protocolSelector === protocolSelector)
//        XCTAssertTrue(view.mockFileParameters === mockFileParameters)
//        XCTAssertTrue(view.contentPresenter === contentPresenter)
//    }
//
//    func test_reportError() {
//        let error = UnitTestError.generic
//        
//        presenter.reportError(error)
//        
//        verifyStroblMocksUnused(except: [.view])
//        XCTAssertEqual(view.calledMethods, [.displayAlertCalled])
//        XCTAssertEqual(view.assignedParameters, [.alert])
//        XCTAssertNotNil(view.alert)
//    }
//
//    func test_reportErrorCondition() {
//        let message = "Message"
//        let information = "Information"
//
//        presenter.reportErrorCondition(with: message, and: information)
//        
//        verifyStroblMocksUnused(except: [.view])
//        XCTAssertEqual(view.calledMethods, [.displayAlertCalled])
//        XCTAssertEqual(view.assignedParameters, [.alert])
//        XCTAssertNotNil(view.alert)
//    }
//    
//    func test_showAsBusy() {
//        let message = "Message"
//        
//        presenter.showAsBusy(with: message)
//        
//        verifyStroblMocksUnused(except: [.view])
//        XCTAssertEqual(view.calledMethods, [.displayActivityIndicatorMessageCalled])
//        XCTAssertEqual(view.assignedParameters, [.message])
//        XCTAssertEqual(view.message, message)
//    }
//    
//    func test_clearBusyMessage() {
//        
//        presenter.clearBusyMessage()
//        
//        verifyStroblMocksUnused(except: [.view])
//        XCTAssertEqual(view.calledMethods, [.closeActivityIndicatorCalled])
//        XCTAssertEqual(view.assignedParameters, [])
//    }
//    
//    func test_canChooseDisplay() {
//        
//        presenter.canChooseDisplay(true)
//        
//        verifyStroblMocksUnused(except: [.view])
//        XCTAssertEqual(view.calledMethods, [.enableDisplayChoiceFlagCalled])
//        XCTAssertEqual(view.assignedParameters, [.flag])
//        XCTAssertEqual(view.flag, true)
//    }
//    
//    func test_setDisplayChoice() {
//        
//        presenter.setDisplayChoice(.source)
//        
//        verifyStroblMocksUnused(except: [.view])
//        XCTAssertEqual(view.calledMethods, [.setDisplayChoiceChoiceCalled])
//        XCTAssertEqual(view.assignedParameters, [.choice])
//        XCTAssertEqual(view.choice, .source)
//    }
//}
