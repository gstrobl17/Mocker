//
//  OpenPanel.swift
//  Mocker
//
//  Created by Greg on 2/22/18.
//

import Foundation

@MainActor
protocol OpenPanel: SavePanel {

    var urls: [URL] { get }
    var resolvesAliases: Bool { get set }
    var canChooseDirectories: Bool { get set }
    var allowsMultipleSelection: Bool { get set }
    var canChooseFiles: Bool { get set }

    @available(OSX 10.10, *)
    var canResolveUbiquitousConflicts: Bool { get set }

    @available(OSX 10.10, *)
    var canDownloadUbiquitousContents: Bool { get set }

    @available(OSX 10.11, *)
    var isAccessoryViewDisclosed: Bool { get set }
    
}
