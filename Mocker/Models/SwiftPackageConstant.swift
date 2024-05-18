//swiftlint:disable nesting
//
//  SwiftPackageConstant.swift
//  Mocker
//
//  Created by Greg Strobl on 5/16/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

enum SwiftPackageConstant {
    enum Manifest {
        static let requiredImportedModuleName = "PackageDescription"
        static let requiredVariableName = "package"
        static let requiredTypeOfVariableName = "Package"
        
        enum ArgumentName {
            static let name = "name"
            static let targets = "targets"
        }
        
        enum TargetType {
            static let target = "target"
            static let testTarget = "testTarget"
        }
    }
    
    enum File {
        static let manifestFileName = "Package.swift"
        static let sourcesDirectory = "Sources"
        static let swiftFileExtension = "swift"
    }
}
//swiftlint:enable nesting
