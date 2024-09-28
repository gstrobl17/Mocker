//
//  TemporaryFileHandler.swift
//  Mocker
//
//  Created by Greg Strobl on 9/28/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

struct TemporaryFileHandler: TemporaryFileHandling {
    
    func saveToTemporaryFile(_ string: String) throws -> URL {
        let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let temporaryFileURL = temporaryDirectoryURL.appendingPathComponent(UUID().uuidString)
        try string.write(to: temporaryFileURL, atomically: true, encoding: .utf8)
        return temporaryFileURL
    }
    
}
