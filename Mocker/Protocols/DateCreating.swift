//
//  DateCreating.swift
//  Mocker
//
//  Created by Greg Strobl on 1/24/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

protocol DateCreating {
    
    var now: Date { get }
    func date(timeIntervalSinceNow: TimeInterval) -> Date
    
}
