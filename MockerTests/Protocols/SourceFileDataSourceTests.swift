//
//  SourceFileDataSourceTests.swift
//  MockerTests
//
//  Created by Greg Strobl on 8/11/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import XCTest
@testable import Mocker

final private class SourceFileDataSourceA: SourceFileDataSource {
    
    let projectName: String?
    let projectDirectoryURL: URL?
    let organizationName: String?
    let targets: [String]
    
    init(
        projectName: String? = nil,
        projectDirectoryURL: URL? = nil,
        organizationName: String? = nil,
        targets: [String] = []
    ) {
        self.projectName = projectName
        self.projectDirectoryURL = projectDirectoryURL
        self.organizationName = organizationName
        self.targets = targets
    }
    
    func traverse(filteredBy filter: String, monitoredBy: any Mocker.CancelMonitoring, fileManager: any Mocker.FileManaging) -> Mocker.SendableTreeNode {
        SendableTreeNode(type: .file, name: "FILE", fileURL: nil, target: nil, children: [])
    }
    
}

private struct SourceFileDataSourceB: SourceFileDataSource {
    let projectName: String?
    let projectDirectoryURL: URL?
    let organizationName: String?
    let targets: [String]
    
    init(
        projectName: String? = nil,
        projectDirectoryURL: URL? = nil,
        organizationName: String? = nil,
        targets: [String] = []
    ) {
        self.projectName = projectName
        self.projectDirectoryURL = projectDirectoryURL
        self.organizationName = organizationName
        self.targets = targets
    }
    
    func traverse(filteredBy filter: String, monitoredBy: any Mocker.CancelMonitoring, fileManager: any Mocker.FileManaging) -> Mocker.SendableTreeNode {
        SendableTreeNode(type: .file, name: "FILE", fileURL: nil, target: nil, children: [])
    }
}

final class SourceFileDataSourceTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    // MARK: - isEqual(_:)
    
    func testIsEqual_rhsNotSourceFileDataSourc() {
        let a = SourceFileDataSourceA()
        let b = 123
        
        XCTAssertFalse(a.isEqual(b))
    }

    func testIsEqual_notSameObjectTypes() {
        let a = SourceFileDataSourceA()
        let b = SourceFileDataSourceB()
        
        XCTAssertFalse(a.isEqual(b))
        XCTAssertFalse(b.isEqual(a))
    }

    func testIsEqual_sameObjectTypesWithDifferentValue() {
        let a = SourceFileDataSourceA()
        var x = SourceFileDataSourceA()
        
        XCTAssertTrue(a.isEqual(x))
        XCTAssertTrue(x.isEqual(a))

        // Different project names
        x = SourceFileDataSourceA(projectName: "PROJECT-NAME")
        XCTAssertFalse(a.isEqual(x))
        XCTAssertFalse(x.isEqual(a))

        // Different project directory URLs
        x = SourceFileDataSourceA(projectDirectoryURL: URL(fileURLWithPath: "path"))
        XCTAssertFalse(a.isEqual(x))
        XCTAssertFalse(x.isEqual(a))

        // Different organization names
        x = SourceFileDataSourceA(organizationName: "ORG")
        XCTAssertFalse(a.isEqual(x))
        XCTAssertFalse(x.isEqual(a))

        // Different targets
        x = SourceFileDataSourceA(targets: ["A", "b", "C"])
        XCTAssertFalse(a.isEqual(x))
        XCTAssertFalse(x.isEqual(a))
    }

}
