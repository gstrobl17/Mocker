//
//  FullNameProviding.swift
//  Mocker
//
//  Created by Greg Strobl on 1/24/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

/// Protocol used to abstract the `NSFullUserName()` method
protocol FullNameProviding {
    var name: String { get }
}
