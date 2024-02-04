//
//  DocumentControlling.swift
//  Mocker
//
//  Created by Greg Strobl on 2/2/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

/// Protocol used to abstract funtionality in NSDocumentController
protocol DocumentControlling {
    func noteNewRecentDocumentURL(_ url: URL)
}
