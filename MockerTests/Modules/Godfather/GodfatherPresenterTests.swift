//
//  GodfatherPresenterTests.swift
//  MockerTests
//
//  Created by Greg on 2/24/18.
//

import XCTest
import AppKit
@testable import Mocker

class GodfatherPresenterTests: XCTestCase {
    
    var view: MockGodfatherView!
    var interactor: MockGodfatherInteractorInput!
    var router: GodfatherWireframeProtocol!
    var presenter: GodfatherPresenter!
    var userDefaults: MockUserDefaults!

    override func setUp() {
        super.setUp()
        
        view = MockGodfatherView()
        interactor = MockGodfatherInteractorInput()
        router = GodfatherRouter()
        userDefaults = MockUserDefaults()
        presenter = GodfatherPresenter(interface: view,
                                       interactor: interactor,
                                       router: router,
                                       userDefaults: userDefaults,
                                       fileSynthesisRouterRouterType: MockFileSynthesisRouter.self,
                                       destinationGroupSelectorRouterType: MockDestinationGroupSelectorRouter.self)
    }

    // MARK: - GodfatherPresenterProtocol methods -
    
    func test_viewHasAppeared() {
        
        presenter.viewHasAppeared()
        
        XCTAssertEqual(view.calledMethods, [])
        XCTAssertEqual(interactor.calledMethods, [.viewHasAppearedCalled])
    }
    
    func test_selectProject() {
        
        presenter.selectProject()
        
        XCTAssertEqual(view.calledMethods, [])
        XCTAssertEqual(interactor.calledMethods, [.selectProjectCalled])
    }
    
    func test_canReloadProject_noInteractorReturnsFalse() {
        presenter.interactor = nil
        
        let flag = presenter.canReloadProject()
        
        XCTAssertEqual(flag, false)
        XCTAssertEqual(view.calledMethods, [])
        XCTAssertEqual(interactor.calledMethods, [])
    }

    func test_canReloadProject_returnsFalse() {
        interactor.canReloadProjectReturnValue = false
        
        let flag = presenter.canReloadProject()
        
        XCTAssertEqual(flag, false)
        XCTAssertEqual(view.calledMethods, [])
        XCTAssertEqual(interactor.calledMethods, [.canReloadProjectCalled])
    }
    
    func test_canReloadProject_returnsTrue() {
        interactor.canReloadProjectReturnValue = true
        
        let flag = presenter.canReloadProject()
        
        XCTAssertEqual(flag, true)
        XCTAssertEqual(view.calledMethods, [])
        XCTAssertEqual(interactor.calledMethods, [.canReloadProjectCalled])
    }
    
    func test_reloadProject() {
        
        presenter.reloadProject()
        
        XCTAssertEqual(view.calledMethods, [])
        XCTAssertEqual(interactor.calledMethods, [.reloadProjectCalled])
    }
    
    func test_displayChoice() {
        
        presenter.displayChoice(.mock)
        
        XCTAssertEqual(view.calledMethods, [])
        XCTAssertEqual(interactor.calledMethods, [.displayChoiceChoiceCalled])
        XCTAssertEqual(interactor.assignedParameters, [.choice])
        XCTAssertEqual(interactor.choice, .mock)
    }
    
    func test_openRecentProjectFile() throws {
        let url = try XCTUnwrap(URL(string: "b.txt"))
        
        presenter.openRecentProjectFile(url)
        
        XCTAssertEqual(view.calledMethods, [])
        XCTAssertEqual(interactor.calledMethods, [.openRecentProjectFileUrlCalled])
        XCTAssertEqual(interactor.assignedParameters, [.url])
        XCTAssertEqual(interactor.url, url)
    }

    // MARK: - GodfatherInteractorOutputProtocol methods -

    func test_install() {
        let projectFileSelector = NSViewController()
        let sourceFileSelector = NSViewController()
        let sourceFileFilter = NSViewController()
        let protocolSelector = NSViewController()
        let mockFileParameters = NSViewController()
        let contentPresenter = NSViewController()

        presenter.install(projectFileSelector: projectFileSelector,
                          sourceFileSelector: sourceFileSelector,
                          sourceFileFilter: sourceFileFilter,
                          protocolSelector: protocolSelector,
                          mockFileParameters: mockFileParameters,
                          contentPresenter: contentPresenter)

        XCTAssertEqual(view.calledMethods, [.installProjectFileSelectorSourceFileSelectorSourceFileFilterProtocolSelectorMockFileParametersContentPresenterCalled])
        XCTAssertEqual(view.assignedParameters, [.projectFileSelector, .sourceFileSelector, .sourceFileFilter, .protocolSelector, .mockFileParameters, .contentPresenter])
        XCTAssertTrue(view.projectFileSelector === projectFileSelector)
        XCTAssertTrue(view.sourceFileSelector === sourceFileSelector)
        XCTAssertTrue(view.sourceFileFilter === sourceFileFilter)
        XCTAssertTrue(view.protocolSelector === protocolSelector)
        XCTAssertTrue(view.mockFileParameters === mockFileParameters)
        XCTAssertTrue(view.contentPresenter === contentPresenter)
        XCTAssertEqual(interactor.calledMethods, [])
    }

    func test_reportError() {
        let error = UnitTestError.generic
        
        presenter.reportError(error)
        
        XCTAssertEqual(view.calledMethods, [.displayAlertCalled])
        XCTAssertEqual(view.assignedParameters, [.alert])
        XCTAssertNotNil(view.alert)
        XCTAssertEqual(interactor.calledMethods, [])
    }

    func test_reportErrorCondition() {
        let message = "Message"
        let information = "Information"

        presenter.reportErrorCondition(with: message, and: information)
        
        XCTAssertEqual(view.calledMethods, [.displayAlertCalled])
        XCTAssertEqual(view.assignedParameters, [.alert])
        XCTAssertNotNil(view.alert)
        XCTAssertEqual(interactor.calledMethods, [])
    }
    
    func test_showAsBusy() {
        let message = "Message"
        
        presenter.showAsBusy(with: message)
        
        XCTAssertEqual(view.calledMethods, [.displayActivityIndicatorMessageCalled])
        XCTAssertEqual(view.assignedParameters, [.message])
        XCTAssertEqual(view.message, message)
        XCTAssertEqual(interactor.calledMethods, [])
    }
    
    func test_clearBusyMessage() {
        
        presenter.clearBusyMessage()
        
        XCTAssertEqual(view.calledMethods, [.closeActivityIndicatorCalled])
        XCTAssertEqual(view.assignedParameters, [])
        XCTAssertEqual(interactor.calledMethods, [])
    }
    
    func test_canChooseDisplay() {
        
        presenter.canChooseDisplay(true)
        
        XCTAssertEqual(view.calledMethods, [.enableDisplayChoiceFlagCalled])
        XCTAssertEqual(view.assignedParameters, [.flag])
        XCTAssertEqual(view.flag, true)
        XCTAssertEqual(interactor.calledMethods, [])
    }
    
    func test_setDisplayChoice() {
        
        presenter.setDisplayChoice(.source)
        
        XCTAssertEqual(view.calledMethods, [.setDisplayChoiceChoiceCalled])
        XCTAssertEqual(view.assignedParameters, [.choice])
        XCTAssertEqual(view.choice, .source)
        XCTAssertEqual(interactor.calledMethods, [])
    }
}
