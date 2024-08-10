//
//  NSOpenPanel+Extensions.swift
//  Mocker
//
//  Created by Greg on 2/22/18.
//

import AppKit

struct AppKitOpenPanelFactory: OpenPanelFactory {
    
    func create(delegate: any NSOpenSavePanelDelegate) -> any OpenPanel {
        let panel = NSOpenPanel()
        panel.delegate = delegate
        return panel
    }
    
}

extension NSOpenPanel: OpenPanel { }
