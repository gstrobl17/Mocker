//
//  XCTarget+Extensions.swift
//  Mocker
//
//  Created by Greg on 3/8/18.
//

import Foundation
import XcodeEditor

extension XCTarget {
    
    var nameForCode: String? {
        var nameForCode: String?
        if let name = name {
            nameForCode = name.replacingOccurrences(of: " ", with: "_")
        }
        return nameForCode
    }
    
}
