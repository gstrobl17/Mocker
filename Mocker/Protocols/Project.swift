//
//  Project.swift
//  Mocker
//
//  Created by Greg on 2/23/18.
//

import Foundation
import XcodeEditor

protocol Project: AnyObject {

    func targets() -> [XCTarget]!
    func objects() -> NSMutableDictionary!

    func traverse(filteredBy filter: String, monitoredBy: CancelMonitoring) -> ProjectTraversalResult
    func file(withKey key: String!) -> XCSourceFile!
    func filePath() -> String!
    func groupWithPath(fromRoot: String!) -> XCGroup!
    func target(withName name: String!) -> XCTarget!
  
}

extension Project {
    
    var projectFileURL: URL? {
        var url: URL?
        if let filePath = self.filePath() {
            url = URL(fileURLWithPath: filePath)
        }
        return url
    }
    
    var projectDirectoryURL: URL? {
        var url: URL?
        if let projectFileURL = self.projectFileURL {
            url = projectFileURL.deletingLastPathComponent()
        }
        return url
    }
    
    var organizationName: String? {
        var organizationName: String?
        var found = false
        
        if let objects = objects() {
            for object in objects {
                if let dictionary = object.value as? NSDictionary {
                    for object in dictionary {
                        if let key = object.key as? String,
                            key == "attributes",
                            let dictionary = object.value as? NSDictionary {
                            for object in dictionary {
                                if let key = object.key as? String,
                                    key == "ORGANIZATIONNAME",
                                    let value = object.value as? String {
                                    organizationName = value
                                    found = true
                                }
                                if found { break }
                            }
                        }
                    }
                    if found { break }
                }
                if found { break }
            }
        }
        return organizationName
    }

}
