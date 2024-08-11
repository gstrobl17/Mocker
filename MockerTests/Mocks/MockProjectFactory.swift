//
//  MockProjectFactory.swift
//  MockerTests
//
//  Created by Greg on 2/23/18.
//

@testable import Mocker

class MockProjectFactory: ProjectFactory {
    let project = MockProject()
    var returnProjectFromCreate = true
    
    func createProject(for filePath: String) -> (any Project)? {
        var project: (any Project)?
        if returnProjectFromCreate {
            self.project.reset()
            project = self.project
        }
        return project
    }
    
}
