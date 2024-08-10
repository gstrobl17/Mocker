//
//  XCProjectFactory.swift
//  Mocker
//
//  Created by Greg on 2/23/18.
//

import Foundation
import XcodeEditor

struct XCProjectFactory: ProjectFactory {
    
    func createProject(for filePath: String) -> (any Project)? {
        XCProject(filePath: filePath)
    }
    
}
