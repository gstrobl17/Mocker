//
//  SourceFileDataSource.swift
//  Mocker
//
//  Created by Greg Strobl on 5/13/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

/// Protocol to abstract the interface required by Mocker to connect with either an Xcode project file or a Swift Package.
///
/// This replaces the previous ``Project`` abstraction used to abstract the ``XCProject`` from **XcodeEditor**
protocol SourceFileDataSource: Sendable {

    var projectName: String? { get }
    var projectDirectoryURL: URL? { get }
    var organizationName: String? { get }
    var targets: [String] { get }
    
    func traverse(
        filteredBy filter: String,
        monitoredBy: any CancelMonitoring,
        fileManager: any FileManaging
    ) -> SendableTreeNode
    
}

extension SourceFileDataSource {
    
    func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? any SourceFileDataSource else { return false }
        
        return type(of: self) == type(of: rhs) &&
            projectName == rhs.projectName &&
            projectDirectoryURL == rhs.projectDirectoryURL &&
            organizationName == rhs.organizationName &&
            targets == rhs.targets
    }

}

