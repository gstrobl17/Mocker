//
//  FullNameProvider.swift
//  Mocker
//
//  Created by Greg Strobl on 1/24/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

struct FullNameProvider: FullNameProviding {
    var name: String {
        NSFullUserName()
    }
}
