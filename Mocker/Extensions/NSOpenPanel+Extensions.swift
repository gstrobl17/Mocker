//
//  NSOpenPanel+Extensions.swift
//  Mocker
//
//  Created by Greg on 2/22/18.
//

import AppKit

struct AppKitOpenPanelFactory: OpenPanelFactory {
    
    func create() -> OpenPanel {
        NSOpenPanel()
    }
    
}

extension NSOpenPanel: OpenPanel { }
