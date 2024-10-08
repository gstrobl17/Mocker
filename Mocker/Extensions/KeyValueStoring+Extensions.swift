//
//  KeyValueStoring+Extensions.swift
//  Mocker
//
//  Created by Greg on 2/25/18.
//

import Foundation

enum UserDefaultsKey {
    static let projectFilePath = "Project File Path"
    static let lastDirectoryOfSelectedProject = "Last Directory of Selected Project"
    static let lastDirectoryOfSelectedFileToCompare = "Last Directory of File To Compare"
    static let leftPaneWidth = "Left Pane Width"
    static let mockPrefix = "Mock Prefix"
    static let includeHeader = "Include Header"
    static let stripTrailingProtocol = "Strip Trailing Protocol"
    static let includeTestableImport = "Include Testable Import"
    static let trackPropertyActivity = "Track Property Activity"
    static let `public` = "Public"
    static let previousSelectedGroupPath = "Previous Selected Group Path"
    static let addNewFileToProject = "Add New File To Project"
    static let windowFrameAutosaveName = "Window Frame Autosave Name"
    static let sourceFileFilterValue = "Source File Filter Value"
    static let recentDocuments = "Recent Documents"
    static let maxRecentDocumentCount = "Max Recent Document Count"
}

enum DefaultUserDefaultValue {
    static let mockPrefix = "Mock"
    static let includeHeader = true
    static let stripTrailingProtocol = true
    static let includeTestableImport = true
    static let trackPropertyActivity = false
    static let `public` = false
    static let addNewFileToProject = true
    static let maxRecentDocumentCount = 20
}

extension KeyValueStoring {
    
    var projectFilePath: String? {
        get {
            string(forKey: UserDefaultsKey.projectFilePath)
        }
        set {
            set(newValue, forKey: UserDefaultsKey.projectFilePath)
        }
    }
    
    var lastDirectoryOfSelectedProject: URL? {
        get {
            guard let path = object(forKey: UserDefaultsKey.lastDirectoryOfSelectedProject) as? NSString else { return nil }
            let expandedPath = path.expandingTildeInPath
            let url = URL(fileURLWithPath: expandedPath, isDirectory: true)
            return url
        }
        set {
            set(newValue, forKey: UserDefaultsKey.lastDirectoryOfSelectedProject)
        }
    }

    var lastDirectoryOfSelectedFileToCompare: URL? {
        get {
            guard let path = object(forKey: UserDefaultsKey.lastDirectoryOfSelectedFileToCompare) as? NSString else { return nil }
            let expandedPath = path.expandingTildeInPath
            let url = URL(fileURLWithPath: expandedPath, isDirectory: true)
            return url
        }
        set {
            set(newValue, forKey: UserDefaultsKey.lastDirectoryOfSelectedFileToCompare)
        }
    }
    
    var leftPaneWidth: CGFloat? {
        get {
            let possibleValue = double(forKey: UserDefaultsKey.leftPaneWidth)
            if possibleValue != 0 {
                return CGFloat(possibleValue)
            }
            return nil
        }
        set {
            set(newValue, forKey: UserDefaultsKey.leftPaneWidth)
        }
    }
    
    var mockPrefix: String {
        get {
            string(forKey: UserDefaultsKey.mockPrefix) ?? DefaultUserDefaultValue.mockPrefix
        }
        set {
            set(newValue, forKey: UserDefaultsKey.mockPrefix)
        }
    }
    
    var includeHeader: Bool {
        get {
            if object(forKey: UserDefaultsKey.includeHeader) == nil {
                return DefaultUserDefaultValue.includeHeader
            }
            return bool(forKey: UserDefaultsKey.includeHeader)
        }
        set {
            set(newValue, forKey: UserDefaultsKey.includeHeader)
        }
    }

    var stripTrailingProtocol: Bool {
        get {
            if object(forKey: UserDefaultsKey.stripTrailingProtocol) == nil {
                return DefaultUserDefaultValue.stripTrailingProtocol
            }
            return bool(forKey: UserDefaultsKey.stripTrailingProtocol)
        }
        set {
            set(newValue, forKey: UserDefaultsKey.stripTrailingProtocol)
        }
    }
    
    @available(*, deprecated, message: "swiftlint is no longer support in mock generation")
    var swiftlintAware: Bool {
        get {
            false
        }
        set { //swiftlint:disable:this unused_setter_value
        }
    }

    var includeTestableImport: Bool {
        get {
            if object(forKey: UserDefaultsKey.includeTestableImport) == nil {
                return DefaultUserDefaultValue.includeTestableImport
            }
            return bool(forKey: UserDefaultsKey.includeTestableImport)
        }
        set {
            set(newValue, forKey: UserDefaultsKey.includeTestableImport)
        }
    }

    var trackPropertyActivity: Bool {
        get {
            if object(forKey: UserDefaultsKey.trackPropertyActivity) == nil {
                return DefaultUserDefaultValue.trackPropertyActivity
            }
            return bool(forKey: UserDefaultsKey.trackPropertyActivity)
        }
        set {
            set(newValue, forKey: UserDefaultsKey.trackPropertyActivity)
        }
    }

    var `public`: Bool {
        get {
            if object(forKey: UserDefaultsKey.public) == nil {
                return DefaultUserDefaultValue.public
            }
            return bool(forKey: UserDefaultsKey.public)
        }
        set {
            set(newValue, forKey: UserDefaultsKey.public)
        }
    }

    var previousSelectedGroupPath: String? {
        get {
            string(forKey: UserDefaultsKey.previousSelectedGroupPath)
        }
        set {
            set(newValue, forKey: UserDefaultsKey.previousSelectedGroupPath)
        }
    }
    
    var addNewFileToProject: Bool {
        get {
            if object(forKey: UserDefaultsKey.addNewFileToProject) == nil {
                return DefaultUserDefaultValue.addNewFileToProject
            }
            return bool(forKey: UserDefaultsKey.addNewFileToProject)
        }
        set {
            set(newValue, forKey: UserDefaultsKey.addNewFileToProject)
        }
    }
    
    var sourceFileFilterValue: String? {
        get {
            string(forKey: UserDefaultsKey.sourceFileFilterValue)
        }
        set {
            set(newValue, forKey: UserDefaultsKey.sourceFileFilterValue)
        }
    }

    var recentDocuments: [URL] {
        get {
            guard let arrayOfStrings = object(forKey: UserDefaultsKey.recentDocuments) as? [String] else {
                return []
            }
            return arrayOfStrings.compactMap { URL(string: $0) }
        }
        set {
            let arrayOfStrings = newValue.map { $0.absoluteString }
            set(arrayOfStrings, forKey: UserDefaultsKey.recentDocuments)
        }
    }

    var maxRecentDocumentCount: Int {
        get {
            let possibleValue = integer(forKey: UserDefaultsKey.maxRecentDocumentCount)
            if possibleValue != 0 {
                return possibleValue
            }
            return DefaultUserDefaultValue.maxRecentDocumentCount
        }
        set {
            set(newValue, forKey: UserDefaultsKey.maxRecentDocumentCount)
        }
    }

}
