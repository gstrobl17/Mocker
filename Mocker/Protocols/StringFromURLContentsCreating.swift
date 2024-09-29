//
//  StringFromURLContentsCreating.swift
//  Mocker
//
//  Created by Greg Strobl on 9/29/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

/// Protocol to abstract the ``String(contentsOf:encoding:) throws`` initializer for unit testing purposes.
///
/// Mocks will be able to control when the intializer throws and allow for testing when there are failures
protocol StringFromURLContentsCreating {
    func string(fromContentsOf url: URL, encoding: String.Encoding) throws -> String
}
