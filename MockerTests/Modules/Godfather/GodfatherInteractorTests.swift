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

class GodfatherInteractorTests: XCTestCase {

    var userDefaults: MockUserDefaults!
    var fileManager: MockFileManager!
    var presenter: MockGodfatherInteractorOutput!
    var projectFactory: MockProjectFactory!
    var mockGeneratorFactory: MockMockGeneratorFactory!
    var openPanelFactory: OpenPanelFactory!
    var projectFileSelectorRouterType: ProjectFileSelectorWireframeProtocol.Type!
    var sourceFileSelectorRouterType: SourceFileSelectorWireframeProtocol.Type!
    var sourceFileFilterRouterType: FilterWireframeProtocol.Type!
    var protocolSelectorRouterType: ProtocolSelectorWireframeProtocol.Type!
    var mockFileParametersRouterType: MockFileParametersWireframeProtocol.Type!
    var contentPresenterRouterType: ContentPresenterWireframeProtocol.Type!
    var filteringHandler: MockAsyncFilteringHandler!
    var recentDocumentManager: MockRecentDocumentManaging!
    var documentController: MockDocumentControlling!

    override func setUp() {
        super.setUp()
        
        userDefaults = MockUserDefaults()
        fileManager = MockFileManager()
        presenter = MockGodfatherInteractorOutput()
        projectFactory = MockProjectFactory()
        mockGeneratorFactory = MockMockGeneratorFactory()
        openPanelFactory = MockOpenPanelFactory()
        projectFileSelectorRouterType = MockProjectFileSelectorRouter.self
        sourceFileSelectorRouterType = MockSourceFileSelectorRouter.self
        sourceFileFilterRouterType = MockFilterWireframe.self
        protocolSelectorRouterType = MockProtocolSelectorRouter.self
        mockFileParametersRouterType = MockMockFileParametersRouter.self
        contentPresenterRouterType = MockContentPresenterRouter.self
        filteringHandler = MockAsyncFilteringHandler()
        recentDocumentManager = MockRecentDocumentManaging()
        documentController = MockDocumentControlling()
    }

    private func createInterator() -> GodfatherInteractor {
        let interactor = GodfatherInteractor(
            userDefaults: userDefaults,
            fileManager: fileManager,
            projectFactory: projectFactory,
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
        interactor.currentSourceFileCode = "SOURCE"
        presenter.reset()
        return interactor
    }
    
    // MARK: - init -
    
    func test_initAndPresenterAssignment() {
        
        let interactor = GodfatherInteractor(
            userDefaults: userDefaults,
            fileManager: fileManager,
            projectFactory: projectFactory,
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

        XCTAssertEqual(presenter.calledMethods, [.installProjectFileSelectorSourceFileSelectorSourceFileFilterProtocolSelectorMockFileParametersContentPresenterCalled, .canGenerateFileOrChooseDisplayFlagCalled])
        XCTAssertEqual(presenter.assignedParameters, [.projectFileSelector, .sourceFileSelector, .sourceFileFilter, .protocolSelector, .mockFileParameters, .contentPresenter, .flag])
        XCTAssertEqual(projectFactory.project.calledMethods, [])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.calledMethods, [])
        XCTAssertEqual(fileManager.calledMethods, [])
        XCTAssertEqual(recentDocumentManager.calledMethods, [])
        XCTAssertEqual(documentController.calledMethods, [])
    }

    // MARK: - GodfatherInteractorInputProtocol methods -

    func test_selectProject() {
        let interactor = createInterator()
        
        interactor.selectProject()
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(projectFactory.project.calledMethods, [])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.calledMethods, [.selectProjectCalled])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.assignedParameters, [])
        XCTAssertEqual(fileManager.calledMethods, [])
        XCTAssertEqual(recentDocumentManager.calledMethods, [])
        XCTAssertEqual(documentController.calledMethods, [])
    }

    func test_canReloadProject_returnsFalse() {
        MockProjectFileSelectorRouter.view.canReloadProjectReturnValue = false
        let interactor = createInterator()
        
        let flag = interactor.canReloadProject()
        
        XCTAssertEqual(flag, false)
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(projectFactory.project.calledMethods, [])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.calledMethods, [.canReloadProjectCalled])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.assignedParameters, [])
        XCTAssertEqual(fileManager.calledMethods, [])
        XCTAssertEqual(recentDocumentManager.calledMethods, [])
        XCTAssertEqual(documentController.calledMethods, [])
    }

    func test_canReloadProject_returnsTrue() {
        MockProjectFileSelectorRouter.view.canReloadProjectReturnValue = true
        let interactor = createInterator()
        
        let flag = interactor.canReloadProject()
        
        XCTAssertEqual(flag, true)
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(projectFactory.project.calledMethods, [])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.calledMethods, [.canReloadProjectCalled])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.assignedParameters, [])
        XCTAssertEqual(fileManager.calledMethods, [])
        XCTAssertEqual(recentDocumentManager.calledMethods, [])
        XCTAssertEqual(documentController.calledMethods, [])
    }

    func test_reloadProject() {
        let interactor = createInterator()
        
        interactor.reloadProject()
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(projectFactory.project.calledMethods, [])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.calledMethods, [.reloadProjectCalled])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.assignedParameters, [])
        XCTAssertEqual(fileManager.calledMethods, [])
        XCTAssertEqual(recentDocumentManager.calledMethods, [])
        XCTAssertEqual(documentController.calledMethods, [])
    }

    func test_viewHasAppeared_noUserDefaultValue() {
        let interactor = createInterator()

        interactor.viewHasAppeared()
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(projectFactory.project.calledMethods, [])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.calledMethods, [])
        XCTAssertEqual(fileManager.calledMethods, [])
        XCTAssertEqual(recentDocumentManager.calledMethods, [])
        XCTAssertEqual(documentController.calledMethods, [])
    }

    func test_viewHasAppeared_userDefaultValueExists_fileDoesNotExist() {
        userDefaults.store = [UserDefaultsKey.projectFilePath: "file"]
        fileManager.fileExistsAtPathPathReturnValue = false
        let interactor = createInterator()
        
        interactor.viewHasAppeared()
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(projectFactory.project.calledMethods, [])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.calledMethods, [])
        XCTAssertEqual(fileManager.calledMethods, [.fileExistsAtPathPathCalled])
        XCTAssertEqual(recentDocumentManager.calledMethods, [])
        XCTAssertEqual(documentController.calledMethods, [])
    }

    func test_viewHasAppeared_userDefaultValueExists_fileDoesExist() {
        userDefaults.store = [UserDefaultsKey.projectFilePath: "file"]
        fileManager.fileExistsAtPathPathReturnValue = true
        let interactor = createInterator()
        
        // First time
        interactor.viewHasAppeared()
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(projectFactory.project.calledMethods, [])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.calledMethods, [.showSelectedFileUrlCalled])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.assignedParameters, [.url])
        XCTAssertEqual(fileManager.calledMethods, [.fileExistsAtPathPathCalled])
        XCTAssertEqual(recentDocumentManager.calledMethods, [])
        XCTAssertEqual(documentController.calledMethods, [])

        // First time
        MockProjectFileSelectorRouter.view.reset()
        interactor.viewHasAppeared()
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(projectFactory.project.calledMethods, [])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.calledMethods, [])
        XCTAssertEqual(fileManager.calledMethods, [.fileExistsAtPathPathCalled])
        XCTAssertEqual(recentDocumentManager.calledMethods, [])
        XCTAssertEqual(documentController.calledMethods, [])
    }
    
    func test_displayChoice_mock() {
        let interactor = createInterator()

        interactor.displayChoice(.mock)
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(projectFactory.project.calledMethods, [])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.calledMethods, [])
        XCTAssertEqual(fileManager.calledMethods, [])
        XCTAssertEqual(recentDocumentManager.calledMethods, [])
        XCTAssertEqual(documentController.calledMethods, [])
    }
    
    func test_displayChoice_source() {
        let interactor = createInterator()

        interactor.displayChoice(.source)
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(projectFactory.project.calledMethods, [])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.calledMethods, [])
        XCTAssertEqual(fileManager.calledMethods, [])
        XCTAssertEqual(recentDocumentManager.calledMethods, [])
        XCTAssertEqual(documentController.calledMethods, [])
    }
    
    func test_openRecentProjectFile() throws {
        let url = try XCTUnwrap(URL(string: "a.txt"))
        let interactor = createInterator()

        interactor.openRecentProjectFile(url)
        
        XCTAssertEqual(presenter.calledMethods, [.showAsBusyWithMessageCalled, .clearBusyMessageCalled])
        XCTAssertEqual(presenter.assignedParameters, [.message])
        XCTAssertEqual(presenter.message, "Loading a.txt")
        XCTAssertEqual(projectFactory.project.calledMethods, [])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.calledMethods, [.renderURLOfSelectedFileUrlCalled])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.assignedParameters, [.url])
        XCTAssertEqual(MockProjectFileSelectorRouter.view.url, url)
        XCTAssertEqual(fileManager.calledMethods, [])
        XCTAssertEqual(recentDocumentManager.calledMethods, [.addUrlCalled])
        XCTAssertEqual(recentDocumentManager.assignedParameters, [.url])
        XCTAssertEqual(recentDocumentManager.url, url)
        XCTAssertEqual(documentController.calledMethods, [.noteNewRecentDocumentURLUrlCalled])
        XCTAssertEqual(documentController.assignedParameters, [.url])
        XCTAssertEqual(documentController.url, url)
    }

    // MARK: - ProjectFileSelectorInterfaceDelegate methods -
    
    func test_projectFileSelectorFileSelected_projectFileCreationFails() {
        let projectFileSelector = MockProjectFileSelectorView()
        let url = URL(fileURLWithPath: "file")
        projectFactory.returnProjectFromCreate = false
        let interactor = createInterator()
        
        interactor.projectFileSelector(projectFileSelector, fileSelected: url)
        
        XCTAssertEqual(presenter.calledMethods, [.reportErrorConditionWithMessageTextAndInformativeTextCalled, .showAsBusyWithMessageCalled, .clearBusyMessageCalled])
        XCTAssertEqual(presenter.assignedParameters, [.messageText, .informativeText, .message])
        XCTAssertEqual(projectFactory.project.calledMethods, [])
        XCTAssertTrue(interactor.sourceFileSelector is MockSourceFileSelectorView)
        if let sourceFileSelector = interactor.sourceFileSelector as? MockSourceFileSelectorView {
            XCTAssertEqual(sourceFileSelector.calledMethods, [])
        }
        XCTAssertEqual(fileManager.calledMethods, [])
        XCTAssertEqual(recentDocumentManager.calledMethods, [])
        XCTAssertEqual(documentController.calledMethods, [])
    }
    
    func test_projectFileSelectorFileSelected_projectFileCreationSucceeds() {
        let projectFileSelector = MockProjectFileSelectorView()
        let url = URL(fileURLWithPath: "file")
        let interactor = createInterator()
        
        interactor.projectFileSelector(projectFileSelector, fileSelected: url)

        XCTAssertEqual(presenter.calledMethods, [.showAsBusyWithMessageCalled, .clearBusyMessageCalled])
        XCTAssertEqual(presenter.assignedParameters, [.message])
        XCTAssertEqual(projectFactory.project.calledMethods, [])
        XCTAssertTrue(interactor.sourceFileSelector is MockSourceFileSelectorView)
        if let sourceFileSelector = interactor.sourceFileSelector as? MockSourceFileSelectorView {
            XCTAssertEqual(sourceFileSelector.calledMethods, [])
        }
        XCTAssertEqual(fileManager.calledMethods, [])
        XCTAssertEqual(recentDocumentManager.calledMethods, [.addUrlCalled])
        XCTAssertEqual(recentDocumentManager.assignedParameters, [.url])
        XCTAssertEqual(recentDocumentManager.url, url)
        XCTAssertEqual(documentController.calledMethods, [.noteNewRecentDocumentURLUrlCalled])
        XCTAssertEqual(documentController.assignedParameters, [.url])
        XCTAssertEqual(documentController.url, url)
    }

    // MARK: - SourceFileSelectorInterfaceDelegate methods -
    
    func test_sourceFileSelectorFileSelected_projectFileCreationSucceeds() {
        let sourceFileSelector = MockSourceFileSelectorView()
        let treeNode = TreeNode(groupMember: MockXcodeGroupMember(), type: .file)
        let interactor = createInterator()
            
        interactor.sourceFileSelector(sourceFileSelector, fileSelected: treeNode)
    
        XCTAssertEqual(presenter.calledMethods, [.canGenerateFileOrChooseDisplayFlagCalled, .setDisplayChoiceChoiceCalled])
        XCTAssertEqual(presenter.assignedParameters, [.flag, .choice])
        XCTAssertEqual(presenter.flag, false)
        XCTAssertEqual(presenter.choice, .mock)
        XCTAssertEqual(projectFactory.project.calledMethods, [])
        XCTAssertEqual(fileManager.calledMethods, [])
        XCTAssertEqual(recentDocumentManager.calledMethods, [])
        XCTAssertEqual(documentController.calledMethods, [])
    }

    // MARK: - SourceFileSelectorInterfaceDelegate methods -

    func test_protocolSelectorProtocolSelected() throws {
        let protocolSelector = MockProtocolSelectorView()
        let identifier = try XCTUnwrap(TokenSyntax(TokenKind.identifier("ABCD"), presence: .present))
        let protocolDeclaration = ProtocolDeclSyntax(identifier: identifier, members: MemberDeclBlockSyntax(members: MemberDeclListSyntax([])))
        let interactor = createInterator()

        interactor.protocolSelector(protocolSelector, protocolSelected: protocolDeclaration)
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertTrue(interactor.mockFileParameters is MockMockFileParametersView)
        if let mockFileParameters = interactor.mockFileParameters as? MockMockFileParametersView {
            XCTAssertEqual(mockFileParameters.calledMethods, [.setupForProtocolDeclarationCalled])
            XCTAssertEqual(mockFileParameters.assignedParameters, [.protocolDeclaration])
            XCTAssertEqual(mockFileParameters.protocolDeclaration, protocolDeclaration)
        }
    }

    // MARK: - MockFileParametersInterfaceDelegate methods -
    
    func test_mockFileParametersMethod_noCurrentProject() {
        let mockFileParameters = MockMockFileParametersView()
        let mockName = "Name"
        let includeTestableImport = true
        let swiftlintAware = true
        let testableTargetName = "Fred"
        let trackPropertyActivity = true
        let interactor = createInterator()
        interactor.currentProject = nil
        
        interactor.mockFileParameters(mockFileParameters, mockName: mockName, includeTestableImport: includeTestableImport, swiftlintAware: swiftlintAware, testableTargetName: testableTargetName, trackPropertyActivity: trackPropertyActivity)
        
        XCTAssertNotEqual(interactor.mockName, mockName)
        XCTAssertTrue(interactor.mockGeneratorFactory is MockMockGeneratorFactory)
        if let mockGeneratorFactory = interactor.mockGeneratorFactory as? MockMockGeneratorFactory {
            XCTAssertEqual(mockGeneratorFactory.mockGenerator.calledMethods, [])
        }
    }
    
    func test_mockFileParametersMethod_noCurrentSourceFile() {
        let mockFileParameters = MockMockFileParametersView()
        let mockName = "Name"
        let includeTestableImport = true
        let swiftlintAware = true
        let testableTargetName = "Fred"
        let trackPropertyActivity = true
        let interactor = createInterator()
        interactor.currentProject = MockProject()
        interactor.currentSourceFile = nil
        
        interactor.mockFileParameters(mockFileParameters, mockName: mockName, includeTestableImport: includeTestableImport, swiftlintAware: swiftlintAware, testableTargetName: testableTargetName, trackPropertyActivity: trackPropertyActivity)
        
        XCTAssertNotEqual(interactor.mockName, mockName)
        XCTAssertTrue(interactor.mockGeneratorFactory is MockMockGeneratorFactory)
        if let mockGeneratorFactory = interactor.mockGeneratorFactory as? MockMockGeneratorFactory {
            XCTAssertEqual(mockGeneratorFactory.mockGenerator.calledMethods, [])
        }
    }
    
    func test_mockFileParametersMethod_noCurrentProtocolDeclaration() {
        let mockFileParameters = MockMockFileParametersView()
        let mockName = "Name"
        let includeTestableImport = true
        let swiftlintAware = true
        let testableTargetName = "Fred"
        let trackPropertyActivity = true
        let interactor = createInterator()
        interactor.currentProject = MockProject()
        interactor.currentSourceFile = SourceFileInformation(viewMode: .sourceAccurate)
        interactor.currentProtocolDeclaration = nil
        
        interactor.mockFileParameters(mockFileParameters, mockName: mockName, includeTestableImport: includeTestableImport, swiftlintAware: swiftlintAware, testableTargetName: testableTargetName, trackPropertyActivity: trackPropertyActivity)
        
        XCTAssertNotEqual(interactor.mockName, mockName)
        XCTAssertTrue(interactor.mockGeneratorFactory is MockMockGeneratorFactory)
        if let mockGeneratorFactory = interactor.mockGeneratorFactory as? MockMockGeneratorFactory {
            XCTAssertEqual(mockGeneratorFactory.mockGenerator.calledMethods, [])
        }
    }
    
    func test_mockFileParametersMethod_mockNameIsEmpty() throws {
        let mockFileParameters = MockMockFileParametersView()
        let mockName = ""
        let includeTestableImport = true
        let swiftlintAware = true
        let testableTargetName = "Fred"
        let trackPropertyActivity = true
        let interactor = createInterator()
        interactor.currentProject = MockProject()
        interactor.currentSourceFile = SourceFileInformation(viewMode: .sourceAccurate)
        let identifier = try XCTUnwrap(TokenSyntax(TokenKind.identifier("ABCD"), presence: .present))
        interactor.currentProtocolDeclaration = ProtocolDeclSyntax(identifier: identifier, members: MemberDeclBlockSyntax(members: MemberDeclListSyntax([])))
        
        interactor.mockFileParameters(mockFileParameters, mockName: mockName, includeTestableImport: includeTestableImport, swiftlintAware: swiftlintAware, testableTargetName: testableTargetName, trackPropertyActivity: trackPropertyActivity)
        
        XCTAssertEqual(interactor.mockName, "")
        XCTAssertEqual(interactor.mockCode, "")
        XCTAssertTrue(interactor.mockGeneratorFactory is MockMockGeneratorFactory)
        if let mockGeneratorFactory = interactor.mockGeneratorFactory as? MockMockGeneratorFactory {
            XCTAssertEqual(mockGeneratorFactory.mockGenerator.calledMethods, [])
        }
    }

    func test_mockFileParametersMethod_mockNameIsValid() throws {
        let mockFileParameters = MockMockFileParametersView()
        let mockName = "Name"
        let includeTestableImport = true
        let swiftlintAware = true
        let testableTargetName = "Fred"
        let trackPropertyActivity = true
        let interactor = createInterator()
        interactor.currentProject = MockProject()
        interactor.currentSourceFile = SourceFileInformation(viewMode: .sourceAccurate)
        let identifier = try XCTUnwrap(TokenSyntax(TokenKind.identifier("ABCD"), presence: .present))
        interactor.currentProtocolDeclaration = ProtocolDeclSyntax(identifier: identifier, members: MemberDeclBlockSyntax(members: MemberDeclListSyntax([])))

        interactor.mockFileParameters(mockFileParameters, mockName: mockName, includeTestableImport: includeTestableImport, swiftlintAware: swiftlintAware, testableTargetName: testableTargetName, trackPropertyActivity: trackPropertyActivity)
        
        XCTAssertEqual(interactor.mockName, mockName)
        XCTAssertTrue(interactor.mockGeneratorFactory is MockMockGeneratorFactory)
        if let mockGeneratorFactory = interactor.mockGeneratorFactory as? MockMockGeneratorFactory {
            XCTAssertEqual(mockGeneratorFactory.mockGenerator.calledMethods, [.generateMockCodeForParametersCalled])
            XCTAssertEqual(mockGeneratorFactory.mockGenerator.assignedParameters, [.parameters])
            XCTAssertEqual(mockGeneratorFactory.mockGenerator.parameters?.mockName, mockName)
            XCTAssertEqual(mockGeneratorFactory.mockGenerator.parameters?.includeTestableImport, includeTestableImport)
            XCTAssertEqual(mockGeneratorFactory.mockGenerator.parameters?.testableTargetName, testableTargetName)
            XCTAssertEqual(mockGeneratorFactory.mockGenerator.parameters?.trackPropertyActivity, trackPropertyActivity)
        }
    }

    // MARK: - FilterInterfaceDelegate methods -
    
    func test_filterNewValue() {
        let filterInterface = MockFilterInterface()
        let newValue = "ABCD"
        userDefaults.sourceFileFilterValue = newValue
        let interactor = createInterator()
        interactor.currentProject = MockProject()

        interactor.filter(filterInterface, newValue: newValue)
        
        XCTAssertTrue(interactor.filteringHandler is MockAsyncFilteringHandler)
        if let filteringHandler = interactor.filteringHandler as? MockAsyncFilteringHandler {
            XCTAssertEqual(filteringHandler.calledMethods, [.performFilteringOnProjectWithFilterCompletionHandlerCalled])
            XCTAssertEqual(filteringHandler.assignedParameters, [.project, .filter, .completionHandler])
            XCTAssertEqual(filteringHandler.filter, newValue)
        }
    }
}

//swiftlint:enable type_body_length file_length
