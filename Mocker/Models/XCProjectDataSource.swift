//
//  XCProjectDataSource.swift
//  Mocker
//
//  Created by Greg Strobl on 5/13/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation
import XcodeEditor

struct XCProjectDataSource: SourceFileDataSource {
    
    let project: any Project
    
    init?(filePath: String) {
        guard let project = XCProject(filePath: filePath) else { return nil}
        self.project = project
    }
    
    var projectName: String? {
        project.projectFileURL?.deletingPathExtension().lastPathComponent
    }
    
    var projectDirectoryURL: URL? {
        project.projectDirectoryURL
    }
    
    var organizationName: String? {
        project.organizationName
    }

    var targets: [String] {
        project.targets().compactMap { $0.nameForCode }
    }
    
    func traverse(
        filteredBy filter: String,
        monitoredBy monitor: any CancelMonitoring,
        fileManager: any FileManaging
    ) -> SendableTreeNode {
        project.traverse(filteredBy: filter, monitoredBy: monitor)
    }
    
    func file(withKey key: String!) -> XCSourceFile! {
        project.file(withKey: key)
    }
    
}
