//
//  StringFromURLContentsFactory.swift
//  Mocker
//
//  Created by Greg Strobl on 9/29/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

struct StringFromURLContentsFactory: StringFromURLContentsCreating {
    
    func string(fromContentsOf url: URL, encoding: String.Encoding) throws -> String {
        try String(contentsOf: url, encoding: encoding)
    }
    
}
