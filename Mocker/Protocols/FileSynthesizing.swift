//
//  FileSynthesizing.swift
//  Mocker
//
//  Created by Strobl, Greg on 3/7/18.
//

import Foundation
import XcodeEditor

enum FileSynthesizingResult {
    case fileNotCreated
    case fileCreated
}

protocol FileSynthesizing: AnyObject {
    var delegate: FileSynthesizingDelegate? { get set }
    
    // swiftlint:disable function_parameter_count
    func synthesize(file name: String,
                    with code: String,
                    in group: XCGroup,
                    containedIn project: Project,
                    using fileManager: FileManaging,
                    addNewFileToProject: Bool) throws -> FileSynthesizingResult
    // swiftlint:enable function_parameter_count
}
