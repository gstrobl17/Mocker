//
//  FileSynthesisPresenterTests.swift
//  MockerTests
//
//  Created by Greg on 3/7/18.
//

import XCTest
import XcodeEditor
@testable import Mocker

class FileSynthesisPresenterTests: XCTestCase {
    
    var view: MockFileSynthesisView!
    var interactor: MockFileSynthesisInteractorInput!
    var router: FileSynthesisWireframeProtocol!
    var presenter: FileSynthesisPresenter!
    
    override func setUp() {
        super.setUp()
        
        view = MockFileSynthesisView()
        interactor = MockFileSynthesisInteractorInput()
        router = FileSynthesisRouter()
        presenter = FileSynthesisPresenter(interface: view, interactor: interactor, router: router)
    }
    
    // MARK: - FileSynthesisPresenterProtocol methods -

    func test_createPressed() {
        
        presenter.createPressed()

        XCTAssertEqual(interactor.calledMethods, [.generateMockFileCalled])
        XCTAssertEqual(interactor.assignedParameters, [])
        XCTAssertEqual(view.calledMethods, [])
    }

    func test_addNewFileToProjectChanged_false() {
        
        presenter.addNewFileToProjectChanged(false)
        
        XCTAssertEqual(interactor.calledMethods, [.addNewFileToProjectChangedNewValueCalled])
        XCTAssertEqual(interactor.assignedParameters, [.newValue])
        XCTAssertEqual(interactor.newValue, false)
        XCTAssertEqual(view.calledMethods, [])
    }

    func test_addNewFileToProjectChanged_true() {
        
        presenter.addNewFileToProjectChanged(true)
        
        XCTAssertEqual(interactor.calledMethods, [.addNewFileToProjectChangedNewValueCalled])
        XCTAssertEqual(interactor.assignedParameters, [.newValue])
        XCTAssertEqual(interactor.newValue, true)
        XCTAssertEqual(view.calledMethods, [])
    }

    func test_viewHasLoaded() {
        
        presenter.viewHasLoaded()
        
        XCTAssertEqual(interactor.calledMethods, [.viewHasLoadedCalled])
        XCTAssertEqual(interactor.assignedParameters, [])
        XCTAssertEqual(view.calledMethods, [])
    }

    // MARK: - FileSynthesisInteractorOutputProtocol methods -
    
    func test_installDestinationGroupSelector() {
        let destinationGroupSelector = NSViewController()
        
        presenter.install(destinationGroupSelector: destinationGroupSelector)
        
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [.installDestinationGroupSelectorCalled])
        XCTAssertEqual(view.assignedParameters, [.destinationGroupSelector])
        XCTAssertTrue(view.destinationGroupSelector === destinationGroupSelector)
    }

    func test_groupWasSelected_noView() {
        presenter.view = nil
        
        presenter.groupWasSelected()
        
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [])
    }

    func test_groupWasSelected_noGroupActuallySelected() {
        
        presenter.groupWasSelected()
        
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [.enableCreateButtonFlagCalled])
        XCTAssertEqual(view.assignedParameters, [.flag])
        XCTAssertEqual(view.flag, false)
    }

    func test_groupWasSelected_groupActuallySelected() {
        interactor.group = XCGroup()
        
        presenter.groupWasSelected()
        
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [.enableCreateButtonFlagCalled])
        XCTAssertEqual(view.assignedParameters, [.flag])
        XCTAssertEqual(view.flag, true)
    }

    func test_mockFileWasCreated() {
        
        presenter.mockFileWasCreated()
        
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [.closeCalled])
        XCTAssertEqual(view.assignedParameters, [])
    }

    func test_mockFileCreationFailed() {
        let error = UnitTestError.generic
        
        presenter.mockFileCreationFailed(error)
        
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [.closeCalled, .displayAlertCalled])
        XCTAssertEqual(view.assignedParameters, [.alert])
    }

    func test_shouldOverwriteExistingFile_returnsFalse() {
        let name = "file.ABC"
        view.shouldOverwriteExistingFileNameReturnValue = false
        
        let shouldOverwrite = presenter.shouldOverwrite(existingFile: name)
        
        XCTAssertEqual(shouldOverwrite, false)
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [.shouldOverwriteExistingFileNameCalled])
        XCTAssertEqual(view.assignedParameters, [.name])
        XCTAssertEqual(view.name, name)
    }

    func test_shouldOverwriteExistingFile_returnsTrue() {
        let name = "file.ABC"
        view.shouldOverwriteExistingFileNameReturnValue = true
        
        let shouldOverwrite = presenter.shouldOverwrite(existingFile: name)
        
        XCTAssertEqual(shouldOverwrite, true)
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [.shouldOverwriteExistingFileNameCalled])
        XCTAssertEqual(view.assignedParameters, [.name])
        XCTAssertEqual(view.name, name)
    }

    func test_shouldOverwriteExistingFile_noViewSetReturnsFalse() {
        let name = "file.ABC"
        view.shouldOverwriteExistingFileNameReturnValue = true
        presenter.view = nil
        
        let shouldOverwrite = presenter.shouldOverwrite(existingFile: name)
        
        XCTAssertEqual(shouldOverwrite, false)
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [])
    }
}
