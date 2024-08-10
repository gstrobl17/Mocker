//
//  ProjectFileSelectorPresenterTests.swift
//  MockerTests
//
//  Created by Greg on 2/22/18.
//

import XCTest
@testable import Mocker
import MacrosForStroblMocks

@UsesStroblMocks
class ProjectFileSelectorPresenterTests: XCTestCase {
    
    @StroblMock var view: MockProjectFileSelectorView!
    @StroblMock var interactor: MockProjectFileSelectorInteractorInput!
    var router: ProjectFileSelectorWireframeProtocol!
    var presenter: ProjectFileSelectorPresenter!
    let openPanelFactory = MockOpenPanelFactory()

    override func setUp() {
        super.setUp()
        
        view = MockProjectFileSelectorView()
        interactor = MockProjectFileSelectorInteractorInput()
        router = ProjectFileSelectorRouter()
        presenter = ProjectFileSelectorPresenter(interface: view, interactor: interactor, router: router, openPanelFactory: openPanelFactory)
    }
    
    // MARK: - handleOpenPanelResponse methods -

    func test_handleOpenPanelResponse_openPanelCancelled() {
        interactor.reset()
        
        presenter.handleOpenPanelResponse(.cancel)

        verifyStroblMocksUnused()
    }
    
    func test_handleOpenPanelResponse_fileSelected() {
        let url = URL(fileURLWithPath: "file")
        let openPanel = MockOpenPanel()
        openPanel.urlToReturn = url
        presenter.openPanel = openPanel
        interactor.reset()
        openPanel.reset()

        presenter.handleOpenPanelResponse(.OK)

        verifyStroblMocksUnused(except: [.interactor])
        XCTAssertEqual(interactor.calledMethods, [.projectFileSelectedUrlCalled])
        XCTAssertEqual(interactor.assignedParameters, [.url])
        XCTAssertEqual(interactor.url, url)
    }
    
    // MARK: - ProjectFileSelectorPresenterProtocol methods -
    
    func test_setURL() {
        let url = URL(fileURLWithPath: "file")

        presenter.setURL(url)
        
        verifyStroblMocksUnused(except: [.interactor])
        XCTAssertEqual(interactor.calledMethods, [.setURLUrlCalled])
        XCTAssertEqual(interactor.assignedParameters, [.url])
        XCTAssertEqual(interactor.url, url)
    }

    func test_selectPressed() {
        
        presenter.selectPressed()
        
        verifyStroblMocksUnused(except: [.view])
        XCTAssertEqual(view.calledMethods, [.openModalSheetWithOpenPanelCompletionHandlerHandlerCalled])
        XCTAssertEqual(view.assignedParameters, [.openPanel, .handler])
        XCTAssertNotNil(view.openPanel)
        XCTAssertNotNil(view.handler)
    }
    
    func test_reloadPressed_noURLSet() {
        
        presenter.reloadPressed()
        
        verifyStroblMocksUnused()
    }
    
    func test_reloadPressed_urlSet() {
        let url = URL(fileURLWithPath: "file")
        interactor.url = url

        presenter.reloadPressed()
        
        verifyStroblMocksUnused(except: [.view])
        XCTAssertEqual(view.calledMethods, [.showSelectedFileUrlCalled])
        XCTAssertEqual(view.assignedParameters, [.url])
    }
    
    func test_canReloadProject_noURLSet() {
        
        let flag = presenter.canReloadProject()
        
        XCTAssertEqual(flag, false)
        verifyStroblMocksUnused()
    }
    
    func test_canReloadProject_urlSet() {
        let url = URL(fileURLWithPath: "file")
        interactor.url = url

        let flag = presenter.canReloadProject()
        
        XCTAssertEqual(flag, true)
        verifyStroblMocksUnused()
    }

    func test_viewHasLoaded() {
        
        presenter.viewHasLoaded()
        
        verifyStroblMocksUnused(except: [.interactor])
        XCTAssertEqual(interactor.calledMethods, [.viewHasLoadedCalled])
        XCTAssertEqual(interactor.assignedParameters, [])
    }

    // MARK: - ProjectFileSelectorInteractorOutputProtocol methods -
    
    func test_showSelectedFile() {
        let url = URL(fileURLWithPath: "file")
        
        presenter.showSelectedFile(url)
        
        verifyStroblMocksUnused(except: [.view])
        XCTAssertEqual(view.calledMethods, [.showSelectedFileUrlCalled])
        XCTAssertEqual(view.assignedParameters, [.url])
    }

    // MARK: - NSOpenSavePanelDelegate methods -

    func testPanelShouldEnableURL_xcassetsURL() throws {
        let url = try XCTUnwrap(URL(fileURLWithPath: "file:///Users/joe/App/Assets.xcassets/"))

        let result = presenter.panel(self, shouldEnable: url)
        
        XCTAssertEqual(result, false)
        verifyStroblMocksUnused()
    }

    func testPanelShouldEnableURL_xcodeProjectFileURL() throws {
        let url = try XCTUnwrap(URL(fileURLWithPath: "file:///Users/joe/App/App.xcodeproj/"))

        let result = presenter.panel(self, shouldEnable: url)
        
        XCTAssertEqual(result, true)
        verifyStroblMocksUnused()
    }

    func testPanelShouldEnableURL_swiftPackageManifestFileURL() throws {
        let url = try XCTUnwrap(URL(fileURLWithPath: "file:///Users/joe/App/Package.swift/"))

        let result = presenter.panel(self, shouldEnable: url)
        
        XCTAssertEqual(result, true)
        verifyStroblMocksUnused()
    }

    func testPanelShouldEnableURL_directoryFileURL() throws {
        let url = try XCTUnwrap(URL(fileURLWithPath: #function).deletingLastPathComponent())

        let result = presenter.panel(self, shouldEnable: url)
        
        XCTAssertEqual(result, true)
        verifyStroblMocksUnused()
    }

}
