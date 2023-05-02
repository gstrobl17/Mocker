//
//  MockOpenPanelFactory.swift
//  MockerTests
//
//  Created by Greg on 2/22/18.
//

import Foundation
@testable import Mocker

struct MockOpenPanelFactory: OpenPanelFactory {
    let openPanel = MockOpenPanel()
    
    func create() -> OpenPanel {
        openPanel
    }
    
}
