//
//  ProjectFileSelectorInteractorTests.swift
//  MockerTests
//
//  Created by Greg on 2/22/18.
//

import XCTest
@testable import Mocker

class ProjectFileSelectorInteractorTests: XCTestCase {

    var presenter: MockProjectFileSelectorInteractorOutput!

    override func setUp() {
        super.setUp()
        
        presenter = MockProjectFileSelectorInteractorOutput()
    }

    // MARK: - init -
    
    func testInit() {
        
        let interactor = ProjectFileSelectorInteractor()
        interactor.presenter = presenter
        
        XCTAssertEqual(presenter.calledMethods, [])
    }

    // MARK: - ProjectFileSelectorInteractorInputProtocol methods -
    
    func test_setURL() {
        let interactor = ProjectFileSelectorInteractor()
        interactor.presenter = presenter
        presenter.reset()
        let url = URL(fileURLWithPath: "file")
        
        interactor.setURL(url)
        
        XCTAssertEqual(presenter.calledMethods, [])
    }

    func test_projectFileSelected() {
        let url = URL(fileURLWithPath: "file")
        let interactor = ProjectFileSelectorInteractor()
        interactor.presenter = presenter
        interactor.url = url
        presenter.reset()
        
        interactor.projectFileSelected(url)

        XCTAssertEqual(presenter.calledMethods, [.showSelectedFileUrlCalled])
        XCTAssertEqual(presenter.assignedParameters, [.url])
        XCTAssertEqual(presenter.url, url)
    }

    func test_viewHasLoaded_noUrl() {
        let interactor = ProjectFileSelectorInteractor()
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.viewHasLoaded()
        
        XCTAssertEqual(presenter.calledMethods, [])
    }
    
    func test_viewHasLoaded_withUrl() {
        let interactor = ProjectFileSelectorInteractor()
        interactor.presenter = presenter
        presenter.reset()
        let url = URL(fileURLWithPath: "file")
        interactor.url = url
        
        interactor.viewHasLoaded()
        
        XCTAssertEqual(presenter.calledMethods, [.showSelectedFileUrlCalled])
        XCTAssertEqual(presenter.assignedParameters, [.url])
        XCTAssertEqual(presenter.url, url)
    }
}
