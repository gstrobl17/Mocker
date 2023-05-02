//
//  ProjectFileSelectorPresenterTests.swift
//  MockerTests
//
//  Created by Greg on 2/22/18.
//

import XCTest
@testable import Mocker

class ProjectFileSelectorPresenterTests: XCTestCase {
    
    var view: MockProjectFileSelectorView!
    var interactor: MockProjectFileSelectorInteractorInput!
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

        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [])
    }
    
    func test_handleOpenPanelResponse_fileSelected() {
        let url = URL(fileURLWithPath: "file")
        let openPanel = MockOpenPanel()
        openPanel.urlToReturn = url
        presenter.openPanel = openPanel
        interactor.reset()
        openPanel.reset()

        presenter.handleOpenPanelResponse(.OK)

        XCTAssertEqual(interactor.calledMethods, [.projectFileSelectedUrlCalled])
        XCTAssertEqual(interactor.assignedParameters, [.url])
        XCTAssertEqual(interactor.url, url)
        XCTAssertEqual(view.calledMethods, [])
    }
    
    // MARK: - ProjectFileSelectorPresenterProtocol methods -
    
    func test_setURL() {
        let url = URL(fileURLWithPath: "file")

        presenter.setURL(url)
        
        XCTAssertEqual(interactor.calledMethods, [.setURLUrlCalled])
        XCTAssertEqual(interactor.assignedParameters, [.url])
        XCTAssertEqual(interactor.url, url)
        XCTAssertEqual(view.calledMethods, [])
    }

    func test_selectPressed() {
        
        presenter.selectPressed()
        
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [.openModalSheetWithOpenPanelCompletionHandlerHandlerCalled])
        XCTAssertEqual(view.assignedParameters, [.openPanel, .handler])
        XCTAssertNotNil(view.openPanel)
        XCTAssertNotNil(view.handler)
    }
    
    func test_reloadPressed_noURLSet() {
        
        presenter.reloadPressed()
        
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [])
    }
    
    func test_reloadPressed_urlSet() {
        let url = URL(fileURLWithPath: "file")
        interactor.url = url

        presenter.reloadPressed()
        
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [.showSelectedFileUrlCalled])
        XCTAssertEqual(view.assignedParameters, [.url])
    }
    
    func test_canReloadProject_noURLSet() {
        
        let flag = presenter.canReloadProject()
        
        XCTAssertEqual(flag, false)
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [])
    }
    
    func test_canReloadProject_urlSet() {
        let url = URL(fileURLWithPath: "file")
        interactor.url = url

        let flag = presenter.canReloadProject()
        
        XCTAssertEqual(flag, true)
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [])
    }

    func test_viewHasLoaded() {
        
        presenter.viewHasLoaded()
        
        XCTAssertEqual(interactor.calledMethods, [.viewHasLoadedCalled])
        XCTAssertEqual(interactor.assignedParameters, [])
        XCTAssertEqual(view.calledMethods, [])
    }

    // MARK: - ProjectFileSelectorInteractorOutputProtocol methods -
    
    func test_showSelectedFile() {
        let url = URL(fileURLWithPath: "file")
        
        presenter.showSelectedFile(url)
        
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [.showSelectedFileUrlCalled])
        XCTAssertEqual(view.assignedParameters, [.url])
    }

}
