//
//  NeverCancelledMonitor.swift
//  Mocker
//
//  Created by Greg on 10/13/18.
//

import Foundation

struct NeverCancelledMonitor: CancelMonitoring {
    var isCancelled: Bool {
        false
    }
}
