//
//  TemporaryFileHandling.swift
//  Mocker
//
//  Created by Greg Strobl on 9/27/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

protocol TemporaryFileHandling {
    func saveToTemporaryFile(_ string: String) throws -> URL
}
