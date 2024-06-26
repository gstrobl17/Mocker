//
//  SourceFileDataSource.swift
//  Mocker
//
//  Created by Greg Strobl on 5/13/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

typealias ProjectTraversalResult = (fileTree: TreeNode, groupTree: TreeNode)

/// Protocol to abstract the interface required by Mocker to connect with either an Xcode project file or a Swift Package.
///
/// This replaces the previous ``Project`` abstraction used to abstract the ``XCProject`` from **XcodeEditor**
protocol SourceFileDataSource: AnyObject {

    var projectName: String? { get }
    var projectDirectoryURL: URL? { get }
    var organizationName: String? { get }
    var targets: [String] { get }
    func traverse(filteredBy filter: String, monitoredBy: CancelMonitoring) -> ProjectTraversalResult
}
