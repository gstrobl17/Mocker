//
//  MockDestinationGroupSelectorPresenter.swift
//  Mocker
//
// Created by Greg on 10/13/18.
//

@testable import Mocker
import AppKit

class MockDestinationGroupSelectorPresenter: DestinationGroupSelectorPresenterProtocol {

    var interactor: DestinationGroupSelectorInteractorInputProtocol?

    struct Method: OptionSet {
        let rawValue: Int
        static let nodeSelectedTreeNodeCalled = Method(rawValue: 1)
        static let viewHasLoadedCalled = Method(rawValue: 2)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let treeNode = MethodParameter(rawValue: 1)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var treeNode: TreeNode?

    func reset() {
        calledMethods = []
        assignedParameters = []
        treeNode = nil
    }

    func nodeSelected(_ treeNode: TreeNode) {
        calledMethods.insert(.nodeSelectedTreeNodeCalled)
        self.treeNode = treeNode
        assignedParameters.insert(.treeNode)
    }

    func viewHasLoaded() {
        calledMethods.insert(.viewHasLoadedCalled)
    }

}

extension MockDestinationGroupSelectorPresenter.Method: CustomStringConvertible {
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

        if self.contains(.nodeSelectedTreeNodeCalled) {
            handleFirst()
            value += ".nodeSelectedTreeNodeCalled"
        }
        if self.contains(.viewHasLoadedCalled) {
            handleFirst()
            value += ".viewHasLoadedCalled"
        }

        value += "]"
        return value
    }
}

extension MockDestinationGroupSelectorPresenter.MethodParameter: CustomStringConvertible {
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

        if self.contains(.treeNode) {
            handleFirst()
            value += ".treeNode"
        }

        value += "]"
        return value
    }
}
