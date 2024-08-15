//
//  OpenPanelFactory.swift
//  Mocker
//
//  Created by Greg on 2/22/18.
//

import AppKit

@MainActor
protocol OpenPanelFactory {
    
    func create(delegate: any NSOpenSavePanelDelegate) -> any OpenPanel
    
}
