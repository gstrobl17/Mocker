//
//  MockMockGeneratorFactory.swift
//  MockerTests
//
//  Created by Greg on 2/27/18.
//

import Foundation
@testable import Mocker

class MockMockGeneratorFactory: MockGeneratorFactory {
    let mockGenerator = MockMockGenerator()
    
    func createMockGenerator() -> MockGenerating {
        mockGenerator
    }

}
