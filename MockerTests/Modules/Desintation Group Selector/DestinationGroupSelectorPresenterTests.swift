//
//  DestinationGroupSelectorPresenterTests.swift
//  MockerTests
//
//  Created by Greg on 3/3/18.
//

import XCTest
@testable import Mocker

class DestinationGroupSelectorPresenterTests: XCTestCase {
    
    var view: MockDestinationGroupSelectorView!
    var interactor: MockDestinationGroupSelectorInteractorInput!
    var router: DestinationGroupSelectorWireframeProtocol!
    var presenter: DestinationGroupSelectorPresenter!
    
    override func setUp() {
        super.setUp()
        
        view = MockDestinationGroupSelectorView()
        interactor = MockDestinationGroupSelectorInteractorInput()
        router = DestinationGroupSelectorRouter()
        presenter = DestinationGroupSelectorPresenter(interface: view, interactor: interactor, router: router)
    }
    
    // MARK: - DestinationGroupSelectorPresenterProtocol methods -
    
    func test_nodeSelected_interactorWithOutSelectedNode() {
        let treeNode = TreeNode(groupMember: MockXcodeGroupMember(), type: .group)
        interactor.selectedNode = nil

        presenter.nodeSelected(treeNode)

        XCTAssertEqual(interactor.calledMethods, [.nodeSelectedTreeNodeCalled])
        XCTAssertEqual(interactor.assignedParameters, [.treeNode])
        XCTAssertEqual(view.calledMethods, [.enableNewGroupButtonFlagCalled])
        XCTAssertEqual(view.assignedParameters, [.flag])
        XCTAssertEqual(view.flag, false)
    }
    
    func test_nodeSelected_interactorWithSelectedNode() {
        let treeNode = TreeNode(groupMember: MockXcodeGroupMember(), type: .group)
        interactor.selectedNode = treeNode
        
        presenter.nodeSelected(treeNode)
        
        XCTAssertEqual(interactor.calledMethods, [.nodeSelectedTreeNodeCalled])
        XCTAssertEqual(interactor.assignedParameters, [.treeNode])
        XCTAssertEqual(view.calledMethods, [.enableNewGroupButtonFlagCalled])
        XCTAssertEqual(view.assignedParameters, [.flag])
        XCTAssertEqual(view.flag, true)
    }

    func test_viewHasLoaded() {
        
        presenter.viewHasLoaded()
        
        XCTAssertEqual(interactor.calledMethods, [.viewHasLoadedCalled])
        XCTAssertEqual(interactor.assignedParameters, [])
        XCTAssertEqual(view.calledMethods, [.enableNewGroupButtonFlagCalled])
        XCTAssertEqual(view.assignedParameters, [.flag])
    }

    // MARK: - DestinationGroupSelectorInteractorOutputProtocol methods -

    func test_presentTreeForProject() {
        let treeNode = TreeNode(groupMember: MockXcodeGroupMember(), type: .group)
        let project = MockProject()

        presenter.present(tree: treeNode, for: project)
        
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [.presentTreeRootTreeNodeForProjectCalled])
        XCTAssertEqual(view.assignedParameters, [.rootTreeNode, .project])
        XCTAssertTrue(view.rootTreeNode === treeNode)
    }

    func test_selectTreeNode() {
        let treeNode = TreeNode(groupMember: MockXcodeGroupMember(), type: .group)
        
        presenter.select(treeNode: treeNode)
        
        XCTAssertEqual(interactor.calledMethods, [])
        XCTAssertEqual(view.calledMethods, [.selectTreeNodeCalled, .enableNewGroupButtonFlagCalled])
        XCTAssertEqual(view.assignedParameters, [.treeNode, .flag])
    }

}
