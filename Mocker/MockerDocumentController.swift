//
//  MockerDocumentController.swift
//  Mocker
//
//  Created by Greg Strobl on 2/2/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import AppKit

class MockerDocumentController: NSDocumentController {
    
    var recentDocumentManager: (any RecentDocumentManaging)?
    var userDefaults: (any KeyValueStoring)?

    override var maximumRecentDocumentCount: Int {
        guard let userDefaults else { return 0 }
        return userDefaults.maxRecentDocumentCount
    }
    
    override func clearRecentDocuments(_ sender: Any?) {
        recentDocumentManager?.clear()
        super.clearRecentDocuments(sender)
    }
}
