//
//  ProjectFactory.swift
//  Mocker
//
//  Created by Greg on 2/23/18.
//

import Foundation

protocol ProjectFactory {
    func createProject(for filePath: String) -> Project?
}
