//
//  Pasteboard.swift
//  Mocker
//
//  Created by Greg Strobl on 5/11/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import AppKit

/// Protocol used to abstract functionality in NSPasteboard used in Mocker
protocol Pasteboard {
    @discardableResult
    func declareTypes(_ newTypes: [NSPasteboard.PasteboardType], owner newOwner: Any?) -> Int
    @discardableResult
    func setString(_ string: String, forType dataType: NSPasteboard.PasteboardType) -> Bool
}
