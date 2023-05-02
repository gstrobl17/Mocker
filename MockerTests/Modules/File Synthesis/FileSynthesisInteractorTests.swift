// swiftlint:disable type_body_length
//
//  FileSynthesisInteractorTests.swift
//  MockerTests
//
//  Created by Greg on 3/9/18.
//

import XCTest
import XcodeEditor
@testable import Mocker

class FileSynthesisInteractorTests: XCTestCase {

    var presenter: MockFileSynthesisInteractorOutput!
    let mockName = "MockThing"
    let mockCode = "class MockThing { }"
    var project: MockProject!
    var fileSynthesizer: MockFileSynthesizer!
    var userDefaults: MockUserDefaults!
    var fileManager: MockFileManager!
    let destinationGroupSelectorRouterType = MockDestinationGroupSelectorRouter.self
    var interface: MockDestinationGroupSelectorInterface!

    override func setUp() {
        super.setUp()
        
        presenter = MockFileSynthesisInteractorOutput()
        project = MockProject()
        fileSynthesizer = MockFileSynthesizer()
        userDefaults = MockUserDefaults()
        fileManager = MockFileManager()
        interface = MockDestinationGroupSelectorInterface()
        
        let treeNode = TreeNode(groupMember: MockXcodeGroupMember(), type: .group)
        project.traverseFilteredByFilterMonitoredByReturnValue = (fileTree: treeNode, groupTree: treeNode)
    }

    // MARK: - init -
    
    func testInit() {
        
        let interactor = FileSynthesisInteractor(mockName: mockName,
                                                 mockCode: mockCode,
                                                 project: project,
                                                 fileSynthesizer: fileSynthesizer,
                                                 userDefaults: userDefaults,
                                                 fileManager: fileManager,
                                                 destinationGroupSelectorRouterType: destinationGroupSelectorRouterType)
        interactor.presenter = presenter

        XCTAssertEqual(presenter.calledMethods, [.installDestinationGroupSelectorCalled, .groupWasSelectedCalled, .setAddNewFileToProjectCheckboxFlagCalled])
        XCTAssertEqual(presenter.assignedParameters, [.destinationGroupSelector, .flag])
    }
    
    // MARK: - FileSynthesisInteractorInputProtocol methods -
    
    func test_generateMockFile_noGroup() {
        let interactor = FileSynthesisInteractor(mockName: mockName,
                                                 mockCode: mockCode,
                                                 project: project,
                                                 fileSynthesizer: fileSynthesizer,
                                                 userDefaults: userDefaults,
                                                 fileManager: fileManager,
                                                 destinationGroupSelectorRouterType: destinationGroupSelectorRouterType)
        interactor.presenter = presenter
        presenter.reset()

        interactor.generateMockFile()
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(fileSynthesizer.synthesizeCalled, false)
        XCTAssertNil(fileSynthesizer.delegate)
    }
    
    func test_generateMockFile_synthesisThrows() {
        let interactor = FileSynthesisInteractor(mockName: mockName,
                                                 mockCode: mockCode,
                                                 project: project,
                                                 fileSynthesizer: fileSynthesizer,
                                                 userDefaults: userDefaults,
                                                 fileManager: fileManager,
                                                 destinationGroupSelectorRouterType: destinationGroupSelectorRouterType)
        interactor.presenter = presenter
        interactor.group = XCGroup()
        presenter.reset()
        fileSynthesizer.errorToThrow = UnitTestError.generic
        fileSynthesizer.synthesizeShouldThrow = true
        
        interactor.generateMockFile()
        
        XCTAssertEqual(presenter.calledMethods, [.mockFileCreationFailedErrorCalled])
        XCTAssertEqual(presenter.assignedParameters, [.error])
        XCTAssertEqual(fileSynthesizer.synthesizeCalled, true)
        XCTAssertNotNil(fileSynthesizer.delegate)
        XCTAssertTrue(fileSynthesizer.delegate === interactor)
    }
    
    func test_generateMockFile_synthesisSucceeds() {
        let interactor = FileSynthesisInteractor(mockName: mockName,
                                                 mockCode: mockCode,
                                                 project: project,
                                                 fileSynthesizer: fileSynthesizer,
                                                 userDefaults: userDefaults,
                                                 fileManager: fileManager,
                                                 destinationGroupSelectorRouterType: destinationGroupSelectorRouterType)
        interactor.presenter = presenter
        interactor.group = XCGroup()
        presenter.reset()
        
        interactor.generateMockFile()
        
        XCTAssertEqual(presenter.calledMethods, [.mockFileWasCreatedCalled])
        XCTAssertEqual(presenter.assignedParameters, [])
        XCTAssertEqual(fileSynthesizer.synthesizeCalled, true)
        XCTAssertNotNil(fileSynthesizer.delegate)
        XCTAssertTrue(fileSynthesizer.delegate === interactor)
    }

    func test_addNewFileToProjectChanged_true() {
        let interactor = FileSynthesisInteractor(mockName: mockName,
                                                 mockCode: mockCode,
                                                 project: project,
                                                 fileSynthesizer: fileSynthesizer,
                                                 userDefaults: userDefaults,
                                                 fileManager: fileManager,
                                                 destinationGroupSelectorRouterType: destinationGroupSelectorRouterType)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.addNewFileToProjectChanged(true)
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(userDefaults.addNewFileToProject, true)
    }
    
    func test_addNewFileToProjectChanged_false() {
        let interactor = FileSynthesisInteractor(mockName: mockName,
                                                 mockCode: mockCode,
                                                 project: project,
                                                 fileSynthesizer: fileSynthesizer,
                                                 userDefaults: userDefaults,
                                                 fileManager: fileManager,
                                                 destinationGroupSelectorRouterType: destinationGroupSelectorRouterType)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.addNewFileToProjectChanged(false)
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(userDefaults.addNewFileToProject, false)
    }

    func test_viewHasLoaded() {
        let interactor = FileSynthesisInteractor(mockName: mockName,
                                                 mockCode: mockCode,
                                                 project: project,
                                                 fileSynthesizer: fileSynthesizer,
                                                 userDefaults: userDefaults,
                                                 fileManager: fileManager,
                                                 destinationGroupSelectorRouterType: destinationGroupSelectorRouterType)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.viewHasLoaded()
        
        XCTAssertEqual(presenter.calledMethods, [.installDestinationGroupSelectorCalled, .groupWasSelectedCalled, .setAddNewFileToProjectCheckboxFlagCalled])
        XCTAssertEqual(presenter.assignedParameters, [.destinationGroupSelector, .flag])
    }
    
    func test_viewHasLoaded_noPresenter() {
        let interactor = FileSynthesisInteractor(mockName: mockName,
                                                 mockCode: mockCode,
                                                 project: project,
                                                 fileSynthesizer: fileSynthesizer,
                                                 userDefaults: userDefaults,
                                                 fileManager: fileManager,
                                                 destinationGroupSelectorRouterType: destinationGroupSelectorRouterType)
        
        interactor.viewHasLoaded()
        
        XCTAssertEqual(presenter.calledMethods, [])
    }

    // MARK: - FileSynthesizingDelegate methods -
    
    func test_fileSynthesizerShouldOverwrite_noPresenter_returnsFalse() {
        let name = "name"
        let interactor = FileSynthesisInteractor(mockName: mockName,
                                                 mockCode: mockCode,
                                                 project: project,
                                                 fileSynthesizer: fileSynthesizer,
                                                 userDefaults: userDefaults,
                                                 fileManager: fileManager,
                                                 destinationGroupSelectorRouterType: destinationGroupSelectorRouterType)
        
        let shouldOverwrite = interactor.fileSynthesizerShouldOverwrite(fileSynthesizer, existingFile: name)
        
        XCTAssertEqual(shouldOverwrite, false)
        XCTAssertEqual(presenter.calledMethods, [])
    }
    
    func test_fileSynthesizerShouldOverwrite_returnsFalse() {
        let name = "name"
        let interactor = FileSynthesisInteractor(mockName: mockName,
                                                 mockCode: mockCode,
                                                 project: project,
                                                 fileSynthesizer: fileSynthesizer,
                                                 userDefaults: userDefaults,
                                                 fileManager: fileManager,
                                                 destinationGroupSelectorRouterType: destinationGroupSelectorRouterType)
        interactor.presenter = presenter
        presenter.shouldOverwriteExistingFileNameReturnValue = false
        presenter.reset()
        
        let shouldOverwrite = interactor.fileSynthesizerShouldOverwrite(fileSynthesizer, existingFile: name)
        
        XCTAssertEqual(shouldOverwrite, false)
        XCTAssertEqual(presenter.calledMethods, [.shouldOverwriteExistingFileNameCalled])
        XCTAssertEqual(presenter.assignedParameters, [.name])
        XCTAssertEqual(presenter.name, name)
    }
    
    func test_fileSynthesizerShouldOverwrite_returnsTrue() {
        let name = "name"
        let interactor = FileSynthesisInteractor(mockName: mockName,
                                                 mockCode: mockCode,
                                                 project: project,
                                                 fileSynthesizer: fileSynthesizer,
                                                 userDefaults: userDefaults,
                                                 fileManager: fileManager,
                                                 destinationGroupSelectorRouterType: destinationGroupSelectorRouterType)
        interactor.presenter = presenter
        presenter.shouldOverwriteExistingFileNameReturnValue = true
        presenter.reset()
        
        let shouldOverwrite = interactor.fileSynthesizerShouldOverwrite(fileSynthesizer, existingFile: name)
        
        XCTAssertEqual(shouldOverwrite, true)
        XCTAssertEqual(presenter.calledMethods, [.shouldOverwriteExistingFileNameCalled])
        XCTAssertEqual(presenter.assignedParameters, [.name])
        XCTAssertEqual(presenter.name, name)
    }

    // MARK: - DestinationGroupSelectorInterfaceDelegate methods -

    func test_destinationGroupSelector_nonGroupTreeNode() {
        let treeNode = TreeNode(groupMember: MockXcodeGroupMember(), type: .group)
        let interactor = FileSynthesisInteractor(mockName: mockName,
                                                 mockCode: mockCode,
                                                 project: project,
                                                 fileSynthesizer: fileSynthesizer,
                                                 userDefaults: userDefaults,
                                                 fileManager: fileManager,
                                                 destinationGroupSelectorRouterType: destinationGroupSelectorRouterType)
        interactor.presenter = presenter
        presenter.reset()
        XCTAssertNil(interactor.group)

        interactor.destinationGroupSelector(interface, groupSelected: treeNode)
        
        XCTAssertNil(interactor.group)
        XCTAssertEqual(presenter.calledMethods, [])
    }

    func test_destinationGroupSelector() {
        let treeNode = TreeNode(groupMember: XCGroup(), type: .group)
        let interactor = FileSynthesisInteractor(mockName: mockName,
                                                 mockCode: mockCode,
                                                 project: project,
                                                 fileSynthesizer: fileSynthesizer,
                                                 userDefaults: userDefaults,
                                                 fileManager: fileManager,
                                                 destinationGroupSelectorRouterType: destinationGroupSelectorRouterType)
        interactor.presenter = presenter
        presenter.reset()
        XCTAssertNil(interactor.group)
        
        interactor.destinationGroupSelector(interface, groupSelected: treeNode)
        
        XCTAssertNotNil(interactor.group)
        XCTAssertEqual(presenter.calledMethods, [.groupWasSelectedCalled])
        XCTAssertEqual(presenter.assignedParameters, [])
    }

}
