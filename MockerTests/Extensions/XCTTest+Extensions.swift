//
//  XCTTest+Extensions.swift
//  MockerTests
//
//  Created by Greg Strobl on 1/25/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import XCTest

extension XCTest {
    
    func printFirstDifference(_ s1: String, _ s2: String) {
        let result = firstDifferenceBetweenStrings(s1: s1, s2: s2)
        if case .DifferenceAtIndex = result {
            let details = prettyDescriptionOfFirstDifferenceResult(firstDifferenceResult: result, s1: s1, s2: s2)
            print(details)
        }
    }
    
}
