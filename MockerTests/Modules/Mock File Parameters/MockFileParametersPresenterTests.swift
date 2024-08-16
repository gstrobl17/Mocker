//
//  MockFileParametersPresenterTests.swift
//  MockerTests
//
//  Created by Greg on 2/26/18.
//

import Testing
@testable import Mocker
import MacrosForStroblMocks

@MainActor @UsesStroblMocks
struct MockFileParametersPresenterTests {
    
    @StroblMock var view: MockMockFileParametersView!
    @StroblMock var interactor: MockMockFileParametersInteractorInput!
    var router: (any MockFileParametersWireframeProtocol)!
    var presenter: MockFileParametersPresenter!
    
    init() async {
        view = MockMockFileParametersView()
        interactor = MockMockFileParametersInteractorInput()
        router = MockFileParametersRouter()
        presenter = MockFileParametersPresenter(interface: view, interactor: interactor, router: router)
    }
    
    // MARK: - MockFileParametersPresenterProtocol methods

    @Test func setProtocolName() {
        let name = "PROTOCOL NAME"
        
        presenter.setProtocolName(name)

        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.setProtocolNameProtocolNameCalled])
        #expect(interactor.assignedParameters == [.protocolName])
        #expect(interactor.protocolName == name)
    }

    @Test func test_prefixUpdated() {
        let prefix = "PREFIX"
        
        presenter.prefixUpdated(to: prefix)
        
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.prefixUpdatedToPrefixCalled])
        #expect(interactor.assignedParameters == [.prefix])
        #expect(interactor.prefix == prefix)
    }

    @Test func test_includeHeaderFlagUpdated() {
        let includeHeader = true
        
        presenter.includeHeaderFlagUpdated(to: includeHeader)
        
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.includeHeaderFlagUpdatedToFlagCalled])
        #expect(interactor.assignedParameters == [.flag])
        #expect(interactor.flag == includeHeader)
    }

    @Test func test_stripTrailingProtocolFlagUpdated() {
        let stripTrailingProtocol = true
        
        presenter.stripTrailingProtocolFlagUpdated(to: stripTrailingProtocol)
        
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.stripTrailingProtocolFlagUpdatedToFlagCalled])
        #expect(interactor.assignedParameters == [.flag])
        #expect(interactor.flag == stripTrailingProtocol)
    }

    @Test func test_includeTestableImportFlagUpdated() {
        let includeTestableImport = true
        
        presenter.includeTestableImportFlagUpdated(to: includeTestableImport)
        
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.includeTestableImportFlagUpdatedToFlagCalled])
        #expect(interactor.assignedParameters == [.flag])
        #expect(interactor.flag == includeTestableImport)
    }

    @Test func test_trackPropertyActivityFlagUpdated() {
        let trackPropertyActivity = true
        
        presenter.trackPropertyActivityFlagUpdated(to: trackPropertyActivity)
        
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.trackPropertyActivityFlagUpdatedToFlagCalled])
        #expect(interactor.assignedParameters == [.flag])
        #expect(interactor.flag == trackPropertyActivity)
    }

    @Test func test_publicFlagUpdated() {
        let `public` = true
        
        presenter.publicFlagUpdated(to: `public`)
        
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.publicFlagUpdatedToFlagCalled])
        #expect(interactor.assignedParameters == [.flag])
        #expect(interactor.flag == `public`)
    }

    @Test func test_viewHasLoaded() {
        
        presenter.viewHasLoaded()
        
        verifyStroblMocksUnused(except: [.interactor])
        #expect(interactor.calledMethods == [.viewHasLoadedCalled])
        #expect(interactor.assignedParameters == [])
    }

    // MARK: - MockFileParametersInteractorOutputProtocol methods -

    @Test func test_setParameters() {
        let prefix = "PREFIX"
        let includeHeader = false
        let stripTrailingProtocol = false
        let includeTestableImport = false
        let trackPropertyActivity = true
        let `public` = false

        presenter.setParameters(prefix: prefix,
                                includeHeader: includeHeader,
                                stripTrailingProtocol: stripTrailingProtocol,
                                includeTestableImport: includeTestableImport,
                                trackPropertyActivity: trackPropertyActivity,
                                public: `public`)

        verifyStroblMocksUnused(except: [.view])
        #expect(view.calledMethods == [.setParametersPrefixIncludeHeaderStripTrailingProtocolIncludeTestableImportTrackPropertyActivityPublicCalled])
        #expect(view.assignedParameters == [.prefix, .includeHeader, .stripTrailingProtocol, .includeTestableImport, .trackPropertyActivity, .public])
        #expect(view.prefix == prefix)
        #expect(view.includeHeader == includeHeader)
        #expect(view.stripTrailingProtocol == stripTrailingProtocol)
        #expect(view.includeTestableImport == includeTestableImport)
        #expect(view.trackPropertyActivity == trackPropertyActivity)
        #expect(view.public == `public`)
    }

    @Test func test_setName() {
        let name = "NAME"
        
        presenter.setName(name)
        
        verifyStroblMocksUnused(except: [.view])
        #expect(view.calledMethods == [.setNameNameCalled])
        #expect(view.assignedParameters == [.name])
        #expect(view.name == name)
    }
}
