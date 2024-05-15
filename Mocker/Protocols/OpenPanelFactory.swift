//
//  OpenPanelFactory.swift
//  Mocker
//
//  Created by Greg on 2/22/18.
//

import AppKit

protocol OpenPanelFactory {
    
    func create(delegate: NSOpenSavePanelDelegate) -> OpenPanel
    
}
