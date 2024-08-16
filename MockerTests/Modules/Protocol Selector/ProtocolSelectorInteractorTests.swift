//
//  ProtocolSelectorInteractorTests.swift
//  MockerTests
//
//  Created by Greg on 2/25/18.
//

import Testing
@testable import Mocker
import MacrosForStroblMocks

@MainActor
struct ProtocolSelectorInteractorTests {

    var presenter: MockProtocolSelectorInteractorOutput!
    
    init() async {
        presenter = MockProtocolSelectorInteractorOutput()
    }
    
    // MARK: - init
    
    @Test func testInit() {
        
        let interactor = ProtocolSelectorInteractor()
        interactor.presenter = presenter
    }

}
