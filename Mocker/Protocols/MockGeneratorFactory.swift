//
//  MockGeneratorFactory.swift
//  Mocker
//
//  Created by Greg on 2/27/18.
//

import Foundation

protocol MockGeneratorFactory {
    func createMockGenerator(swiftlintAware: Bool) -> any MockGenerating
}
