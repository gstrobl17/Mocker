//
//  ASTMockGeneratorFactory.swift
//  Mocker
//
//  Created by Greg on 2/27/18.
//

import Foundation

struct ASTMockGeneratorFactory: MockGeneratorFactory {
    func createMockGenerator() -> MockGenerating {
        ASTMockGenerator()
    }
}
