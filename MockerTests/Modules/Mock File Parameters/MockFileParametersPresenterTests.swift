//
//  MockFileParametersPresenterTests.swift
//  MockerTests
//
//  Created by Greg on 2/26/18.
//

import XCTest
@testable import Mocker
import MacrosForStroblMocks

@UsesStroblMocks
class MockFileParametersPresenterTests: XCTestCase {
    
    @StroblMock var view: MockMockFileParametersView!
    @StroblMock var interactor: MockMockFileParametersInteractorInput!
    var router: (any MockFileParametersWireframeProtocol)!
    var presenter: MockFileParametersPresenter!
    
    override func setUp() {
        super.setUp()
        
        view = MockMockFileParametersView()
        interactor = MockMockFileParametersInteractorInput()
        router = MockFileParametersRouter()
        presenter = MockFileParametersPresenter(interface: view, interactor: interactor, router: router)
    }
    
    // MARK: - MockFileParametersPresenterProtocol methods -

    func test_setProtocolName() {
        let name = "PROTOCOL NAME"
        
        presenter.setProtocolName(name)

        verifyStroblMocksUnused(except: [.interactor])
        XCTAssertEqual(interactor.calledMethods, [.setProtocolNameProtocolNameCalled])
        XCTAssertEqual(interactor.assignedParameters, [.protocolName])
        XCTAssertEqual(interactor.protocolName, name)
    }

    func test_prefixUpdated() {
        let prefix = "PREFIX"
        
        presenter.prefixUpdated(to: prefix)
        
        verifyStroblMocksUnused(except: [.interactor])
        XCTAssertEqual(interactor.calledMethods, [.prefixUpdatedToPrefixCalled])
        XCTAssertEqual(interactor.assignedParameters, [.prefix])
        XCTAssertEqual(interactor.prefix, prefix)
    }

    func test_includeHeaderFlagUpdated() {
        let includeHeader = true
        
        presenter.includeHeaderFlagUpdated(to: includeHeader)
        
        verifyStroblMocksUnused(except: [.interactor])
        XCTAssertEqual(interactor.calledMethods, [.includeHeaderFlagUpdatedToFlagCalled])
        XCTAssertEqual(interactor.assignedParameters, [.flag])
        XCTAssertEqual(interactor.flag, includeHeader)
    }

    func test_stripTrailingProtocolFlagUpdated() {
        let stripTrailingProtocol = true
        
        presenter.stripTrailingProtocolFlagUpdated(to: stripTrailingProtocol)
        
        verifyStroblMocksUnused(except: [.interactor])
        XCTAssertEqual(interactor.calledMethods, [.stripTrailingProtocolFlagUpdatedToFlagCalled])
        XCTAssertEqual(interactor.assignedParameters, [.flag])
        XCTAssertEqual(interactor.flag, stripTrailingProtocol)
    }

    func test_includeTestableImportFlagUpdated() {
        let includeTestableImport = true
        
        presenter.includeTestableImportFlagUpdated(to: includeTestableImport)
        
        verifyStroblMocksUnused(except: [.interactor])
        XCTAssertEqual(interactor.calledMethods, [.includeTestableImportFlagUpdatedToFlagCalled])
        XCTAssertEqual(interactor.assignedParameters, [.flag])
        XCTAssertEqual(interactor.flag, includeTestableImport)
    }

    func test_trackPropertyActivityFlagUpdated() {
        let trackPropertyActivity = true
        
        presenter.trackPropertyActivityFlagUpdated(to: trackPropertyActivity)
        
        verifyStroblMocksUnused(except: [.interactor])
        XCTAssertEqual(interactor.calledMethods, [.trackPropertyActivityFlagUpdatedToFlagCalled])
        XCTAssertEqual(interactor.assignedParameters, [.flag])
        XCTAssertEqual(interactor.flag, trackPropertyActivity)
    }

    func test_publicFlagUpdated() {
        let `public` = true
        
        presenter.publicFlagUpdated(to: `public`)
        
        verifyStroblMocksUnused(except: [.interactor])
        XCTAssertEqual(interactor.calledMethods, [.publicFlagUpdatedToFlagCalled])
        XCTAssertEqual(interactor.assignedParameters, [.flag])
        XCTAssertEqual(interactor.flag, `public`)
    }

    func test_viewHasLoaded() {
        
        presenter.viewHasLoaded()
        
        verifyStroblMocksUnused(except: [.interactor])
        XCTAssertEqual(interactor.calledMethods, [.viewHasLoadedCalled])
        XCTAssertEqual(interactor.assignedParameters, [])
    }

    // MARK: - MockFileParametersInteractorOutputProtocol methods -

    func test_setParameters() {
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
        XCTAssertEqual(view.calledMethods, [.setParametersPrefixIncludeHeaderStripTrailingProtocolIncludeTestableImportTrackPropertyActivityPublicCalled])
        XCTAssertEqual(view.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .includeTestableImport, .trackPropertyActivity, .public])
        XCTAssertEqual(view.prefix, prefix)
        XCTAssertEqual(view.includeHeader, includeHeader)
        XCTAssertEqual(view.stripTrailingProtocol, stripTrailingProtocol)
        XCTAssertEqual(view.includeTestableImport, includeTestableImport)
        XCTAssertEqual(view.trackPropertyActivity, trackPropertyActivity)
        XCTAssertEqual(view.public, `public`)
    }

    func test_setName() {
        let name = "NAME"
        
        presenter.setName(name)
        
        verifyStroblMocksUnused(except: [.view])
        XCTAssertEqual(view.calledMethods, [.setNameNameCalled])
        XCTAssertEqual(view.assignedParameters, [.name])
        XCTAssertEqual(view.name, name)
    }
}
