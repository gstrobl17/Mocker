//
//  AppKitOpenPanelFactoryTests.swift
//  MockerTests
//
//  Created by Greg Strobl on 9/29/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Testing
import AppKit
@testable import Mocker

@MainActor
class AppKitOpenPanelFactoryTests: NSObject, NSOpenSavePanelDelegate {

    @Test func create() throws {
        let factory = AppKitOpenPanelFactory()
        
        let panel = factory.create(delegate: self)
        
        #expect(panel is NSOpenPanel)
        let openPanel = try #require(panel as? NSOpenPanel)
        #expect(openPanel.delegate === self)
    }

}
