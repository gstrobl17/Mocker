//
//  GodfatherRouterTests.swift
//  MockerTests
//
//  Created by Greg on 2/24/18.
//

import Testing
import AppKit
@testable import Mocker
import MacrosForStroblMocks

@MainActor @UsesStroblMocks
struct GodfatherRouterTests {

    @StroblMock let userDefaults = MockUserDefaults()
    @StroblMock let fileManager = MockFileManager()
    @StroblMock let dataSourceFactory = MockSourceFileDataSourceCreating()
    let mockGeneratorFactory = MockMockGeneratorFactory()
    let openPanelFactory = MockOpenPanelFactory()
    @StroblMock let filteringHandler = MockAsyncFilteringHandler()
    @StroblMock let recentDocumentManager = MockRecentDocumentManaging()
    @StroblMock let documentController = MockDocumentControlling()

    @Test func createModule() throws {
        let viewController = ViewController()
        
        let view = GodfatherRouter.createModule(
            viewController: viewController,
            userDefaults: userDefaults,
            fileManager: fileManager,
            dataSourceFactory: dataSourceFactory,
            mockGeneratorFactory: mockGeneratorFactory,
            openPanelFactory: openPanelFactory,
            projectFileSelectorRouterType: MockProjectFileSelectorRouter.self,
            sourceFileSelectorRouterType: MockSourceFileSelectorRouter.self,
            sourceFileFilterRouterType: MockFilterWireframe.self,
            protocolSelectorRouterType: MockProtocolSelectorRouter.self,
            mockFileParametersRouterType: MockMockFileParametersRouter.self,
            contentPresenterRouterType: MockContentPresenterRouter.self,
            filteringHandler: filteringHandler,
            recentDocumentManager: recentDocumentManager,
            documentController: documentController
        )
        
        verifyStroblMocksUnused()
        let presenter = try #require(view.presenter as? GodfatherPresenter)
        #expect(presenter.router.view != nil)
        #expect(presenter.router.view === view)
    }
}
