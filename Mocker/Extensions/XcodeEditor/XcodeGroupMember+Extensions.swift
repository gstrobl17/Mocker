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
    
    func target(in dataSource: SourceFileDataSource) -> XCTarget! {
        var target: XCTarget!
        
        if let path = pathRelativeToProjectRoot() {
            let components = path.split(separator: "/")
            if let first = components.first {
                let name = String(first)
                target = dataSource.target(withName: name)
            }
        }
        
        return target
    }
    
}
