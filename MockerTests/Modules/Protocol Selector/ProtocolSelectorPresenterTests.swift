//
//  ProtocolSelectorPresenterTests.swift
//  MockerTests
//
//  Created by Greg on 2/25/18.
//

import XCTest
@testable import Mocker
import MacrosForStroblMocks

@UsesStroblMocks
class ProtocolSelectorPresenterTests: XCTestCase {
    
    @StroblMock var view: MockProtocolSelectorView!
    var interactor: MockProtocolSelectorInteractorInput!
    var router: ProtocolSelectorWireframeProtocol!
    var presenter: ProtocolSelectorPresenter!
    
    override func setUp() {
        super.setUp()
        
        view = MockProtocolSelectorView()
        interactor = MockProtocolSelectorInteractorInput()
        router = ProtocolSelectorRouter()
        presenter = ProtocolSelectorPresenter(interface: view, interactor: interactor, router: router)
    }

    func testNothing() {
        
        verifyStroblMocksUnused()
    }
}
