//
//  ProtocolSelectorPresenterTests.swift
//  MockerTests
//
//  Created by Greg on 2/25/18.
//

import Testing
@testable import Mocker
import MacrosForStroblMocks

@MainActor @UsesStroblMocks
struct ProtocolSelectorPresenterTests {
    
    @StroblMock var view: MockProtocolSelectorView!
    var interactor: MockProtocolSelectorInteractorInput!
    var router: (any ProtocolSelectorWireframeProtocol)!
    var presenter: ProtocolSelectorPresenter!
    
    init() async {
        view = MockProtocolSelectorView()
        interactor = MockProtocolSelectorInteractorInput()
        router = ProtocolSelectorRouter()
        presenter = ProtocolSelectorPresenter(interface: view, interactor: interactor, router: router)
    }

    @Test func nothing() {
        
        verifyStroblMocksUnused()
    }
}
