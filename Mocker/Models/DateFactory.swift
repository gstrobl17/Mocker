//
//  DateFactory.swift
//  Mocker
//
//  Created by Greg Strobl on 1/24/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

struct DateFactory {
}

extension DateFactory: DateCreating {
    
    var now: Date {
        Date()
    }
    
    func date(timeIntervalSinceNow interval: TimeInterval) -> Date {
        Date(timeIntervalSinceNow: interval)
    }
    
}
