//
//  FileSynthesizer.swift
//  Mocker
//
//  Created by Strobl, Greg on 3/7/18.
//

import Foundation
import XcodeEditor

class FileSynthesizer: FileSynthesizing {
    
    let fileExtension = "swift"
    
    weak var delegate: FileSynthesizingDelegate?
    
    enum SynthesisError: Error {
        case failedToGetURLForGroup
        case delegateNotSet
        case targetForGroupNotFound
        case failedToCreateSourceDefinitionFileObject
        case failedToCreateSourceFileObject
    }
    
    // swiftlint:disable function_parameter_count
    func synthesize(file name: String,
                    with code: String,
                    in group: XCGroup,
                    containedIn project: Project,
                    using fileManager: FileManaging,
                    addNewFileToProject: Bool) throws -> FileSynthesizingResult {
        
        // Generate the URL for the file to synthesize
        if let groupURL = group.url(in: project) {
            let fileURL = groupURL.appendingPathComponent(name).appendingPathExtension(fileExtension)
            
            // Test if the file already exists
            if fileManager.fileExists(atPath: fileURL.path) {
                if let delegate = delegate {
                    let overwrite = delegate.fileSynthesizerShouldOverwrite(self, existingFile: fileURL.lastPathComponent)
                    if overwrite == false {
                        return .fileNotCreated
                    }
                    try fileManager.removeItem(atPath: fileURL.path)
                } else {
                    throw SynthesisError.delegateNotSet
                }
            }
            
            // Save the code to the file
            try code.write(to: fileURL, atomically: true, encoding: .utf8)
            
            // Try to add the new file to git
            _ = bash(currentDirectoryPath: groupURL.path, command: "git", arguments: ["add", fileURL.lastPathComponent])
            
            // Add the file to the project
            if addNewFileToProject {
                
                // Add the file to the target
                if let target = group.target(in: project) {
                    
                    if let sourceFileDefinition = XCSourceFileDefinition(name: fileURL.lastPathComponent,
                                                                         data: nil,
                                                                         type: .SourceCodeSwift) {
                        sourceFileDefinition.fileOperationType = XCFileOperationTypeAcceptExisting
                        group.addSourceFile(sourceFileDefinition)
                        if let sourceFile = project.file(withName: fileURL.lastPathComponent) {
                            target.addMember(sourceFile)
                            project.save()
                        } else {
                            throw SynthesisError.failedToCreateSourceFileObject
                        }
                        
                    } else {
                        throw SynthesisError.failedToCreateSourceDefinitionFileObject
                    }
                    
                } else {
                    throw SynthesisError.targetForGroupNotFound
                }

            }
            
        } else {
            throw SynthesisError.failedToGetURLForGroup
        }
        
        return .fileCreated
    }
    // swiftlint:enable function_parameter_count

    func shell(currentDirectoryPath: String?, launchPath: String, arguments: [String]) -> String {
        let task = Process()
        if let currentDirectoryPath = currentDirectoryPath {
            task.currentDirectoryPath = currentDirectoryPath
        }
        task.launchPath = launchPath
        task.arguments = arguments
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: String.Encoding.utf8) ?? ""
        return output.trimmingCharacters(in: .newlines)
    }
    
    func bash(currentDirectoryPath: String, command: String, arguments: [String]) -> String {
        let whichPathForCommand = shell(currentDirectoryPath: nil, launchPath: "/bin/bash", arguments: [ "-l", "-c", "which \(command)" ])
        return shell(currentDirectoryPath: currentDirectoryPath, launchPath: whichPathForCommand, arguments: arguments)
    }

}
