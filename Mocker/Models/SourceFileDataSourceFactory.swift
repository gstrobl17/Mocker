//
//  SourceFileDataSourceFactory.swift
//  Mocker
//
//  Created by Greg Strobl on 5/13/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

struct SourceFileDataSourceFactory: SourceFileDataSourceCreating {
    
    func createDataSource(for fileURL: URL) throws -> (any SourceFileDataSource)? {
        
        if fileURL.isXcodeProjectFile {
            return XCProjectDataSource(filePath: fileURL.path)
        }
        
        if fileURL.isSwiftPackageManifestFile {
            return try SwiftPackageDataSource(fileURL: fileURL)
        }
        
        if fileURL.isDirectory {
            return try DirectoryDataSource(directoryURL: fileURL, fileManager: FileManager.default)
        }
            
        print("Unable to create Source File Data Source for \(fileURL)")
        return nil
    }
    
}
