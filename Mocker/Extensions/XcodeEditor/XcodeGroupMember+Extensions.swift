//
//  XcodeGroupMember+Extensions.swift
//  Mocker
//
//  Created by Greg on 2/25/18.
//

import XcodeEditor

extension XcodeGroupMember {
    
    func url(in dataSource: SourceFileDataSource) -> URL? {
        var url: URL?
        
        if let projectDirectoryURL = dataSource.projectDirectoryURL {
            url = projectDirectoryURL.appendingPathComponent(pathRelativeToProjectRoot())
        }
        
        return url
    }
    
    func target(in dataSource: SourceFileDataSource) -> String? {
        guard let dataSource = dataSource as? XCProjectDataSource,
              let project = dataSource.project as? XCProject else { return nil }
        var target: String?
        
        if let path = pathRelativeToProjectRoot() {
            let components = path.split(separator: "/")
            if let first = components.first {
                let name = String(first)
                let xcodeTarget = project.target(withName: name)
                target = xcodeTarget?.nameForCode
            }
        }
        
        return target
    }
    
}
