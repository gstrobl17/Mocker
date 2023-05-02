//
//  MockDestinationGroupSelectorInteractorOutput.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit

//swiftlint:disable:next type_name
class MockDestinationGroupSelectorInteractorOutput: DestinationGroupSelectorInteractorOutputProtocol {

    struct Method: OptionSet {
        let rawValue: Int
        static let presentTreeRootTreeNodeForProjectCalled = Method(rawValue: 1)
        static let selectTreeNodeCalled = Method(rawValue: 2)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let rootTreeNode = MethodParameter(rawValue: 1)
        static let project = MethodParameter(rawValue: 2)
        static let treeNode = MethodParameter(rawValue: 4)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var rootTreeNode: TreeNode?
    private(set) var project: Project?
    private(set) var treeNode: TreeNode?

    func reset() {
        calledMethods = []
        assignedParameters = []
        rootTreeNode = nil
        project = nil
        treeNode = nil
    }

    func present(tree rootTreeNode: TreeNode, for project: Project) {
        calledMethods.insert(.presentTreeRootTreeNodeForProjectCalled)
        self.rootTreeNode = rootTreeNode
        assignedParameters.insert(.rootTreeNode)
        self.project = project
        assignedParameters.insert(.project)
    }

    func select(treeNode: TreeNode) {
        calledMethods.insert(.selectTreeNodeCalled)
        self.treeNode = treeNode
        assignedParameters.insert(.treeNode)
    }

}

extension MockDestinationGroupSelectorInteractorOutput.Method: CustomStringConvertible {
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

        if self.contains(.presentTreeRootTreeNodeForProjectCalled) {
            handleFirst()
            value += ".presentTreeRootTreeNodeForProjectCalled"
        }
        if self.contains(.selectTreeNodeCalled) {
            handleFirst()
            value += ".selectTreeNodeCalled"
        }

        value += "]"
        return value
    }
}

extension MockDestinationGroupSelectorInteractorOutput.MethodParameter: CustomStringConvertible {
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
        if self.contains(.project) {
            handleFirst()
            value += ".project"
        }
        if self.contains(.treeNode) {
            handleFirst()
            value += ".treeNode"
        }

        value += "]"
        return value
    }
}
