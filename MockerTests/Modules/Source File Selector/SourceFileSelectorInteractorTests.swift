//
//  SourceFileSelectorInteractorTests.swift
//  MockerTests
//
//  Created by Greg on 2/23/18.
//

import XCTest
@testable import Mocker

class SourceFileSelectorInteractorTests: XCTestCase {

    var presenter: MockSourceFileSelectorInteractorOutput!

    override func setUp() {
        super.setUp()
        
        presenter = MockSourceFileSelectorInteractorOutput()
    }

    // MARK: - init -
    
    func testInit() {
        
        let interactor = SourceFileSelectorInteractor()
        interactor.presenter = presenter
        
    }

    // MARK: - SourceFileSelectorInteractorInputProtocol methods -

    @MainActor
    func test_viewHasLoaded() {
        let interactor = SourceFileSelectorInteractor()
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.viewHasLoaded()
        
    }
}
