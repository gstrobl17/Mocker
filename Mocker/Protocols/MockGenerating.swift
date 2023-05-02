//
//  MockGenerating.swift
//  Mocker
//
//  Created by Greg on 2/27/18.
//

import Foundation

protocol MockGenerating {
    func generateMockCode(for parameters: MockGeneratorParameters) -> String
}
