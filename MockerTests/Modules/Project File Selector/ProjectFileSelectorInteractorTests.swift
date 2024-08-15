//
//  ProjectFileSelectorInteractorTests.swift
//  MockerTests
//
//  Created by Greg on 2/22/18.
//

import XCTest
@testable import Mocker
import MacrosForStroblMocks

//TODO: resolve
//@UsesStroblMocks
//class ProjectFileSelectorInteractorTests: XCTestCase {
//
//    @StroblMock var presenter: MockProjectFileSelectorInteractorOutput!
//    var interactor: ProjectFileSelectorInteractor!
//
//    override func setUp() {
//        super.setUp()
//        
//        presenter = MockProjectFileSelectorInteractorOutput()
//        interactor = ProjectFileSelectorInteractor()
//        interactor.presenter = presenter
//    }
//
//    // MARK: - init -
//    
//    func testInit() {
//        
//        let interactor = ProjectFileSelectorInteractor()
//        interactor.presenter = presenter
//        
//        verifyStroblMocksUnused()
//    }
//
//    // MARK: - ProjectFileSelectorInteractorInputProtocol methods -
//    
//    func test_setURL() {
//        let url = URL(fileURLWithPath: "file")
//        
//        interactor.setURL(url)
//        
//        verifyStroblMocksUnused()
//    }
//
//    func test_projectFileSelected() {
//        let url = URL(fileURLWithPath: "file")
//        interactor.url = url
//        
//        interactor.projectFileSelected(url)
//
//        verifyStroblMocksUnused(except: [.presenter])
//        XCTAssertEqual(presenter.calledMethods, [.showSelectedFileUrlCalled])
//        XCTAssertEqual(presenter.assignedParameters, [.url])
//        XCTAssertEqual(presenter.url, url)
//    }
//
//    func test_viewHasLoaded_noUrl() {
//        
//        interactor.viewHasLoaded()
//        
//        verifyStroblMocksUnused()
//    }
//    
//    func test_viewHasLoaded_withUrl() {
//        let url = URL(fileURLWithPath: "file")
//        interactor.url = url
//        
//        interactor.viewHasLoaded()
//        
//        verifyStroblMocksUnused(except: [.presenter])
//        XCTAssertEqual(presenter.calledMethods, [.showSelectedFileUrlCalled])
//        XCTAssertEqual(presenter.assignedParameters, [.url])
//        XCTAssertEqual(presenter.url, url)
//    }
//}
