//
//  NSOpenPanel+Extensions.swift
//  Mocker
//
//  Created by Greg on 2/22/18.
//

import AppKit

struct AppKitOpenPanelFactory: OpenPanelFactory {
    
    func create(delegate: NSOpenSavePanelDelegate) -> OpenPanel {
        let panel = NSOpenPanel()
        panel.delegate = delegate
        return panel
    }
    
}

extension NSOpenPanel: OpenPanel { }
