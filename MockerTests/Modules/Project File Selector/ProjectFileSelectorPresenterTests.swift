//
//  ProjectFileSelectorPresenterTests.swift
//  MockerTests
//
//  Created by Greg on 2/22/18.
//

import Testing
import Foundation
@testable import Mocker
import MacrosForStroblMocks

@MainActor @UsesStroblMocks
struct ProjectFileSelectorPresenterTests {
    
    @StroblMock var view: MockProjectFileSelectorView!
    @StroblMock var interactor: MockProjectFileSelectorInteractorInput!
    var router: (any ProjectFileSelectorWireframeProtocol)!
    var presenter: ProjectFileSelectorPresenter!
    let openPanelFactory = MockOpenPanelFactory()
    @StroblMock var userDefaults: MockUserDefaults!

    init() async {
        userDefaults = MockUserDefaults()
        view = MockProjectFileSelectorView()
        interactor = MockProjectFileSelectorInteractorInput()
        router = ProjectFileSelectorRouter()
        presenter = ProjectFileSelectorPresenter(
            interface: view,
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
        #expect(interactor.calledMethods == [.projectFileSelectedUrlCalled])
        #expect(interactor.assignedParameters == [.url])
        #expect(interactor.url == url)
        #expect(userDefaults.calledMethods == [.setUrlForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .url])
        #expect(userDefaults.url == directoyUrl)
        #expect(userDefaults.defaultNames == ["Last Directory of Selected Project", "Last Directory of File To Compare"])
    }
    
    // MARK: - ProjectFileSelectorPresenterProtocol methods
    
    @Test func setURL() {
        let url = URL(fileURLWithPath: "file")

        presenter.setURL(url)
        
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.setURLUrlCalled])
        #expect(interactor.assignedParameters == [.url])
        #expect(interactor.url == url)
    }

    @Test func selectPressed() throws {
        let expectedLastDirectoryUrl = userDefaults.lastDirectoryOfSelectedProject
        userDefaults.reset()
        
        presenter.selectPressed()
        
        let panel = try #require(presenter.openPanel as? MockOpenPanel)
        #expect(panel.directoryURL == expectedLastDirectoryUrl)
        #expect(panel.allowsMultipleSelection == false)
        #expect(panel.canChooseDirectories == true)
        #expect(panel.canCreateDirectories == false)
        #expect(panel.canChooseFiles == true)
        #expect(panel.message == "Select Directory, Project, or Swift Package to Open")
        verifyStroblMocksUnused(except: [.view, .userDefaults])
        #expect(view.calledMethods == [.openModalSheetWithOpenPanelCompletionHandlerHandlerCalled])
        #expect(view.assignedParameters == [.openPanel, .handler])
        #expect(view.openPanel != nil)
        #expect(view.handler != nil)
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName])
        #expect(userDefaults.defaultNames == ["Last Directory of Selected Project"])
    }
    
    @Test func reloadPressed_noURLSet() {
        
        presenter.reloadPressed()
        
        verifyStroblMocksUnused()
    }
    
    @Test func reloadPressed_urlSet() {
        let url = URL(fileURLWithPath: "file")
        interactor.url = url

        presenter.reloadPressed()
        
        verifyStroblMocksUnused(except: [.view])
        #expect(view.calledMethods == [.showSelectedFileUrlCalled])
        #expect(view.assignedParameters == [.url])
    }
    
    @Test func canReloadProject_noURLSet() {
        
        let flag = presenter.canReloadProject()
        
        #expect(flag == false)
        verifyStroblMocksUnused()
    }
    
    @Test func canReloadProject_urlSet() {
        let url = URL(fileURLWithPath: "file")
        interactor.url = url

        let flag = presenter.canReloadProject()
        
        #expect(flag == true)
        verifyStroblMocksUnused()
    }

    @Test func viewHasLoaded() {
        
        presenter.viewHasLoaded()
        
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.viewHasLoadedCalled])
        #expect(interactor.assignedParameters == [])
    }

    // MARK: - ProjectFileSelectorInteractorOutputProtocol methods
    
    @Test func showSelectedFile() {
        let url = URL(fileURLWithPath: "file")
        
        presenter.showSelectedFile(url)
        
        verifyStroblMocksUnused(except: [.view])
        #expect(view.calledMethods == [.showSelectedFileUrlCalled])
        #expect(view.assignedParameters == [.url])
    }

    // MARK: - NSOpenSavePanelDelegate methods -

    @Test func panelShouldEnableURL_xcassetsURL() throws {
        let url = try #require(URL(fileURLWithPath: "file:///Users/joe/App/Assets.xcassets/"))

        let result = presenter.panel(self, shouldEnable: url)
        
        #expect(result == false)
        verifyStroblMocksUnused()
    }

    @Test func panelShouldEnableURL_xcodeProjectFileURL() throws {
        let url = try #require(URL(fileURLWithPath: "file:///Users/joe/App/App.xcodeproj/"))

        let result = presenter.panel(self, shouldEnable: url)
        
        #expect(result == true)
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
