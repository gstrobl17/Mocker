//
//  URL+Extensions.swift
//  Mocker
//
//  Created by Greg Strobl on 5/15/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

extension URL {
    
    var isXcodeProjectFile: Bool {
        pathExtension == "xcodeproj"
    }

    var isSwiftPackageManifestFile: Bool {
        lastPathComponent == "Package.swift"
    }

    var isDirectory: Bool {
        guard let values = try? resourceValues(forKeys: [.isDirectoryKey]),
              let isDirectory = values.isDirectory else { return false }
        return isDirectory
    }

}
