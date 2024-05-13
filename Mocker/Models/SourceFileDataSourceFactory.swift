//
//  SourceFileDataSourceFactory.swift
//  Mocker
//
//  Created by Greg Strobl on 5/13/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

struct SourceFileDataSourceFactory: SourceFileDataSourceCreating {
    
    func createDataSource(for fileURL: URL) -> SourceFileDataSource? {
        
        //TODO: added code to inspect the url and determine whether to create a data source
        //      for an Xcode project file or a Swift Package
        
        XCProjectDataSource(filePath: fileURL.path)
    }
    
}
