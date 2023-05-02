//
//  MockDestinationGroupSelectorInterface.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit

class MockDestinationGroupSelectorInterface: DestinationGroupSelectorInterfaceProtocol {

    var delegate: DestinationGroupSelectorInterfaceDelegate?    //swiftlint:disable:this weak_delegate

    struct Method: OptionSet {
        let rawValue: Int
        static let presentTreeRootTreeNodeForProjectCalled = Method(rawValue: 1)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let rootTreeNode = MethodParameter(rawValue: 1)
        static let project = MethodParameter(rawValue: 2)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var rootTreeNode: TreeNode?
    private(set) var project: Project?

    func reset() {
        calledMethods = []
        assignedParameters = []
        rootTreeNode = nil
        project = nil
    }

    func present(tree rootTreeNode: TreeNode, for project: Project) {
        calledMethods.insert(.presentTreeRootTreeNodeForProjectCalled)
        self.rootTreeNode = rootTreeNode
        assignedParameters.insert(.rootTreeNode)
        self.project = project
        assignedParameters.insert(.project)
    }

}

extension MockDestinationGroupSelectorInterface.Method: CustomStringConvertible {
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

        value += "]"
        return value
    }
}

extension MockDestinationGroupSelectorInterface.MethodParameter: CustomStringConvertible {
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

        value += "]"
        return value
    }
}
