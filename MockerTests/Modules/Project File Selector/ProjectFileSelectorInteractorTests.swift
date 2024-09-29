//
//  ProjectFileSelectorInteractorTests.swift
//  MockerTests
//
//  Created by Greg on 2/22/18.
//

import Testing
import Foundation
@testable import Mocker
import MacrosForStroblMocks

@MainActor @UsesStroblMocks
struct ProjectFileSelectorInteractorTests {

    @StroblMock var presenter: MockProjectFileSelectorInteractorOutput!
    var interactor: ProjectFileSelectorInteractor!

    init() async {
        presenter = MockProjectFileSelectorInteractorOutput()
        interactor = ProjectFileSelectorInteractor()
        interactor.presenter = presenter
    }

    // MARK: - init
    
    @Test func testInit() {
        
        let interactor = ProjectFileSelectorInteractor()
        interactor.presenter = presenter
        
        verifyStroblMocksUnused()
    }
    
    @Test func testInit_urlSetThenPresenterSet() {
        let url = URL(fileURLWithPath: "file")

        let interactor = ProjectFileSelectorInteractor()
        interactor.url = url
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter])
        #expect(presenter.calledMethods == [.showSelectedFileUrlCalled])
        #expect(presenter.assignedParameters == [.url])
        #expect(presenter.url == url)
    }

    // MARK: - ProjectFileSelectorInteractorInputProtocol methods
    
    @Test func setURL() {
        let url = URL(fileURLWithPath: "file")
        
        interactor.setURL(url)
        
        verifyStroblMocksUnused()
    }

    @Test func projectFileSelected() {
        let url = URL(fileURLWithPath: "file")
        interactor.url = url
        
        interactor.projectFileSelected(url)

        verifyStroblMocksUnused(except: [.presenter])
        #expect(presenter.calledMethods == [.showSelectedFileUrlCalled])
        #expect(presenter.assignedParameters == [.url])
        #expect(presenter.url == url)
    }

    @Test func viewHasLoaded_noUrl() {
        
        interactor.viewHasLoaded()
        
        verifyStroblMocksUnused()
    }
    
    @Test func viewHasLoaded_withUrl() {
        let url = URL(fileURLWithPath: "file")
        interactor.url = url
        
        interactor.viewHasLoaded()
        
        verifyStroblMocksUnused(except: [.presenter])
        #expect(presenter.calledMethods == [.showSelectedFileUrlCalled])
        #expect(presenter.assignedParameters == [.url])
        #expect(presenter.url == url)
    }
}
