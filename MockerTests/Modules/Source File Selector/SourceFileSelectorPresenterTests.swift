//
//  SourceFileSelectorPresenterTests.swift
//  MockerTests
//
//  Created by Greg on 2/23/18.
//

import Testing
@testable import Mocker
import MacrosForStroblMocks

@MainActor @UsesStroblMocks
struct SourceFileSelectorPresenterTests {
    
    @StroblMock var view: MockSourceFileSelectorView!
    @StroblMock var interactor: MockSourceFileSelectorInteractorInput!
    var router: (any SourceFileSelectorWireframeProtocol)!
    var presenter: SourceFileSelectorPresenter!

    init() async {
        view = MockSourceFileSelectorView()
        interactor = MockSourceFileSelectorInteractorInput()
        router = SourceFileSelectorRouter()
        presenter = SourceFileSelectorPresenter(interface: view, interactor: interactor, router: router)
    }

    // MARK: - SourceFileSelectorPresenterProtocol methods
    
    @Test func viewHasLoaded() {
        
        presenter.viewHasLoaded()
        
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.viewHasLoadedCalled])
    }

}
