//
//  ProtocolSelectorInteractorTests.swift
//  MockerTests
//
//  Created by Greg on 2/25/18.
//

import XCTest
@testable import Mocker

class ProtocolSelectorInteractorTests: XCTestCase {

    var presenter: MockProtocolSelectorInteractorOutput!
    
    override func setUp() {
        super.setUp()
        
        presenter = MockProtocolSelectorInteractorOutput()
    }
    
    // MARK: - init -
    
    func testInit() {
        
        let interactor = ProtocolSelectorInteractor()
        interactor.presenter = presenter
        
    }

}
