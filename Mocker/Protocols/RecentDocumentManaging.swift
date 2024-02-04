//
//  RecentDocumentManaging.swift
//  Mocker
//
//  Created by Greg Strobl on 2/2/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

protocol RecentDocumentManaging {
    var recents: [URL] { get }
    func add(_ url: URL)
    func remove(_ url: URL)
    func clear()
}
