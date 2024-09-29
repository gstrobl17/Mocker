//
//  ComparePresenterTests.swift
//  MockerTests
//
//  Created by Greg Strobl on 9/29/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Testing
import Foundation
@testable import Mocker
import MacrosForStroblMocks

@MainActor @UsesStroblMocks
struct ComparePresenterTests {
    
    @StroblMock var view: MockCompareView!
    @StroblMock var interactor: MockCompareInteractorInput!
    var router: (any CompareWireframeProtocol)!
    var presenter: ComparePresenter!
    let openPanelFactory = MockOpenPanelFactory()
    @StroblMock var userDefaults: MockUserDefaults!

    let mockCode = "MOCK-CODE"
    
    init() async {
        userDefaults = MockUserDefaults()
        view = MockCompareView()
        view.mockCodeForCompareReturnValue = mockCode
        interactor = MockCompareInteractorInput()
        router = CompareRouter()
        presenter = ComparePresenter(
            view: view,
            interactor: interactor,
            router: router,
            openPanelFactory: openPanelFactory,
            userDefaults: userDefaults
        )
    }
    
    // MARK: - handleOpenPanelResponse methods

    @Test func handleOpenPanelResponse_openPanelCancelled() {
        interactor.reset()
        
        presenter.handleOpenPanelResponse(.cancel)

        verifyStroblMocksUnused()
    }
    
    @Test func handleOpenPanelResponse_fileSelected() {
        let url = URL(fileURLWithPath: "file")
        let directoyUrl = URL(fileURLWithPath: "directory")
        let openPanel = MockOpenPanel()
        openPanel.urlToReturn = url
        openPanel.directoryURL = directoyUrl
        presenter.openPanel = openPanel
        interactor.reset()
        openPanel.reset()

        presenter.handleOpenPanelResponse(.OK)

        verifyStroblMocksUnused(except: [.interactor, .userDefaults])
        #expect(interactor.calledMethods == [.fileToCompareSelectedUrlCalled])
        #expect(interactor.assignedParameters == [.url])
        #expect(interactor.url == url)
        #expect(userDefaults.calledMethods == [.setUrlForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .url])
        #expect(userDefaults.url == directoyUrl)
        #expect(userDefaults.defaultNames == ["Last Directory of File To Compare"])
    }
    
    // MARK: - ComparePresenterProtocol methods

    @Test func compareButtonPressed() throws {
        let expectedLastDirectoryUrl = userDefaults.lastDirectoryOfSelectedFileToCompare
        userDefaults.reset()
        
        presenter.compareButtonPressed()
        
        let panel = try #require(presenter.openPanel as? MockOpenPanel)
        #expect(panel.directoryURL == expectedLastDirectoryUrl)
        #expect(panel.allowsMultipleSelection == false)
        #expect(panel.canChooseDirectories == false)
        #expect(panel.canCreateDirectories == false)
        #expect(panel.canChooseFiles == true)
        #expect(panel.message == "Select Swift File to Compare Mock Against")
        verifyStroblMocksUnused(except: [.view, .userDefaults])
        #expect(view.calledMethods == [.openModalSheetWithOpenPanelCompletionHandlerHandlerCalled])
        #expect(view.assignedParameters == [.openPanel, .handler])
        #expect(view.openPanel != nil)
        #expect(view.handler != nil)
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName])
        #expect(userDefaults.defaultNames == ["Last Directory of File To Compare"])
    }

    // MARK: - CompareInteractorOutputProtocol methods
    
    @Test func showButton_viewNil() {
        presenter.view = nil
        
        presenter.showButton(false)
        
        verifyStroblMocksUnused()
    }

    @Test func showButton_flagFalse() {
        
        presenter.showButton(false)
        
        verifyStroblMocksUnused(except: [.view])
        #expect(view.calledMethods == [.showButtonFlagCalled])
        #expect(view.assignedParameters == [.flag])
        #expect(view.flag == false)
    }
    
    @Test func showButton_flagTrue() {
        
        presenter.showButton(true)
        
        verifyStroblMocksUnused(except: [.view])
        #expect(view.calledMethods == [.showButtonFlagCalled])
        #expect(view.assignedParameters == [.flag])
        #expect(view.flag == true)
    }
    
    @Test func reportErrorCondition_viewNil() {
        presenter.view = nil
        
        presenter.reportErrorCondition(with: "A", and: "B")
        
        verifyStroblMocksUnused()
    }

    @Test func reportErrorCondition() {
        let messageText = "MESSAGE-TEXT"
        let informativeText = "INFORMATIVE-TEXT"
        
        presenter.reportErrorCondition(with: messageText, and: informativeText)
        
        verifyStroblMocksUnused(except: [.view])
        #expect(view.calledMethods == [.reportErrorConditionWithMessageTextAndInformativeTextCalled])
        #expect(view.assignedParameters == [.messageText, .informativeText])
        #expect(view.messageText == messageText)
        #expect(view.informativeText == informativeText)
    }
    
    @Test func mockCodeForCompare_viewNil() {
        presenter.view = nil
        
        let string = presenter.mockCodeForCompare()
        
        #expect(string == "")
        verifyStroblMocksUnused()
    }
    
    @Test func mockCodeForCompare() {
        
        let string = presenter.mockCodeForCompare()
        
        #expect(string == mockCode)
        verifyStroblMocksUnused(except: [.view])
        #expect(view.calledMethods == [.mockCodeForCompareCalled])
        #expect(view.assignedParameters == [])
    }

    // MARK: - NSOpenSavePanelDelegate methods

    @Test func panelShouldEnableURL_xcassetsURL() throws {
        let url = try #require(URL(fileURLWithPath: "file:///Users/joe/App/Assets.xcassets/"))

        let result = presenter.panel(self, shouldEnable: url)
        
        #expect(result == false)
        verifyStroblMocksUnused()
    }

    @Test func panelShouldEnableURL_xcodeProjectFileURL() throws {
        let url = try #require(URL(fileURLWithPath: "file:///Users/joe/App/App.xcodeproj/"))

        let result = presenter.panel(self, shouldEnable: url)
        
        #expect(result == false)
        verifyStroblMocksUnused()
    }

    @Test func panelShouldEnableURL_swiftPackageManifestFileURL() throws {
        let url = try #require(URL(fileURLWithPath: "file:///Users/joe/App/Package.swift/"))

        let result = presenter.panel(self, shouldEnable: url)
        
        #expect(result == true)
        verifyStroblMocksUnused()
    }

    @Test func panelShouldEnableURL_directoryFileURL() throws {
        let url = try #require(URL(fileURLWithPath: #function).deletingLastPathComponent())

        let result = presenter.panel(self, shouldEnable: url)
        
        #expect(result == true)
        verifyStroblMocksUnused()
    }

}
