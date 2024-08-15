//
//  GodfatherRouterTests.swift
//  MockerTests
//
//  Created by Greg on 2/24/18.
//

import XCTest
import AppKit
@testable import Mocker
import MacrosForStroblMocks

//TODO: resolve
//@UsesStroblMocks
//class GodfatherRouterTests: XCTestCase {
//
//    @StroblMock let userDefaults = MockUserDefaults()
//    @StroblMock let fileManager = MockFileManager()
//    @StroblMock let dataSourceFactory = MockSourceFileDataSourceCreating()
//    let mockGeneratorFactory = MockMockGeneratorFactory()
//    let openPanelFactory = MockOpenPanelFactory()
//    @StroblMock let filteringHandler = MockAsyncFilteringHandler()
//    @StroblMock let recentDocumentManager = MockRecentDocumentManaging()
//    @StroblMock let documentController = MockDocumentControlling()
//
//    func testCreateModule() {
//        let viewController = ViewController()
//        
//        let view = GodfatherRouter.createModule(
//            viewController: viewController,
//            userDefaults: userDefaults,
//            fileManager: fileManager,
//            dataSourceFactory: dataSourceFactory,
//            mockGeneratorFactory: mockGeneratorFactory,
//            openPanelFactory: openPanelFactory,
//            projectFileSelectorRouterType: MockProjectFileSelectorRouter.self,
//            sourceFileSelectorRouterType: MockSourceFileSelectorRouter.self,
//            sourceFileFilterRouterType: MockFilterWireframe.self,
//            protocolSelectorRouterType: MockProtocolSelectorRouter.self,
//            mockFileParametersRouterType: MockMockFileParametersRouter.self,
//            contentPresenterRouterType: MockContentPresenterRouter.self,
//            filteringHandler: filteringHandler,
//            recentDocumentManager: recentDocumentManager,
//            documentController: documentController
//        )
//        
//        verifyStroblMocksUnused()
//        XCTAssertNotNil(view.presenter)
//        if let presenter = view.presenter {
//            XCTAssertTrue(presenter is GodfatherPresenter)
//            if let presenter = presenter as? GodfatherPresenter {
//                XCTAssertNotNil(presenter.router.view)
//                XCTAssertTrue(presenter.router.view === view)
//            }
//        }
//    }
//}
