//swiftlint:disable type_body_length file_length
//
//  GodfatherInteractorTests.swift
//  MockerTests
//
//  Created by Greg on 2/24/18.
//

import XCTest
@testable import Mocker
import SwiftSyntax
import MacrosForStroblMocks

@UsesStroblMocks
class GodfatherInteractorTests: XCTestCase {

    @StroblMock var userDefaults: MockUserDefaults!
    @StroblMock var fileManager: MockFileManager!
    @StroblMock var presenter: MockGodfatherInteractorOutput!
    @StroblMock var dataSourceFactory: MockSourceFileDataSourceCreating!
    @StroblMock var dataSource: MockSourceFileDataSource!
    var mockGeneratorFactory: MockMockGeneratorFactory!
    @StroblMock var mockGenerator: MockMockGenerator!
    var openPanelFactory: (any OpenPanelFactory)!
    var projectFileSelectorRouterType: (any ProjectFileSelectorWireframeProtocol.Type)!
    @StroblMock var projectFileSelectorView: MockProjectFileSelectorView!
    var sourceFileSelectorRouterType: (any SourceFileSelectorWireframeProtocol.Type)!
    @StroblMock var sourceFileSelectorView: MockSourceFileSelectorView!
    var sourceFileFilterRouterType: (any FilterWireframeProtocol.Type)!
    var protocolSelectorRouterType: (any ProtocolSelectorWireframeProtocol.Type)!
    var mockFileParametersRouterType: (any MockFileParametersWireframeProtocol.Type)!
    @StroblMock var mockFileParametersView: MockMockFileParametersView!
    var contentPresenterRouterType: (any ContentPresenterWireframeProtocol.Type)!
    @StroblMock var filteringHandler: MockAsyncFilteringHandler!
    @StroblMock var recentDocumentManager: MockRecentDocumentManaging!
    @StroblMock var documentController: MockDocumentControlling!
    @StroblMock var pasteboard: MockPasteboard!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        userDefaults = MockUserDefaults()
        fileManager = MockFileManager()
        presenter = MockGodfatherInteractorOutput()
        dataSourceFactory = MockSourceFileDataSourceCreating()
        dataSource = try XCTUnwrap(dataSourceFactory.createDataSourceForFileURLReturnValue as? MockSourceFileDataSource)
        mockGeneratorFactory = MockMockGeneratorFactory()
        mockGenerator = mockGeneratorFactory.mockGenerator
        openPanelFactory = MockOpenPanelFactory()
        projectFileSelectorRouterType = MockProjectFileSelectorRouter.self
        projectFileSelectorView = MockProjectFileSelectorRouter.view
        projectFileSelectorView.reset()
        sourceFileSelectorRouterType = MockSourceFileSelectorRouter.self
        sourceFileSelectorView = MockSourceFileSelectorView()
        sourceFileFilterRouterType = MockFilterWireframe.self
        protocolSelectorRouterType = MockProtocolSelectorRouter.self
        mockFileParametersRouterType = MockMockFileParametersRouter.self
        mockFileParametersView = MockMockFileParametersView()
        contentPresenterRouterType = MockContentPresenterRouter.self
        filteringHandler = MockAsyncFilteringHandler()
        recentDocumentManager = MockRecentDocumentManaging()
        documentController = MockDocumentControlling()
        pasteboard = MockPasteboard()
    }

    private func createInterator(
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws -> GodfatherInteractor {
        let interactor = GodfatherInteractor(
            userDefaults: userDefaults,
            fileManager: fileManager,
            dataSourceFactory: dataSourceFactory,
            mockGeneratorFactory: mockGeneratorFactory,
            openPanelFactory: openPanelFactory,
            projectFileSelectorRouterType: projectFileSelectorRouterType,
            sourceFileSelectorRouterType: sourceFileSelectorRouterType,
            sourceFileFilterRouterType: sourceFileFilterRouterType,
            protocolSelectorRouterType: protocolSelectorRouterType,
            mockFileParametersRouterType: mockFileParametersRouterType,
            contentPresenterRouterType: contentPresenterRouterType,
            filteringHandler: filteringHandler,
            recentDocumentManager: recentDocumentManager,
            documentController: documentController,
            pasteboard: pasteboard
        )
        interactor.presenter = presenter
        interactor.currentSourceFileCode = "SOURCE"
        presenter.reset()
        sourceFileSelectorView = try XCTUnwrap(interactor.sourceFileSelector as? MockSourceFileSelectorView, file: file, line: line)
        mockFileParametersView = try XCTUnwrap(interactor.mockFileParameters as? MockMockFileParametersView, file: file, line: line)
        return interactor
    }
    
    // MARK: - init -
    
    func test_initAndPresenterAssignment() {
        
        let interactor = GodfatherInteractor(
            userDefaults: userDefaults,
            fileManager: fileManager,
            dataSourceFactory: dataSourceFactory,
            mockGeneratorFactory: mockGeneratorFactory,
            openPanelFactory: openPanelFactory,
            projectFileSelectorRouterType: projectFileSelectorRouterType,
            sourceFileSelectorRouterType: sourceFileSelectorRouterType,
            sourceFileFilterRouterType: sourceFileFilterRouterType,
            protocolSelectorRouterType: protocolSelectorRouterType,
            mockFileParametersRouterType: mockFileParametersRouterType,
            contentPresenterRouterType: contentPresenterRouterType,
            filteringHandler: filteringHandler,
            recentDocumentManager: recentDocumentManager,
            documentController: documentController
        )
        interactor.presenter = presenter

        verifyStroblMocksUnused(except: [.presenter])
        XCTAssertEqual(presenter.calledMethods, [.installProjectFileSelectorSourceFileSelectorSourceFileFilterProtocolSelectorMockFileParametersContentPresenterCalled, .canChooseDisplayFlagCalled])
        XCTAssertEqual(presenter.assignedParameters, [.projectFileSelector, .sourceFileSelector, .sourceFileFilter, .protocolSelector, .mockFileParameters, .contentPresenter, .flag])
    }

    // MARK: - GodfatherInteractorInputProtocol methods -

    func test_selectProject() throws {
        let interactor = try createInterator()
        
        interactor.selectProject()
        
        verifyStroblMocksUnused(except: [.projectFileSelectorView])
        XCTAssertEqual(projectFileSelectorView.calledMethods, [.selectProjectCalled])
        XCTAssertEqual(projectFileSelectorView.assignedParameters, [])
    }

    func test_canReloadProject_returnsFalse() throws {
        MockProjectFileSelectorRouter.view.canReloadProjectReturnValue = false
        let interactor = try createInterator()
        
        let flag = interactor.canReloadProject()
        
        XCTAssertEqual(flag, false)
        verifyStroblMocksUnused(except: [.projectFileSelectorView])
        XCTAssertEqual(projectFileSelectorView.calledMethods, [.canReloadProjectCalled])
        XCTAssertEqual(projectFileSelectorView.assignedParameters, [])
    }

    func test_canReloadProject_returnsTrue() throws {
        MockProjectFileSelectorRouter.view.canReloadProjectReturnValue = true
        let interactor = try createInterator()
        
        let flag = interactor.canReloadProject()
        
        XCTAssertEqual(flag, true)
        verifyStroblMocksUnused(except: [.projectFileSelectorView])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.calledMethods, [.canReloadProjectCalled])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.assignedParameters, [])
    }

    func test_reloadProject() throws {
        let interactor = try createInterator()
        
        interactor.reloadProject()
        
        verifyStroblMocksUnused(except: [.projectFileSelectorView])
        XCTAssertEqual(projectFileSelectorView.calledMethods, [.reloadProjectCalled])
        XCTAssertEqual(projectFileSelectorView.assignedParameters, [])
    }

    func test_viewHasAppeared_noUserDefaultValue() throws {
        let interactor = try createInterator()

        interactor.viewHasAppeared()
        
        verifyStroblMocksUnused(except: [.userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.stringForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.projectFilePath])
    }

    func test_viewHasAppeared_userDefaultValueExists_fileDoesNotExist() throws {
        userDefaults.store = [UserDefaultsKey.projectFilePath: "file"]
        fileManager.fileExistsAtPathPathReturnValue = false
        let interactor = try createInterator()
        
        interactor.viewHasAppeared()
        
        verifyStroblMocksUnused(except: [.fileManager, .userDefaults])
        XCTAssertEqual(fileManager.calledMethods, [.fileExistsAtPathPathCalled])
        XCTAssertEqual(fileManager.assignedParameters, [.path])
        XCTAssertEqual(fileManager.path, "file")
        XCTAssertEqual(userDefaults.calledMethods, [.stringForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.projectFilePath])
    }

    func test_viewHasAppeared_userDefaultValueExists_fileDoesExist() throws {
        userDefaults.store = [UserDefaultsKey.projectFilePath: "file"]
        fileManager.fileExistsAtPathPathReturnValue = true
        let interactor = try createInterator()
        
        // First time
        interactor.viewHasAppeared()
        
        verifyStroblMocksUnused(except: [.projectFileSelectorView, .fileManager, .userDefaults])
        XCTAssertEqual(projectFileSelectorView.calledMethods, [.showSelectedFileUrlCalled])
        XCTAssertEqual(projectFileSelectorView.assignedParameters, [.url])
        XCTAssertEqual(fileManager.calledMethods, [.fileExistsAtPathPathCalled])
        XCTAssertEqual(fileManager.assignedParameters, [.path])
        XCTAssertEqual(fileManager.path, "file")
        XCTAssertEqual(userDefaults.calledMethods, [.stringForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.projectFilePath])

        // First time
        projectFileSelectorView.reset()
        interactor.viewHasAppeared()
        
        verifyStroblMocksUnused(except: [.fileManager, .userDefaults])
        XCTAssertEqual(fileManager.calledMethods, [.fileExistsAtPathPathCalled])
        XCTAssertEqual(fileManager.assignedParameters, [.path])
        XCTAssertEqual(fileManager.path, "file")
        XCTAssertEqual(userDefaults.calledMethods, [.stringForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.projectFilePath])
    }
    
    func test_displayChoice_mock() throws {
        let interactor = try createInterator()

        interactor.displayChoice(.mock)
        
        verifyStroblMocksUnused()
    }
    
    func test_displayChoice_source() throws {
        let interactor = try createInterator()

        interactor.displayChoice(.source)
        
        verifyStroblMocksUnused()
    }
    
    func test_copyMockToClipboard() throws {
        let interactor = try createInterator()

        interactor.copyMockToClipboard()
        
        verifyStroblMocksUnused(except: [.pasteboard])
        XCTAssertEqual(pasteboard.calledMethods, [.declareTypesNewTypesOwnerNewOwnerCalled, .setStringStringForTypeDataTypeCalled])
        XCTAssertEqual(pasteboard.assignedParameters, [.newTypes, .newOwner, .string, .dataType])
        XCTAssertEqual(pasteboard.newTypes, [.string])
        XCTAssertNil(pasteboard.newOwner)
        XCTAssertEqual(pasteboard.string, interactor.mockCode)
        XCTAssertEqual(pasteboard.dataType, NSPasteboard.PasteboardType.string)
    }

    func test_openRecentProjectFile() throws {
        let url = try XCTUnwrap(URL(string: "a.txt"))
        let interactor = try createInterator()

        interactor.openRecentProjectFile(url)
        
        verifyStroblMocksUnused(except: [.presenter, .dataSourceFactory, .projectFileSelectorView, .recentDocumentManager, .documentController, .mockFileParametersView, .filteringHandler, .userDefaults])
        XCTAssertEqual(presenter.calledMethods, [.showAsBusyWithMessageCalled, .clearBusyMessageCalled])
        XCTAssertEqual(presenter.assignedParameters, [.message])
        XCTAssertEqual(presenter.message, "Loading a.txt")
        XCTAssertEqual(dataSourceFactory.calledMethods, [.createDataSourceForFileURLCalled])
        XCTAssertEqual(dataSourceFactory.assignedParameters, [.fileURL])
        XCTAssertEqual(dataSourceFactory.fileURL, url)
        XCTAssertEqual(dataSource.calledMethods, [])
        XCTAssertEqual(projectFileSelectorView.calledMethods, [.renderURLOfSelectedFileUrlCalled])
        XCTAssertEqual(projectFileSelectorView.assignedParameters, [.url])
        XCTAssertEqual(projectFileSelectorView.url, url)
        XCTAssertEqual(recentDocumentManager.calledMethods, [.addUrlCalled])
        XCTAssertEqual(recentDocumentManager.assignedParameters, [.url])
        XCTAssertEqual(recentDocumentManager.url, url)
        XCTAssertEqual(documentController.calledMethods, [.noteNewRecentDocumentURLUrlCalled])
        XCTAssertEqual(documentController.assignedParameters, [.url])
        XCTAssertEqual(documentController.url, url)
        XCTAssertEqual(mockFileParametersView.calledMethods, [.setupForDataSourceCalled, .clearProtocolCalled])
        XCTAssertEqual(mockFileParametersView.assignedParameters, [.dataSource])
        XCTAssertNotNil(mockFileParametersView.dataSource)
        if let dataSource = mockFileParametersView.dataSource {
            XCTAssertTrue(dataSource.isEqual(dataSourceFactory.createDataSourceForFileURLReturnValue))
        }
        XCTAssertEqual(filteringHandler.calledMethods, [.performFilteringOnDataSourceWithFilterCompletionHandlerCalled])
        XCTAssertEqual(filteringHandler.assignedParameters, [.dataSource, .filter, .completionHandler])
        XCTAssertEqual(userDefaults.calledMethods, [.setValueForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .value])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.projectFilePath, UserDefaultsKey.projectFilePath, UserDefaultsKey.sourceFileFilterValue])
        XCTAssertEqual(userDefaults.values.count, 2)
        if userDefaults.values.count == 2 {
            XCTAssertTrue(userDefaults.values[0] is NSNull)
            
            XCTAssertTrue(userDefaults.values[1] is String)
            if let value = userDefaults.values[1] as? String {
                XCTAssertEqual(value, "a.txt")
            }
        }
    }

    // MARK: - ProjectFileSelectorInterfaceDelegate methods -
    
    func test_projectFileSelectorFileSelected_projectFileCreationFails() throws {
        let projectFileSelector = MockProjectFileSelectorView()
        let url = URL(fileURLWithPath: "file")
        dataSourceFactory.createDataSourceForFileURLReturnValue = nil
        let interactor = try createInterator()
        
        interactor.projectFileSelector(projectFileSelector, fileSelected: url)
        
        verifyStroblMocksUnused(except: [.presenter, .dataSourceFactory, .userDefaults])
        XCTAssertEqual(presenter.calledMethods, [.reportErrorConditionWithMessageTextAndInformativeTextCalled, .showAsBusyWithMessageCalled, .clearBusyMessageCalled])
        XCTAssertEqual(presenter.assignedParameters, [.messageText, .informativeText, .message])
        XCTAssertEqual(dataSourceFactory.calledMethods, [.createDataSourceForFileURLCalled])
        XCTAssertEqual(dataSourceFactory.assignedParameters, [.fileURL])
        XCTAssertEqual(dataSourceFactory.fileURL, url)
        XCTAssertEqual(userDefaults.calledMethods, [.setValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .value])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.projectFilePath])
        XCTAssertEqual(userDefaults.values.count, 1)
        XCTAssertTrue(userDefaults.values is [NSNull])
    }
    
    func test_projectFileSelectorFileSelected_projectFileCreationSucceeds() throws {
        let projectFileSelector = MockProjectFileSelectorView()
        let url = URL(fileURLWithPath: "file")
        let interactor = try createInterator()
        
        interactor.projectFileSelector(projectFileSelector, fileSelected: url)

        verifyStroblMocksUnused(except: [.presenter, .dataSourceFactory, .recentDocumentManager, .documentController, .mockFileParametersView, .filteringHandler, .userDefaults])
        XCTAssertEqual(presenter.calledMethods, [.showAsBusyWithMessageCalled, .clearBusyMessageCalled])
        XCTAssertEqual(presenter.assignedParameters, [.message])
        XCTAssertEqual(dataSourceFactory.calledMethods, [.createDataSourceForFileURLCalled])
        XCTAssertEqual(dataSourceFactory.assignedParameters, [.fileURL])
        XCTAssertEqual(dataSourceFactory.fileURL, url)
        XCTAssertEqual(recentDocumentManager.calledMethods, [.addUrlCalled])
        XCTAssertEqual(recentDocumentManager.assignedParameters, [.url])
        XCTAssertEqual(recentDocumentManager.url, url)
        XCTAssertEqual(documentController.calledMethods, [.noteNewRecentDocumentURLUrlCalled])
        XCTAssertEqual(documentController.assignedParameters, [.url])
        XCTAssertEqual(documentController.url, url)
        XCTAssertEqual(mockFileParametersView.calledMethods, [.setupForDataSourceCalled, .clearProtocolCalled])
        XCTAssertEqual(mockFileParametersView.assignedParameters, [.dataSource])
        XCTAssertNotNil(mockFileParametersView.dataSource)
        if let dataSource = mockFileParametersView.dataSource {
            XCTAssertTrue(dataSource.isEqual(dataSourceFactory.createDataSourceForFileURLReturnValue))
        }
        XCTAssertEqual(filteringHandler.calledMethods, [.performFilteringOnDataSourceWithFilterCompletionHandlerCalled])
        XCTAssertEqual(filteringHandler.assignedParameters, [.dataSource, .filter, .completionHandler])
        XCTAssertEqual(userDefaults.calledMethods, [.setValueForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .value])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.projectFilePath, UserDefaultsKey.projectFilePath, UserDefaultsKey.sourceFileFilterValue])
        XCTAssertEqual(userDefaults.values.count, 2)
        if userDefaults.values.count == 2 {
            XCTAssertTrue(userDefaults.values[0] is NSNull)
            
            XCTAssertTrue(userDefaults.values[1] is String)
            if let value = userDefaults.values[1] as? String {
                XCTAssertEqual(value, "/file")
            }
        }
    }

    // MARK: - SourceFileSelectorInterfaceDelegate methods -
    
    func test_sourceFileSelectorFileSelected_projectFileCreationSucceeds() throws {
        let treeNode = TreeNode(fileURL: URL(fileURLWithPath: #filePath), target: nil)
        let interactor = try createInterator()
            
        interactor.sourceFileSelector(sourceFileSelectorView, fileSelected: treeNode)
    
        verifyStroblMocksUnused(except: [.presenter, .mockFileParametersView])
        XCTAssertEqual(presenter.calledMethods, [.canChooseDisplayFlagCalled, .setDisplayChoiceChoiceCalled])
        XCTAssertEqual(presenter.assignedParameters, [.flag, .choice])
        XCTAssertEqual(presenter.flag, false)
        XCTAssertEqual(presenter.choice, .mock)
        XCTAssertEqual(mockFileParametersView.calledMethods, [.clearProtocolCalled])
        XCTAssertEqual(mockFileParametersView.assignedParameters, [])
    }

    // MARK: - SourceFileSelectorInterfaceDelegate methods -

    func test_protocolSelectorProtocolSelected() throws {
        let protocolSelector = MockProtocolSelectorView()
        let identifier = try XCTUnwrap(TokenSyntax(TokenKind.identifier("ABCD"), presence: .present))
        let protocolDeclaration = ProtocolDeclSyntax(name: identifier, memberBlock: MemberBlockSyntax(members: MemberBlockItemListSyntax([])))
        let interactor = try createInterator()

        interactor.protocolSelector(protocolSelector, protocolSelected: protocolDeclaration)
        
        verifyStroblMocksUnused(except: [.mockFileParametersView])
        XCTAssertEqual(mockFileParametersView.calledMethods, [.setupForProtocolDeclarationCalled])
        XCTAssertEqual(mockFileParametersView.assignedParameters, [.protocolDeclaration])
        XCTAssertEqual(mockFileParametersView.protocolDeclaration, protocolDeclaration)
}

    // MARK: - MockFileParametersInterfaceDelegate methods -
    
    func test_mockFileParametersMethod_noCurrentProject() throws {
        let mockFileParameters = MockMockFileParametersView()
        let mockName = "Name"
        let includeHeader = true
        let includeTestableImport = true
        let testableTargetName = "Fred"
        let trackPropertyActivity = true
        let `public` = false
        let interactor = try createInterator()
        interactor.currentDataSource = nil
        
        interactor.mockFileParameters(mockFileParameters, mockName: mockName, includeHeader: includeHeader, includeTestableImport: includeTestableImport, testableTargetName: testableTargetName, trackPropertyActivity: trackPropertyActivity, public: `public`)
        
        XCTAssertNotEqual(interactor.mockName, mockName)
        verifyStroblMocksUnused()
    }
    
    func test_mockFileParametersMethod_noCurrentSourceFile() throws {
        let mockFileParameters = MockMockFileParametersView()
        let mockName = "Name"
        let includeHeader = true
        let includeTestableImport = true
        let testableTargetName = "Fred"
        let trackPropertyActivity = true
        let `public` = false
        let interactor = try createInterator()
        interactor.currentDataSource = MockSourceFileDataSource()
        interactor.currentSourceFile = nil
        
        interactor.mockFileParameters(mockFileParameters, mockName: mockName, includeHeader: includeHeader, includeTestableImport: includeTestableImport, testableTargetName: testableTargetName, trackPropertyActivity: trackPropertyActivity, public: `public`)
        
        XCTAssertNotEqual(interactor.mockName, mockName)
        verifyStroblMocksUnused()
    }
    
    func test_mockFileParametersMethod_noCurrentProtocolDeclaration() throws {
        let mockFileParameters = MockMockFileParametersView()
        let mockName = "Name"
        let includeHeader = true
        let includeTestableImport = true
        let testableTargetName = "Fred"
        let trackPropertyActivity = true
        let `public` = false
        let interactor = try createInterator()
        interactor.currentDataSource = MockSourceFileDataSource()
        interactor.currentSourceFile = SourceFileInformation(viewMode: .sourceAccurate)
        interactor.currentProtocolDeclaration = nil
        
        interactor.mockFileParameters(mockFileParameters, mockName: mockName, includeHeader: includeHeader, includeTestableImport: includeTestableImport, testableTargetName: testableTargetName, trackPropertyActivity: trackPropertyActivity, public: `public`)
        
        XCTAssertNotEqual(interactor.mockName, mockName)
        verifyStroblMocksUnused()
    }
    
    func test_mockFileParametersMethod_mockNameIsEmpty() throws {
        let mockFileParameters = MockMockFileParametersView()
        let mockName = ""
        let includeHeader = true
        let includeTestableImport = true
        let testableTargetName = "Fred"
        let trackPropertyActivity = true
        let `public` = false
        let interactor = try createInterator()
        interactor.currentDataSource = MockSourceFileDataSource()
        interactor.currentSourceFile = SourceFileInformation(viewMode: .sourceAccurate)
        let identifier = try XCTUnwrap(TokenSyntax(TokenKind.identifier("ABCD"), presence: .present))
        interactor.currentProtocolDeclaration = ProtocolDeclSyntax(name: identifier, memberBlock: MemberBlockSyntax(members: MemberBlockItemListSyntax([])))
        
        interactor.mockFileParameters(mockFileParameters, mockName: mockName, includeHeader: includeHeader, includeTestableImport: includeTestableImport, testableTargetName: testableTargetName, trackPropertyActivity: trackPropertyActivity, public: `public`)
        
        XCTAssertEqual(interactor.mockName, "")
        XCTAssertEqual(interactor.mockCode, "")
        verifyStroblMocksUnused(except: [.presenter])
        XCTAssertEqual(presenter.calledMethods, [.canChooseDisplayFlagCalled, .setDisplayChoiceChoiceCalled])
        XCTAssertEqual(presenter.assignedParameters, [.flag, .choice])
        XCTAssertEqual(presenter.flag, false)
        XCTAssertEqual(presenter.choice, .mock)
    }

    func test_mockFileParametersMethod_mockNameIsValid() throws {
        let mockFileParameters = MockMockFileParametersView()
        let mockName = "Name"
        let includeHeader = true
        let includeTestableImport = true
        let testableTargetName = "Fred"
        let trackPropertyActivity = true
        let `public` = false
        let interactor = try createInterator()
        interactor.currentDataSource = MockSourceFileDataSource()
        interactor.currentSourceFile = SourceFileInformation(viewMode: .sourceAccurate)
        let identifier = try XCTUnwrap(TokenSyntax(TokenKind.identifier("ABCD"), presence: .present))
        interactor.currentProtocolDeclaration = ProtocolDeclSyntax(name: identifier, memberBlock: MemberBlockSyntax(members: MemberBlockItemListSyntax([])))

        interactor.mockFileParameters(mockFileParameters, mockName: mockName, includeHeader: includeHeader, includeTestableImport: includeTestableImport, testableTargetName: testableTargetName, trackPropertyActivity: trackPropertyActivity, public: `public`)
        
        XCTAssertEqual(interactor.mockName, mockName)
        verifyStroblMocksUnused(except: [.presenter, .mockGenerator])
        XCTAssertEqual(presenter.calledMethods, [.canChooseDisplayFlagCalled, .setDisplayChoiceChoiceCalled])
        XCTAssertEqual(presenter.assignedParameters, [.flag, .choice])
        XCTAssertEqual(presenter.flag, false)
        XCTAssertEqual(presenter.choice, .mock)
        XCTAssertEqual(mockGenerator.calledMethods, [.generateMockCodeForParametersCalled])
        XCTAssertEqual(mockGenerator.assignedParameters, [.parameters])
        XCTAssertEqual(mockGenerator.parameters?.mockName, mockName)
        XCTAssertEqual(mockGenerator.parameters?.includeTestableImport, includeTestableImport)
        XCTAssertEqual(mockGenerator.parameters?.testableTargetName, testableTargetName)
        XCTAssertEqual(mockGenerator.parameters?.trackPropertyActivity, trackPropertyActivity)
    }

    // MARK: - FilterInterfaceDelegate methods -
    
    func test_filterNewValue() throws {
        let filterInterface = MockFilterInterface()
        let newValue = "ABCD"
        userDefaults.sourceFileFilterValue = newValue
        let interactor = try createInterator()
        interactor.currentDataSource = MockSourceFileDataSource()

        interactor.filter(filterInterface, newValue: newValue)
        
        verifyStroblMocksUnused(except: [.filteringHandler, .userDefaults])
        XCTAssertEqual(filteringHandler.calledMethods, [.performFilteringOnDataSourceWithFilterCompletionHandlerCalled])
        XCTAssertEqual(filteringHandler.assignedParameters, [.dataSource, .filter, .completionHandler])
        XCTAssertEqual(filteringHandler.filter, newValue)
        XCTAssertEqual(userDefaults.calledMethods, [.setValueForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .value])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.sourceFileFilterValue, UserDefaultsKey.sourceFileFilterValue])
        XCTAssertEqual(userDefaults.values.count, 1)
        XCTAssertTrue(userDefaults.values is [String])
        if let values = userDefaults.values as? [String] {
            XCTAssertEqual(values, [newValue])
        }
    }
}

//swiftlint:enable type_body_length file_length
