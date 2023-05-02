//
//  MockFileSynthesizer.swift
//  MockerTests
//
//  Created by Strobl, Greg on 3/7/18.
//

import Foundation
import XcodeEditor
@testable import Mocker

class MockFileSynthesizer: FileSynthesizing {
    
    weak var delegate: FileSynthesizingDelegate?
    
    private(set) var synthesizeCalled = false

    private(set) var name: String?
    private(set) var code: String?
    private(set) var group: XCGroup?
    private(set) var project: Project?
    private(set) var fileManager: FileManaging?
    private(set) var addNewFileToProject: Bool?

    var synthesizeResultToReturn: FileSynthesizingResult = .fileCreated
    var synthesizeShouldThrow = false
    var errorToThrow: Error!

    func reset() {
        synthesizeCalled = false
        name = nil
        code = nil
        group = nil
        project = nil
        fileManager = nil
        addNewFileToProject = nil
    }
    
    // swiftlint:disable function_parameter_count
    func synthesize(file name: String,
                    with code: String,
                    in group: XCGroup,
                    containedIn project: Project,
                    using fileManager: FileManaging,
                    addNewFileToProject: Bool) throws -> FileSynthesizingResult {
        synthesizeCalled = true
        self.name = name
        self.code = code
        self.group = group
        self.project = project
        self.fileManager = fileManager
        self.addNewFileToProject = addNewFileToProject
        
        if synthesizeShouldThrow {
            throw errorToThrow
        }
        return synthesizeResultToReturn
    }
    // swiftlint:enable function_parameter_count

}
