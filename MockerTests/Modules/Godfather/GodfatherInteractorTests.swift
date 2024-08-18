//swiftlint:disable type_body_length file_length
//
//  GodfatherInteractorTests.swift
//  MockerTests
//
//  Created by Greg on 2/24/18.
//

import Testing
import Foundation
import AppKit
@testable import Mocker
import SwiftSyntax
import MacrosForStroblMocks

@MainActor @UsesStroblMocks
struct GodfatherInteractorTests {

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

    init() async throws {
        userDefaults = MockUserDefaults()
        fileManager = MockFileManager()
        presenter = MockGodfatherInteractorOutput()
        dataSourceFactory = MockSourceFileDataSourceCreating()
        dataSource = try #require(dataSourceFactory.createDataSourceForFileURLReturnValue as? MockSourceFileDataSource)
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

    private mutating func createInterator(
        sourceLocation: Testing.SourceLocation = #_sourceLocation
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
        sourceFileSelectorView = try #require(interactor.sourceFileSelector as? MockSourceFileSelectorView, sourceLocation: sourceLocation)
        mockFileParametersView = try #require(interactor.mockFileParameters as? MockMockFileParametersView, sourceLocation: sourceLocation)
        return interactor
    }
    
    // MARK: - init
    
    @Test func initAndPresenterAssignment() {
        
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
        #expect(presenter.calledMethods == [.installProjectFileSelectorSourceFileSelectorSourceFileFilterProtocolSelectorMockFileParametersContentPresenterCalled, .canChooseDisplayFlagCalled])
        #expect(presenter.assignedParameters == [.projectFileSelector, .sourceFileSelector, .sourceFileFilter, .protocolSelector, .mockFileParameters, .contentPresenter, .flag])
    }

    // MARK: - GodfatherInteractorInputProtocol methods

    @Test mutating func selectProject() throws {
        let interactor = try createInterator()
        
        interactor.selectProject()
        
        verifyStroblMocksUnused(except: [.projectFileSelectorView])
        #expect(projectFileSelectorView.calledMethods == [.selectProjectCalled])
        #expect(projectFileSelectorView.assignedParameters == [])
    }

    @Test mutating func canReloadProject_returnsFalse() throws {
        MockProjectFileSelectorRouter.view.canReloadProjectReturnValue = false
        let interactor = try createInterator()
        
        let flag = interactor.canReloadProject()
        
        #expect(flag == false)
        verifyStroblMocksUnused(except: [.projectFileSelectorView])
        #expect(projectFileSelectorView.calledMethods == [.canReloadProjectCalled])
        #expect(projectFileSelectorView.assignedParameters == [])
    }

    @Test mutating func canReloadProject_returnsTrue() throws {
        MockProjectFileSelectorRouter.view.canReloadProjectReturnValue = true
        let interactor = try createInterator()
        
        let flag = interactor.canReloadProject()
        
        #expect(flag == true)
        verifyStroblMocksUnused(except: [.projectFileSelectorView])
        #expect(MockProjectFileSelectorRouter.view.calledMethods == [.canReloadProjectCalled])
        #expect(MockProjectFileSelectorRouter.view.assignedParameters == [])
    }

    @Test mutating func reloadProject() throws {
        let interactor = try createInterator()
        
        interactor.reloadProject()
        
        verifyStroblMocksUnused(except: [.projectFileSelectorView])
        #expect(projectFileSelectorView.calledMethods == [.reloadProjectCalled])
        #expect(projectFileSelectorView.assignedParameters == [])
    }

    @Test mutating func viewHasAppeared_noUserDefaultValue() throws {
        let interactor = try createInterator()

        interactor.viewHasAppeared()
        
        verifyStroblMocksUnused(except: [.userDefaults])
        #expect(userDefaults.calledMethods == [.stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.projectFilePath])
    }

    @Test mutating func viewHasAppeared_userDefaultValueExists_fileDoesNotExist() throws {
        userDefaults.store = [UserDefaultsKey.projectFilePath: "file"]
        fileManager.fileExistsAtPathPathReturnValue = false
        let interactor = try createInterator()
        
        interactor.viewHasAppeared()
        
        verifyStroblMocksUnused(except: [.fileManager, .userDefaults])
        #expect(fileManager.calledMethods == [.fileExistsAtPathPathCalled])
        #expect(fileManager.assignedParameters == [.path])
        #expect(fileManager.path == "file")
        #expect(userDefaults.calledMethods == [.stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.projectFilePath])
    }

    @Test mutating func viewHasAppeared_userDefaultValueExists_fileDoesExist() throws {
        userDefaults.store = [UserDefaultsKey.projectFilePath: "file"]
        fileManager.fileExistsAtPathPathReturnValue = true
        let interactor = try createInterator()
        
        // First time
        interactor.viewHasAppeared()
        
        verifyStroblMocksUnused(except: [.projectFileSelectorView, .fileManager, .userDefaults])
        #expect(projectFileSelectorView.calledMethods == [.showSelectedFileUrlCalled])
        #expect(projectFileSelectorView.assignedParameters == [.url])
        #expect(fileManager.calledMethods == [.fileExistsAtPathPathCalled])
        #expect(fileManager.assignedParameters == [.path])
        #expect(fileManager.path == "file")
        #expect(userDefaults.calledMethods == [.stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.projectFilePath])

        // First time
        projectFileSelectorView.reset()
        interactor.viewHasAppeared()
        
        verifyStroblMocksUnused(except: [.fileManager, .userDefaults])
        #expect(fileManager.calledMethods == [.fileExistsAtPathPathCalled])
        #expect(fileManager.assignedParameters == [.path])
        #expect(fileManager.path == "file")
        #expect(userDefaults.calledMethods == [.stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.projectFilePath])
    }
    
    @Test mutating func displayChoice_mock() throws {
        let interactor = try createInterator()

        interactor.displayChoice(.mock)
        
        verifyStroblMocksUnused()
    }
    
    @Test mutating func displayChoice_source() throws {
        let interactor = try createInterator()

        interactor.displayChoice(.source)
        
        verifyStroblMocksUnused()
    }
    
    @Test mutating func copyMockToClipboard() throws {
        let interactor = try createInterator()

        interactor.copyMockToClipboard()
        
        verifyStroblMocksUnused(except: [.pasteboard, .presenter])
        #expect(pasteboard.calledMethods == [.declareTypesNewTypesOwnerNewOwnerCalled, .setStringStringForTypeDataTypeCalled])
        #expect(pasteboard.assignedParameters == [.newTypes, .newOwner, .string, .dataType])
        #expect(pasteboard.newTypes == [.string])
        #expect(pasteboard.newOwner == nil)
        #expect(pasteboard.string == interactor.mockCode)
        #expect(pasteboard.dataType == NSPasteboard.PasteboardType.string)
        #expect(presenter.calledMethods == [.mockCopiedToClipboardCalled])
        #expect(presenter.assignedParameters == [])
    }

    @Test mutating func openRecentProjectFile() throws {
        let url = try #require(URL(string: "a.txt"))
        let interactor = try createInterator()

        interactor.openRecentProjectFile(url)
        
        verifyStroblMocksUnused(except: [.presenter, .dataSourceFactory, .projectFileSelectorView, .recentDocumentManager, .documentController, .mockFileParametersView, .filteringHandler, .userDefaults])
        #expect(presenter.calledMethods == [.showAsBusyWithMessageCalled, .clearBusyMessageCalled])
        #expect(presenter.assignedParameters == [.message])
        #expect(presenter.message == "Loading a.txt")
        #expect(dataSourceFactory.calledMethods == [.createDataSourceForFileURLCalled])
        #expect(dataSourceFactory.assignedParameters == [.fileURL])
        #expect(dataSourceFactory.fileURL == url)
        #expect(dataSource.calledMethods == [])
        #expect(projectFileSelectorView.calledMethods == [.renderURLOfSelectedFileUrlCalled])
        #expect(projectFileSelectorView.assignedParameters == [.url])
        #expect(projectFileSelectorView.url == url)
        #expect(recentDocumentManager.calledMethods == [.addUrlCalled])
        #expect(recentDocumentManager.assignedParameters == [.url])
        #expect(recentDocumentManager.url == url)
        #expect(documentController.calledMethods == [.noteNewRecentDocumentURLUrlCalled])
        #expect(documentController.assignedParameters == [.url])
        #expect(documentController.url == url)
        #expect(mockFileParametersView.calledMethods == [.setupForDataSourceCalled, .clearProtocolCalled])
        #expect(mockFileParametersView.assignedParameters == [.dataSource])
        let dataSource = try #require(mockFileParametersView.dataSource)
        #expect(dataSource.isEqual(dataSourceFactory.createDataSourceForFileURLReturnValue))
        #expect(filteringHandler.calledMethods == [.performFilteringOnDataSourceWithFilterCompletionHandlerCalled])
        #expect(filteringHandler.assignedParameters == [.dataSource, .filter, .completionHandler])
        #expect(userDefaults.calledMethods == [.setValueForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.projectFilePath, UserDefaultsKey.projectFilePath, UserDefaultsKey.sourceFileFilterValue])
        #expect(userDefaults.values.count == 2)
        if userDefaults.values.count == 2 {
            #expect(userDefaults.values[0] is NSNull)
            
            let value = try #require(userDefaults.values[1] as? String)
            #expect(value == "a.txt")
        }
    }

    // MARK: - ProjectFileSelectorInterfaceDelegate methods
    
    @Test mutating func projectFileSelectorFileSelected_projectFileCreationFails() throws {
        let projectFileSelector = MockProjectFileSelectorView()
        let url = URL(fileURLWithPath: "file")
        dataSourceFactory.createDataSourceForFileURLReturnValue = nil
        let interactor = try createInterator()
        
        interactor.projectFileSelector(projectFileSelector, fileSelected: url)
        
        verifyStroblMocksUnused(except: [.presenter, .dataSourceFactory, .userDefaults])
        #expect(presenter.calledMethods == [.reportErrorConditionWithMessageTextAndInformativeTextCalled, .showAsBusyWithMessageCalled, .clearBusyMessageCalled])
        #expect(presenter.assignedParameters == [.messageText, .informativeText, .message])
        #expect(dataSourceFactory.calledMethods == [.createDataSourceForFileURLCalled])
        #expect(dataSourceFactory.assignedParameters == [.fileURL])
        #expect(dataSourceFactory.fileURL == url)
        #expect(userDefaults.calledMethods == [.setValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.projectFilePath])
        #expect(userDefaults.values.count == 1)
        #expect(userDefaults.values is [NSNull])
    }
    
    @Test mutating func projectFileSelectorFileSelected_projectFileCreationSucceeds() throws {
        let projectFileSelector = MockProjectFileSelectorView()
        let url = URL(fileURLWithPath: "file")
        let interactor = try createInterator()
        
        interactor.projectFileSelector(projectFileSelector, fileSelected: url)

        verifyStroblMocksUnused(except: [.presenter, .dataSourceFactory, .recentDocumentManager, .documentController, .mockFileParametersView, .filteringHandler, .userDefaults])
        #expect(presenter.calledMethods == [.showAsBusyWithMessageCalled, .clearBusyMessageCalled])
        #expect(presenter.assignedParameters == [.message])
        #expect(dataSourceFactory.calledMethods == [.createDataSourceForFileURLCalled])
        #expect(dataSourceFactory.assignedParameters == [.fileURL])
        #expect(dataSourceFactory.fileURL == url)
        #expect(recentDocumentManager.calledMethods == [.addUrlCalled])
        #expect(recentDocumentManager.assignedParameters == [.url])
        #expect(recentDocumentManager.url == url)
        #expect(documentController.calledMethods == [.noteNewRecentDocumentURLUrlCalled])
        #expect(documentController.assignedParameters == [.url])
        #expect(documentController.url == url)
        #expect(mockFileParametersView.calledMethods == [.setupForDataSourceCalled, .clearProtocolCalled])
        #expect(mockFileParametersView.assignedParameters == [.dataSource])
        let dataSource = try #require(mockFileParametersView.dataSource)
        #expect(dataSource.isEqual(dataSourceFactory.createDataSourceForFileURLReturnValue))
        #expect(filteringHandler.calledMethods == [.performFilteringOnDataSourceWithFilterCompletionHandlerCalled])
        #expect(filteringHandler.assignedParameters == [.dataSource, .filter, .completionHandler])
        #expect(userDefaults.calledMethods == [.setValueForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.projectFilePath, UserDefaultsKey.projectFilePath, UserDefaultsKey.sourceFileFilterValue])
        #expect(userDefaults.values.count == 2)
        if userDefaults.values.count == 2 {
            #expect(userDefaults.values[0] is NSNull)
            
            let value = try #require(userDefaults.values[1] as? String)
            #expect(value == "/file")
        }
    }

    // MARK: - SourceFileSelectorInterfaceDelegate methods
    
    @Test mutating func sourceFileSelectorFileSelected_projectFileCreationSucceeds() throws {
        let sendableTreeNode = TreeNode(fileURL: URL(fileURLWithPath: #filePath), target: nil).sendable
        let interactor = try createInterator()
            
        interactor.sourceFileSelector(sourceFileSelectorView, fileSelected: sendableTreeNode)
    
        verifyStroblMocksUnused(except: [.presenter, .mockFileParametersView])
        #expect(presenter.calledMethods == [.canChooseDisplayFlagCalled, .setDisplayChoiceChoiceCalled])
        #expect(presenter.assignedParameters == [.flag, .choice])
        #expect(presenter.flag == false)
        #expect(presenter.choice == .mock)
        #expect(mockFileParametersView.calledMethods == [.clearProtocolCalled])
        #expect(mockFileParametersView.assignedParameters == [])
    }

    // MARK: - SourceFileSelectorInterfaceDelegate methods

    @Test mutating func test_protocolSelectorProtocolSelected() throws {
        let protocolSelector = MockProtocolSelectorView()
        let identifier = try #require(TokenSyntax(TokenKind.identifier("ABCD"), presence: .present))
        let protocolDeclaration = ProtocolDeclSyntax(name: identifier, memberBlock: MemberBlockSyntax(members: MemberBlockItemListSyntax([])))
        let interactor = try createInterator()

        interactor.protocolSelector(protocolSelector, protocolSelected: protocolDeclaration)
        
        verifyStroblMocksUnused(except: [.mockFileParametersView])
        #expect(mockFileParametersView.calledMethods == [.setupForProtocolDeclarationCalled])
        #expect(mockFileParametersView.assignedParameters == [.protocolDeclaration])
        #expect(mockFileParametersView.protocolDeclaration == protocolDeclaration)
}

    // MARK: - MockFileParametersInterfaceDelegate methods
    
    @Test mutating func mockFileParametersMethod_noCurrentDataSource() throws {
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
        
        #expect(interactor.mockName != mockName)
        verifyStroblMocksUnused()
    }
    
    @Test mutating func mockFileParametersMethod_noCurrentSourceFile() throws {
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
        
        #expect(interactor.mockName != mockName)
        verifyStroblMocksUnused()
    }
    
    @Test mutating func mockFileParametersMethod_noCurrentProtocolDeclaration() throws {
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
        
        #expect(interactor.mockName != mockName)
        verifyStroblMocksUnused()
    }
    
    @Test mutating func mockFileParametersMethod_mockNameIsEmpty() throws {
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
        let identifier = try #require(TokenSyntax(TokenKind.identifier("ABCD"), presence: .present))
        interactor.currentProtocolDeclaration = ProtocolDeclSyntax(name: identifier, memberBlock: MemberBlockSyntax(members: MemberBlockItemListSyntax([])))
        
        interactor.mockFileParameters(mockFileParameters, mockName: mockName, includeHeader: includeHeader, includeTestableImport: includeTestableImport, testableTargetName: testableTargetName, trackPropertyActivity: trackPropertyActivity, public: `public`)
        
        #expect(interactor.mockName == "")
        #expect(interactor.mockCode == "")
        verifyStroblMocksUnused(except: [.presenter])
        #expect(presenter.calledMethods == [.canChooseDisplayFlagCalled, .setDisplayChoiceChoiceCalled])
        #expect(presenter.assignedParameters == [.flag, .choice])
        #expect(presenter.flag == false)
        #expect(presenter.choice == .mock)
    }

    @Test mutating func mockFileParametersMethod_mockNameIsValid() throws {
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
        let identifier = try #require(TokenSyntax(TokenKind.identifier("ABCD"), presence: .present))
        interactor.currentProtocolDeclaration = ProtocolDeclSyntax(name: identifier, memberBlock: MemberBlockSyntax(members: MemberBlockItemListSyntax([])))

        interactor.mockFileParameters(mockFileParameters, mockName: mockName, includeHeader: includeHeader, includeTestableImport: includeTestableImport, testableTargetName: testableTargetName, trackPropertyActivity: trackPropertyActivity, public: `public`)
        
        #expect(interactor.mockName == mockName)
        verifyStroblMocksUnused(except: [.presenter, .mockGenerator])
        #expect(presenter.calledMethods == [.canChooseDisplayFlagCalled, .setDisplayChoiceChoiceCalled])
        #expect(presenter.assignedParameters == [.flag, .choice])
        #expect(presenter.flag == false)
        #expect(presenter.choice == .mock)
        #expect(mockGenerator.calledMethods == [.generateMockCodeForParametersCalled])
        #expect(mockGenerator.assignedParameters == [.parameters])
        #expect(mockGenerator.parameters?.mockName == mockName)
        #expect(mockGenerator.parameters?.includeTestableImport == includeTestableImport)
        #expect(mockGenerator.parameters?.testableTargetName == testableTargetName)
        #expect(mockGenerator.parameters?.trackPropertyActivity == trackPropertyActivity)
    }

    // MARK: - FilterInterfaceDelegate methods
    
    @Test mutating func filterNewValue() throws {
        let filterInterface = MockFilterInterface()
        let newValue = "ABCD"
        userDefaults.sourceFileFilterValue = newValue
        let interactor = try createInterator()
        interactor.currentDataSource = MockSourceFileDataSource()

        interactor.filter(filterInterface, newValue: newValue)
        
        verifyStroblMocksUnused(except: [.filteringHandler, .userDefaults])
        #expect(filteringHandler.calledMethods == [.performFilteringOnDataSourceWithFilterCompletionHandlerCalled])
        #expect(filteringHandler.assignedParameters == [.dataSource, .filter, .completionHandler])
        #expect(filteringHandler.filter == newValue)
        #expect(userDefaults.calledMethods == [.setValueForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.sourceFileFilterValue, UserDefaultsKey.sourceFileFilterValue])
        #expect(userDefaults.values.count == 1)
        let values = try #require(userDefaults.values as? [String])
        #expect(values == [newValue])
    }
}

//swiftlint:enable type_body_length file_length
