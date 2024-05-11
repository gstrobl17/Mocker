//
//  MockFileParametersPresenterTests.swift
//  MockerTests
//
//  Created by Greg on 2/26/18.
//

import XCTest
@testable import Mocker

class MockFileParametersPresenterTests: XCTestCase {
    
    var view: MockMockFileParametersView!
    var interactor: MockMockFileParametersInteractorInput!
    var router: MockFileParametersWireframeProtocol!
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

        XCTAssertEqual(interactor.calledMethods, [.setProtocolNameProtocolNameCalled])
        XCTAssertEqual(interactor.assignedParameters, [.protocolName])
        XCTAssertEqual(interactor.protocolName, name)
        XCTAssertEqual(view.calledMethods, [])
    }

    func test_prefixUpdated() {
        let prefix = "PREFIX"
        
        presenter.prefixUpdated(to: prefix)
        
        XCTAssertEqual(interactor.calledMethods, [.prefixUpdatedToPrefixCalled])
        XCTAssertEqual(interactor.assignedParameters, [.prefix])
        XCTAssertEqual(interactor.prefix, prefix)
        XCTAssertEqual(view.calledMethods, [])
    }

    func test_includeHeaderFlagUpdated() {
        let includeHeader = true
        
        presenter.includeHeaderFlagUpdated(to: includeHeader)
        
        XCTAssertEqual(interactor.calledMethods, [.includeHeaderFlagUpdatedToFlagCalled])
        XCTAssertEqual(interactor.assignedParameters, [.flag])
        XCTAssertEqual(interactor.flag, includeHeader)
        XCTAssertEqual(view.calledMethods, [])
    }

    func test_stripTrailingProtocolFlagUpdated() {
        let stripTrailingProtocol = true
        
        presenter.stripTrailingProtocolFlagUpdated(to: stripTrailingProtocol)
        
        XCTAssertEqual(interactor.calledMethods, [.stripTrailingProtocolFlagUpdatedToFlagCalled])
        XCTAssertEqual(interactor.assignedParameters, [.flag])
        XCTAssertEqual(interactor.flag, stripTrailingProtocol)
        XCTAssertEqual(view.calledMethods, [])
    }

    func test_swiftlintAwareFlagUpdated() {
        let swiftlintAware = true
        
        presenter.swiftlintAwareFlagUpdated(to: swiftlintAware)
        
        XCTAssertEqual(interactor.calledMethods, [.swiftlintAwareFlagUpdatedToFlagCalled])
        XCTAssertEqual(interactor.assignedParameters, [.flag])
        XCTAssertEqual(interactor.flag, swiftlintAware)
        XCTAssertEqual(view.calledMethods, [])
    }

    func test_includeTestableImportFlagUpdated() {
        let includeTestableImport = true
        
        presenter.includeTestableImportFlagUpdated(to: includeTestableImport)
        
        XCTAssertEqual(interactor.calledMethods, [.includeTestableImportFlagUpdatedToFlagCalled])
        XCTAssertEqual(interactor.assignedParameters, [.flag])
        XCTAssertEqual(interactor.flag, includeTestableImport)
        XCTAssertEqual(view.calledMethods, [])
    }

    func test_trackPropertyActivityFlagUpdated() {
        let trackPropertyActivity = true
        
        presenter.trackPropertyActivityFlagUpdated(to: trackPropertyActivity)
        
        XCTAssertEqual(interactor.calledMethods, [.trackPropertyActivityFlagUpdatedToFlagCalled])
        XCTAssertEqual(interactor.assignedParameters, [.flag])
        XCTAssertEqual(interactor.flag, trackPropertyActivity)
        XCTAssertEqual(view.calledMethods, [])
    }

    func test_publicFlagUpdated() {
        let `public` = true
        
        presenter.publicFlagUpdated(to: `public`)
        
        XCTAssertEqual(interactor.calledMethods, [.publicFlagUpdatedToFlagCalled])
        XCTAssertEqual(interactor.assignedParameters, [.flag])
        XCTAssertEqual(interactor.flag, `public`)
        XCTAssertEqual(view.calledMethods, [])
    }

    func test_viewHasLoaded() {
        
        presenter.viewHasLoaded()
        
        XCTAssertEqual(interactor.calledMethods, [.viewHasLoadedCalled])
        XCTAssertEqual(interactor.assignedParameters, [])
        XCTAssertEqual(view.calledMethods, [])
    }

    // MARK: - MockFileParametersInteractorOutputProtocol methods -

    func test_setParameters() {
        let prefix = "PREFIX"
        let includeHeader = false
        let stripTrailingProtocol = false
        let swiftlintAware = false
        let includeTestableImport = false
        let trackPropertyActivity = true
        let `public` = false

        presenter.setParameters(prefix: prefix,
                                includeHeader: includeHeader,
                                stripTrailingProtocol: stripTrailingProtocol,
                                swiftlintAware: swiftlintAware,
                                includeTestableImport: includeTestableImport,
                                trackPropertyActivity: trackPropertyActivity,
                                public: `public`)

        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [.setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityPublicCalled])
        XCTAssertEqual(view.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .public])
        XCTAssertEqual(view.prefix, prefix)
        XCTAssertEqual(view.includeHeader, includeHeader)
        XCTAssertEqual(view.stripTrailingProtocol, stripTrailingProtocol)
        XCTAssertEqual(view.swiftlintAware, swiftlintAware)
        XCTAssertEqual(view.includeTestableImport, includeTestableImport)
        XCTAssertEqual(view.trackPropertyActivity, trackPropertyActivity)
        XCTAssertEqual(view.public, `public`)
    }

    func test_setName() {
        let name = "NAME"
        
        presenter.setName(name)
        
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [.setNameNameCalled])
        XCTAssertEqual(view.assignedParameters, [.name])
        XCTAssertEqual(view.name, name)
    }
}
