//
//  GodfatherRouterTests.swift
//  MockerTests
//
//  Created by Greg on 2/24/18.
//

import XCTest
import AppKit
@testable import Mocker

class GodfatherRouterTests: XCTestCase {

    let userDefaults = MockUserDefaults()
    let fileManager = MockFileManager()
    let projectFactory = MockProjectFactory()
    let mockGeneratorFactory = MockMockGeneratorFactory()
    let openPanelFactory = MockOpenPanelFactory()
    let filteringHandler = MockAsyncFilteringHandler()
    let recentDocumentManager = MockRecentDocumentManaging()
    let documentController = MockDocumentControlling()

    func testCreateModule() {
        let viewController = ViewController()
        
        let view = GodfatherRouter.createModule(
            viewController: viewController,
            userDefaults: userDefaults,
            fileManager: fileManager,
            projectFactory: projectFactory,
            mockGeneratorFactory: mockGeneratorFactory,
            openPanelFactory: openPanelFactory,
            projectFileSelectorRouterType: MockProjectFileSelectorRouter.self,
            sourceFileSelectorRouterType: MockSourceFileSelectorRouter.self,
            sourceFileFilterRouterType: MockFilterWireframe.self,
            protocolSelectorRouterType: MockProtocolSelectorRouter.self,
            mockFileParametersRouterType: MockMockFileParametersRouter.self,
            contentPresenterRouterType: MockContentPresenterRouter.self,
            fileSynthesisRouterRouterType: MockFileSynthesisRouter.self,
            destinationGroupSelectorRouterType: MockDestinationGroupSelectorRouter.self,
            filteringHandler: filteringHandler,
            recentDocumentManager: recentDocumentManager,
            documentController: documentController
        )
        XCTAssertNotNil(view.presenter)
        if let presenter = view.presenter {
            XCTAssertTrue(presenter is GodfatherPresenter)
            if let presenter = presenter as? GodfatherPresenter {
                XCTAssertNotNil(presenter.router.view)
                XCTAssertTrue(presenter.router.view === view)
            }
        }
    }
}
