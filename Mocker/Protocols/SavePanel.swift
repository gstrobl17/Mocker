//
//  SavePanel.swift
//  Mocker
//
//  Created by Greg on 2/22/18.
//

import AppKit

protocol SavePanel {

    var url: URL? { get }
    
    var directoryURL: URL? { get set }
    
    var allowedFileTypes: [String]? { get set }
    var allowsOtherFileTypes: Bool { get set }
    var accessoryView: NSView? { get set }
    var delegate: NSOpenSavePanelDelegate? { get set }
    var isExpanded: Bool { get }
    var canCreateDirectories: Bool { get set }
    var canSelectHiddenExtension: Bool { get set }
    var isExtensionHidden: Bool { get set }
    var treatsFilePackagesAsDirectories: Bool { get set }
    var prompt: String! { get set }
    var title: String! { get set }
    var nameFieldLabel: String! { get set }
    
    var nameFieldStringValue: String { get set }
    
    var message: String! { get set }
    
    func validateVisibleColumns()
    
    var showsHiddenFiles: Bool { get set }
    
    var showsTagField: Bool { get set }
    
    var tagNames: [String]? { get set }
    
    func ok(_ sender: Any?)
    func cancel(_ sender: Any?)
    
    func beginSheetModal(for window: NSWindow, completionHandler handler: @escaping (NSApplication.ModalResponse) -> Swift.Void)
    
    func begin(completionHandler handler: @escaping (NSApplication.ModalResponse) -> Swift.Void)
    
    func runModal() -> NSApplication.ModalResponse
}

