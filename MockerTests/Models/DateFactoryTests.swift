//
//  DateFactoryTests.swift
//  MockerTests
//
//  Created by Greg Strobl on 9/29/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Testing
import Foundation
@testable import Mocker

struct DateFactoryTests {

    @Test func now() {
        let factory = DateFactory()
        let now = Date()
        let nowPlusSome = now.addingTimeInterval(100)
        
        let value = factory.now
        
        #expect(value >= now)
        #expect(value <= nowPlusSome)
    }

    @Test func dateForTimeIntervalSinceNow() {
        let factory = DateFactory()
        let timeInterval = TimeInterval(123456)
        let expectedDate = Date(timeIntervalSinceNow: timeInterval)
        
        let date = factory.date(timeIntervalSinceNow: timeInterval)
        
        #expect(date == expectedDate)
    }

}
