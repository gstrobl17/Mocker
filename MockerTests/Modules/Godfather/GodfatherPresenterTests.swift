//
//  GodfatherPresenterTests.swift
//  MockerTests
//
//  Created by Greg on 2/24/18.
//

import Testing
import AppKit
import Foundation
@testable import Mocker
import MacrosForStroblMocks

@MainActor @UsesStroblMocks
struct GodfatherPresenterTests {
    
    @StroblMock var view: MockGodfatherView!
    @StroblMock var interactor: MockGodfatherInteractorInput!
    var router: (any GodfatherWireframeProtocol)!
    var presenter: GodfatherPresenter!
    @StroblMock var userDefaults: MockUserDefaults!

    init() async {
        view = MockGodfatherView()
        interactor = MockGodfatherInteractorInput()
        router = GodfatherRouter()
        userDefaults = MockUserDefaults()
        presenter = GodfatherPresenter(interface: view,
                                       interactor: interactor,
                                       router: router,
                                       userDefaults: userDefaults)
    }

    // MARK: - GodfatherPresenterProtocol methods
    
    @Test func viewHasAppeared() {
        
        presenter.viewHasAppeared()
        
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.viewHasAppearedCalled])
        #expect(interactor.assignedParameters == [])
    }
    
    @Test func selectProject() {
        
        presenter.selectProject()
        
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.selectProjectCalled])
        #expect(interactor.assignedParameters == [])
    }
    
    @Test func canReloadProject_noInteractorReturnsFalse() {
        presenter.interactor = nil
        
        let flag = presenter.canReloadProject()
        
        #expect(flag == false)
        verifyStroblMocksUnused()
    }

    @Test func canReloadProject_returnsFalse() {
        interactor.canReloadProjectReturnValue = false
        
        let flag = presenter.canReloadProject()
        
        #expect(flag == false)
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.canReloadProjectCalled])
        #expect(interactor.assignedParameters == [])
    }
    
    @Test func canReloadProject_returnsTrue() {
        interactor.canReloadProjectReturnValue = true
        
        let flag = presenter.canReloadProject()
        
        #expect(flag == true)
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.canReloadProjectCalled])
        #expect(interactor.assignedParameters == [])
    }
    
    @Test func reloadProject() {
        
        presenter.reloadProject()
        
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.reloadProjectCalled])
        #expect(interactor.assignedParameters == [])
    }
    
    @Test func displayChoice() {
        
        presenter.displayChoice(.mock)
        
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.displayChoiceChoiceCalled])
        #expect(interactor.assignedParameters == [.choice])
        #expect(interactor.choice == .mock)
    }
    
    @Test func copyMockToClipboard() {
        
        presenter.copyMockToClipboard()
        
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.copyMockToClipboardCalled])
        #expect(interactor.assignedParameters == [])
    }

    @Test func openRecentProjectFile() throws {
        let url = try #require(URL(string: "b.txt"))
        
        presenter.openRecentProjectFile(url)
        
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.openRecentProjectFileUrlCalled])
        #expect(interactor.assignedParameters == [.url])
        #expect(interactor.url == url)
    }

    // MARK: - GodfatherInteractorOutputProtocol methods

    @Test func install() {
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

        verifyStroblMocksUnused(except: [.view])
        #expect(view.calledMethods == [.installProjectFileSelectorSourceFileSelectorSourceFileFilterProtocolSelectorMockFileParametersContentPresenterCalled])
        #expect(view.assignedParameters == [.projectFileSelector, .sourceFileSelector, .sourceFileFilter, .protocolSelector, .mockFileParameters, .contentPresenter])
        #expect(view.projectFileSelector === projectFileSelector)
        #expect(view.sourceFileSelector === sourceFileSelector)
        #expect(view.sourceFileFilter === sourceFileFilter)
        #expect(view.protocolSelector === protocolSelector)
        #expect(view.mockFileParameters === mockFileParameters)
        #expect(view.contentPresenter === contentPresenter)
    }

    @Test func reportError() {
        let error = UnitTestError.generic
        
        presenter.reportError(error)
        
        verifyStroblMocksUnused(except: [.view])
        #expect(view.calledMethods == [.displayAlertCalled])
        #expect(view.assignedParameters == [.alert])
        #expect(view.alert != nil)
    }

    @Test func reportErrorCondition() {
        let message = "Message"
        let information = "Information"

        presenter.reportErrorCondition(with: message, and: information)
        
        verifyStroblMocksUnused(except: [.view])
        #expect(view.calledMethods == [.displayAlertCalled])
        #expect(view.assignedParameters == [.alert])
        #expect(view.alert != nil)
    }
    
    @Test func showAsBusy() {
        let message = "Message"
        
        presenter.showAsBusy(with: message)
        
        verifyStroblMocksUnused(except: [.view])
        #expect(view.calledMethods == [.displayActivityIndicatorMessageCalled])
        #expect(view.assignedParameters == [.message])
        #expect(view.message == message)
    }
    
    @Test func clearBusyMessage() {
        
        presenter.clearBusyMessage()
        
        verifyStroblMocksUnused(except: [.view])
        #expect(view.calledMethods == [.closeActivityIndicatorCalled])
        #expect(view.assignedParameters == [])
    }
    
    @Test func canChooseDisplay() {
        
        presenter.canChooseDisplay(true)
        
        verifyStroblMocksUnused(except: [.view])
        #expect(view.calledMethods == [.enableDisplayChoiceFlagCalled])
        #expect(view.assignedParameters == [.flag])
        #expect(view.flag == true)
    }
    
    @Test func setDisplayChoice() {
        
        presenter.setDisplayChoice(.source)
        
        verifyStroblMocksUnused(except: [.view])
        #expect(view.calledMethods == [.setDisplayChoiceChoiceCalled])
        #expect(view.assignedParameters == [.choice])
        #expect(view.choice == .source)
    }
}
