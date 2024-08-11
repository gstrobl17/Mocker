//
//  MockMockGenerator.swift
//  MockerTests
//
//  Created by Greg on 2/27/18.
//

import Foundation
@testable import Mocker

class MockMockGenerator: MockGenerating {
    
    struct Method: OptionSet, Sendable {
        let rawValue: Int
        static let generateMockCodeForParametersCalled = Method(rawValue: 1)
    }
    private(set) var calledMethods = Method()
    
    struct MethodParameter: OptionSet, Sendable {
        let rawValue: Int
        static let parameters = MethodParameter(rawValue: 1)
    }
    private(set) var assignedParameters = MethodParameter()
    
    private(set) var parameters: MockGeneratorParameters?
    
    var generateMockCodeForParametersReturnValue: String = ""
    
    func reset() {
        calledMethods = []
        assignedParameters = []
        parameters = nil
    }
    
    func generateMockCode(for parameters: MockGeneratorParameters) -> String {
        calledMethods.insert(.generateMockCodeForParametersCalled)
        self.parameters = parameters
        assignedParameters.insert(.parameters)
        return generateMockCodeForParametersReturnValue
    }
    
}

extension MockMockGenerator.Method: CustomStringConvertible {
    var description: String {
        var value = "["
        var first = true
        func handleFirst() {
            if first {
                first = false
            } else {
                value += ", "
            }
        }
        
        if self.contains(.generateMockCodeForParametersCalled) {
            handleFirst()
            value += ".generateMockCodeForParametersCalled"
        }
        
        value += "]"
        return value
    }
}

extension MockMockGenerator.MethodParameter: CustomStringConvertible {
    var description: String {
        var value = "["
        var first = true
        func handleFirst() {
            if first {
                first = false
            } else {
                value += ", "
            }
        }
        
        if self.contains(.parameters) {
            handleFirst()
            value += ".parameters"
        }
        
        value += "]"
        return value
    }
}

extension MockMockGenerator: CustomReflectable {
    var customMirror: Mirror {
        Mirror(self,
               children: [
                "calledMethods": calledMethods,
                "assignedParameters": assignedParameters
               ],
               displayStyle: .none
        )
    }
}
