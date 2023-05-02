//
//  MockOpenPanel.swift
//  MockerTests
//
//  Created by Greg on 2/22/18.
//

import AppKit
@testable import Mocker

class MockOpenPanel: MockSavePanel, OpenPanel {
    
    var urlsToReturn: [URL] = []
    
    var urls: [URL] {
        urlsToReturn
    }
    
    var resolvesAliases: Bool = false
    var canChooseDirectories: Bool = false
    var allowsMultipleSelection: Bool = false
    var canChooseFiles: Bool = false
    var canResolveUbiquitousConflicts: Bool = false
    var canDownloadUbiquitousContents: Bool = false
    var isAccessoryViewDisclosed: Bool = false
    
}
