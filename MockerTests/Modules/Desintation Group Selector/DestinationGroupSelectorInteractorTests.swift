//
//  DestinationGroupSelectorInteractorTests.swift
//  MockerTests
//
//  Created by Greg on 3/3/18.
//

import XCTest
@testable import Mocker

class DestinationGroupSelectorInteractorTests: XCTestCase {

    var presenter: MockDestinationGroupSelectorInteractorOutput!
    var userDefaults: KeyValueStoring!
    
    override func setUp() {
        super.setUp()
        
        presenter = MockDestinationGroupSelectorInteractorOutput()
        userDefaults = MockUserDefaults()
    }

    // MARK: - init -
    
    func testInit() {
        
        let interactor = DestinationGroupSelectorInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        XCTAssertEqual(presenter.calledMethods, [])
    }
    
    // MARK: - DestinationGroupSelectorInteractorInputProtocol methods -
    
    func test_nodeSelected() {
        let treeNode = TreeNode(groupMember: MockXcodeGroupMember(), type: .group)
        let interactor = DestinationGroupSelectorInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()

        interactor.nodeSelected(treeNode)
        
        XCTAssertEqual(presenter.calledMethods, [])
    }

    func test_viewHasLoaded() {
        let interactor = DestinationGroupSelectorInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.viewHasLoaded()
        
        XCTAssertEqual(presenter.calledMethods, [])
    }
    
    // MARK: - DestinationGroupSelectorInterfaceProtocol methods -

    func test_presentTreeForProject() {
        let treeNode = TreeNode(groupMember: MockXcodeGroupMember(), type: .group)
        let project = MockProject()
        let interactor = DestinationGroupSelectorInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.present(tree: treeNode, for: project)
        
        XCTAssertEqual(presenter.calledMethods, [.presentTreeRootTreeNodeForProjectCalled])
        XCTAssertEqual(presenter.assignedParameters, [.rootTreeNode, .project])
    }

}
