//
//  MockDestinationGroupSelectorView.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit

class MockDestinationGroupSelectorView: NSViewController, DestinationGroupSelectorViewProtocol {

    var presenter: DestinationGroupSelectorPresenterProtocol?

    struct Method: OptionSet {
        let rawValue: Int
        static let presentTreeRootTreeNodeForProjectCalled = Method(rawValue: 1)
        static let selectTreeNodeCalled = Method(rawValue: 2)
        static let enableNewGroupButtonFlagCalled = Method(rawValue: 4)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let rootTreeNode = MethodParameter(rawValue: 1)
        static let project = MethodParameter(rawValue: 2)
        static let treeNode = MethodParameter(rawValue: 4)
        static let flag = MethodParameter(rawValue: 8)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var rootTreeNode: TreeNode?
    private(set) var project: Project?
    private(set) var treeNode: TreeNode?
    private(set) var flag: Bool?

    func reset() {
        calledMethods = []
        assignedParameters = []
        rootTreeNode = nil
        project = nil
        treeNode = nil
        flag = nil
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

    func enableNewGroupButton(_ flag: Bool) {
        calledMethods.insert(.enableNewGroupButtonFlagCalled)
        self.flag = flag
        assignedParameters.insert(.flag)
    }

}

extension MockDestinationGroupSelectorView.Method: CustomStringConvertible {
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
        if self.contains(.enableNewGroupButtonFlagCalled) {
            handleFirst()
            value += ".enableNewGroupButtonFlagCalled"
        }

        value += "]"
        return value
    }
}

extension MockDestinationGroupSelectorView.MethodParameter: CustomStringConvertible {
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
        if self.contains(.flag) {
            handleFirst()
            value += ".flag"
        }

        value += "]"
        return value
    }
}
