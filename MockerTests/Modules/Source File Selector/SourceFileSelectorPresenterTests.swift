//
//  SourceFileSelectorPresenterTests.swift
//  MockerTests
//
//  Created by Greg on 2/23/18.
//

import XCTest
@testable import Mocker

class SourceFileSelectorPresenterTests: XCTestCase {
    
    var view: MockSourceFileSelectorView!
    var interactor: MockSourceFileSelectorInteractorInput!
    var router: SourceFileSelectorWireframeProtocol!
    var presenter: SourceFileSelectorPresenter!

    override func setUp() {
        super.setUp()
        
        view = MockSourceFileSelectorView()
        interactor = MockSourceFileSelectorInteractorInput()
        router = SourceFileSelectorRouter()
        presenter = SourceFileSelectorPresenter(interface: view, interactor: interactor, router: router)
    }

    // MARK: - SourceFileSelectorPresenterProtocol methods -
    
    func test_viewHasLoaded() {
        
        presenter.viewHasLoaded()
        
        XCTAssertEqual(interactor.calledMethods, [.viewHasLoadedCalled])
    }

}
