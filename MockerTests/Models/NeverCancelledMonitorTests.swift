//
//  NeverCancelledMonitorTests.swift
//  MockerTests
//
//  Created by Greg Strobl on 9/29/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Testing
import Foundation
@testable import Mocker

struct NeverCancelledMonitorTests {

    @Test func isCancelled() {
        let monitor = NeverCancelledMonitor()
        
        #expect(monitor.isCancelled == false)
    }

}
