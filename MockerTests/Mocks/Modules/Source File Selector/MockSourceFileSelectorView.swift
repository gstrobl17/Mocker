//
//  MockSourceFileSelectorView.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit
import XcodeEditor

class MockSourceFileSelectorView: NSViewController, SourceFileSelectorViewProtocol, SourceFileSelectorInterfaceProtocol {

    var presenter: SourceFileSelectorPresenterProtocol?
    var delegate: SourceFileSelectorInterfaceDelegate?  //swiftlint:disable:this weak_delegate

    struct Method: OptionSet, Sendable {
        let rawValue: Int
        static let presentTreeRootTreeNodeForDataSourceCalled = Method(rawValue: 1)
    }
    private(set) var calledMethods = Method()
    
    struct MethodParameter: OptionSet, Sendable {
        let rawValue: Int
        static let rootTreeNode = MethodParameter(rawValue: 1)
        static let dataSource = MethodParameter(rawValue: 2)
    }
    private(set) var assignedParameters = MethodParameter()
    
    private(set) var rootTreeNode: TreeNode?
    private(set) var dataSource: SourceFileDataSource?
    
    func reset() {
        calledMethods = []
        assignedParameters = []
        rootTreeNode = nil
        dataSource = nil
    }
    
    func present(tree rootTreeNode: TreeNode, for dataSource: SourceFileDataSource) {
        calledMethods.insert(.presentTreeRootTreeNodeForDataSourceCalled)
        self.rootTreeNode = rootTreeNode
        assignedParameters.insert(.rootTreeNode)
        self.dataSource = dataSource
        assignedParameters.insert(.dataSource)
    }

}

extension MockSourceFileSelectorView.Method: CustomStringConvertible {
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
        
        if self.contains(.presentTreeRootTreeNodeForDataSourceCalled) {
            handleFirst()
            value += ".presentTreeRootTreeNodeForDataSourceCalled"
        }
        
        value += "]"
        return value
    }
}

extension MockSourceFileSelectorView.MethodParameter: CustomStringConvertible {
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
        
        if self.contains(.rootTreeNode) {
            handleFirst()
            value += ".rootTreeNode"
        }
        if self.contains(.dataSource) {
            handleFirst()
            value += ".dataSource"
        }
        
        value += "]"
        return value
    }
}

extension MockSourceFileSelectorView: CustomReflectable {
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
