//
//  MockSavePanel.swift
//  MockerTests
//
//  Created by Greg on 2/22/18.
//

import AppKit
@testable import Mocker

class MockSavePanel: SavePanel {
    
    private(set) var validateVisibleColumnsCalled = false
    private(set) var okCalled = false
    private(set) var cancelCalled = false
    private(set) var beginSheetModalForWindowCalled = false
    private(set) var beginCalled = false
    private(set) var runModalCalled = false

    private(set) var sender: Any?
    private(set) var window: NSWindow?
    private(set) var handler: ((NSApplication.ModalResponse) -> Void)?

    var urlToReturn: URL?
    var modalResponseToReturn: NSApplication.ModalResponse = NSApplication.ModalResponse(rawValue: 0)
    
    func reset() {
        validateVisibleColumnsCalled = false
        okCalled = false
        cancelCalled = false
        beginSheetModalForWindowCalled = false
        beginCalled = false
        runModalCalled = false
        sender = nil
        window = nil
        handler = nil
    }

    var url: URL? {
        urlToReturn
    }
    
    var directoryURL: URL?
    var allowedFileTypes: [String]?
    var allowsOtherFileTypes: Bool = false
    var accessoryView: NSView?
    weak var delegate: NSOpenSavePanelDelegate?
    var isExpanded: Bool = false
    var canCreateDirectories: Bool = false
    var canSelectHiddenExtension: Bool = false
    var isExtensionHidden: Bool = false
    var treatsFilePackagesAsDirectories: Bool = false
    var prompt: String!
    var title: String!
    var nameFieldLabel: String!
    var nameFieldStringValue: String = ""
    var message: String!
    
    func validateVisibleColumns() {
        validateVisibleColumnsCalled = true
    }
    
    var showsHiddenFiles: Bool = false
    var showsTagField: Bool = false
    var tagNames: [String]?
    
    func ok(_ sender: Any?) {
        okCalled = true
        self.sender = sender
    }
    
    func cancel(_ sender: Any?) {
        cancelCalled = true
        self.sender = sender
    }
    
    func beginSheetModal(for window: NSWindow, completionHandler handler: @escaping (NSApplication.ModalResponse) -> Void) {
        beginSheetModalForWindowCalled = true
        self.window = window
        self.handler = handler
    }
    
    func begin(completionHandler handler: @escaping (NSApplication.ModalResponse) -> Void) {
        beginCalled = true
        self.handler = handler
    }
    
    func runModal() -> NSApplication.ModalResponse {
        runModalCalled = true
        return modalResponseToReturn
    }
    
}
