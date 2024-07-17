//
//  MockProtocolSelectorView.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit
import SwiftSyntax

class MockProtocolSelectorView: NSViewController, ProtocolSelectorViewProtocol, ProtocolSelectorInterfaceProtocol {

    var presenter: ProtocolSelectorPresenterProtocol?
    var delegate: ProtocolSelectorInterfaceDelegate?    //swiftlint:disable:this weak_delegate

    struct Method: OptionSet {
        let rawValue: Int
        static let presentProtocolsCalled = Method(rawValue: 1)
    }
    private(set) var calledMethods = Method()
    
    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let protocols = MethodParameter(rawValue: 1)
    }
    private(set) var assignedParameters = MethodParameter()
    
    private(set) var protocols: [ProtocolDeclSyntax]?
    
    func reset() {
        calledMethods = []
        assignedParameters = []
        protocols = nil
    }
    
    func present(protocols: [ProtocolDeclSyntax]) {
        calledMethods.insert(.presentProtocolsCalled)
        self.protocols = protocols
        assignedParameters.insert(.protocols)
    }

}

extension MockProtocolSelectorView.Method: CustomStringConvertible {
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
        
        if self.contains(.presentProtocolsCalled) {
            handleFirst()
            value += ".presentProtocolsCalled"
        }
        
        value += "]"
        return value
    }
}

extension MockProtocolSelectorView.MethodParameter: CustomStringConvertible {
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
        
        if self.contains(.protocols) {
            handleFirst()
            value += ".protocols"
        }
        
        value += "]"
        return value
    }
}

extension MockProtocolSelectorView: CustomReflectable {
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
