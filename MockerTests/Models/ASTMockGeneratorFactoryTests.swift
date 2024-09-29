//
//  ASTMockGeneratorFactoryTests.swift
//  MockerTests
//
//  Created by Greg Strobl on 9/29/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Testing
import Foundation
@testable import Mocker

struct ASTMockGeneratorFactoryTests {

    @Test func createMockGenerator() {
        let factory = ASTMockGeneratorFactory()
        
        let generator = factory.createMockGenerator()
        
        #expect(generator is ASTMockGenerator)
    }

}
