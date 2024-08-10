//
//  MockerDocumentController.swift
//  Mocker
//
//  Created by Greg Strobl on 2/2/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import AppKit

class MockerDocumentController: NSDocumentController {
    
    let recentDocumentManager: any RecentDocumentManaging
    let userDefaults: any KeyValueStoring

    init(
        recentDocumentManager: any RecentDocumentManaging,
        userDefaults: any KeyValueStoring
    ) {
        self.recentDocumentManager = recentDocumentManager
        self.userDefaults = userDefaults
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var maximumRecentDocumentCount: Int {
        userDefaults.maxRecentDocumentCount
    }
    
    override func clearRecentDocuments(_ sender: Any?) {
        recentDocumentManager.clear()
        super.clearRecentDocuments(sender)
    }
}
