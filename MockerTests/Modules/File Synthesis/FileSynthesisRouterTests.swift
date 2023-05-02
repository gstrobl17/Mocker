//
//  FileSynthesisRouterTests.swift
//  MockerTests
//
//  Created by Greg on 3/7/18.
//

import XCTest
@testable import Mocker

class FileSynthesisRouterTests: XCTestCase {
    
    let mockName = "MockTestProtocol"
    let mockCode = "10 print a"
    let project = MockProject()
    let fileSynthesizer = MockFileSynthesizer()
    let userDefaults = MockUserDefaults()
    let fileManager = MockFileManager()
    
    override func setUp() {
        super.setUp()
        
        let treeNode = TreeNode(groupMember: MockXcodeGroupMember(), type: .group)
        project.traverseFilteredByFilterMonitoredByReturnValue = (fileTree: treeNode, groupTree: treeNode)
    }
    
    func testCreateModule() {
        
        let viewController = FileSynthesisRouter.createModule(mockName: mockName,
                                                              mockCode: mockCode,
                                                              project: project,
                                                              fileSynthesizer: fileSynthesizer,
                                                              userDefaults: userDefaults,
                                                              fileManager: fileManager,
                                                              destinationGroupSelectorRouterType: MockDestinationGroupSelectorRouter.self)
        
        XCTAssertTrue(viewController is FileSynthesisViewProtocol)
        if let viewController = viewController as? FileSynthesisViewProtocol {
            XCTAssertNotNil(viewController.presenter)
            if let presenter = viewController.presenter {
                XCTAssertTrue(presenter is FileSynthesisPresenter)
                if let presenter = presenter as? FileSynthesisPresenter {
                    XCTAssertNotNil(presenter.router.viewController)
                    XCTAssertTrue(presenter.router.viewController === viewController)
                }
            }
        }
    }

}
