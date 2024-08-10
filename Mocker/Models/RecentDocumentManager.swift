//
//  RecentDocumentManager.swift
//  Mocker
//
//  Created by Greg Strobl on 2/2/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

class RecentDocumentManager: RecentDocumentManaging {
    
    private(set) var userDefaults: any KeyValueStoring
    
    init(userDefaults: any KeyValueStoring) {
        self.userDefaults = userDefaults
    }

    var recents: [URL] {
        // NOTE: I tried to used FileManager to test if the values still exist and prune the list of the ones
        //       that no don't exist. However, "file path does exist" always returned false. This appears to be
        //       because this app isn't properly set up with sandox entitlements. Since this app isn't properly
        //       build for a formal distribution, this app, according to FileManager, can't access anything
        //       at start up.
        userDefaults.recentDocuments
    }
    
    func add(_ url: URL) {
        var list = userDefaults.recentDocuments.filter { $0 != url }
        list.insert(url, at: 0)
        userDefaults.recentDocuments = list
    }
    
    func remove(_ url: URL) {
        let list = userDefaults.recentDocuments.filter { $0 != url }
        userDefaults.recentDocuments = list
    }
    
    func clear() {
        userDefaults.recentDocuments = []
    }
    
}
