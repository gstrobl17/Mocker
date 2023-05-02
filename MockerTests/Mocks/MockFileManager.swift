//swiftlint:disable identifier_name syntactic_sugar
//
//  MockFileManager.swift
//  Mocker
//
// Created by Greg on 10/12/18.
//

@testable import Mocker
import Foundation

class MockFileManager: FileManaging {

    struct Method: OptionSet {
        let rawValue: Int
        static let fileExistsAtPathPathCalled = Method(rawValue: 1)
        static let createDirectoryAtUrlWithIntermediateDirectoriesCreateIntermediatesAttributesCalled = Method(rawValue: 2)
        static let removeItemAtPathPathCalled = Method(rawValue: 4)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet {
        let rawValue: Int
        static let path = MethodParameter(rawValue: 1)
        static let url = MethodParameter(rawValue: 2)
        static let createIntermediates = MethodParameter(rawValue: 4)
        static let attributes = MethodParameter(rawValue: 8)
    }
    private(set) var assignedParameters = MethodParameter()

    private(set) var path: String?
    private(set) var url: URL?
    private(set) var createIntermediates: Bool?
    private(set) var attributes: Dictionary<FileAttributeKey, Any>?

    var fileExistsAtPathPathReturnValue: Bool!

    var errorToThrow: Error!
    var createDirectoryAtUrlWithIntermediateDirectoriesCreateIntermediatesAttributesShouldThrowError = false
    var removeItemAtPathPathShouldThrowError = false

    func reset() {
        calledMethods = []
        assignedParameters = []
        path = nil
        url = nil
        createIntermediates = nil
        attributes = nil
    }

    func fileExists(atPath path: String) -> Bool {
        calledMethods.insert(.fileExistsAtPathPathCalled)
        self.path = path
        assignedParameters.insert(.path)
        return fileExistsAtPathPathReturnValue
    }

    func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: Dictionary<FileAttributeKey, Any>?) throws {
        calledMethods.insert(.createDirectoryAtUrlWithIntermediateDirectoriesCreateIntermediatesAttributesCalled)
        self.url = url
        assignedParameters.insert(.url)
        self.createIntermediates = createIntermediates
        assignedParameters.insert(.createIntermediates)
        self.attributes = attributes
        assignedParameters.insert(.attributes)
        if createDirectoryAtUrlWithIntermediateDirectoriesCreateIntermediatesAttributesShouldThrowError && errorToThrow != nil {
            throw errorToThrow
        }
    }

    func removeItem(atPath path: String) throws {
        calledMethods.insert(.removeItemAtPathPathCalled)
        self.path = path
        assignedParameters.insert(.path)
        if removeItemAtPathPathShouldThrowError && errorToThrow != nil {
            throw errorToThrow
        }
    }

}

extension MockFileManager.Method: CustomStringConvertible {
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

        if self.contains(.fileExistsAtPathPathCalled) {
            handleFirst()
            value += ".fileExistsAtPathPathCalled"
        }
        if self.contains(.createDirectoryAtUrlWithIntermediateDirectoriesCreateIntermediatesAttributesCalled) {
            handleFirst()
            value += ".createDirectoryAtUrlWithIntermediateDirectoriesCreateIntermediatesAttributesCalled"
        }
        if self.contains(.removeItemAtPathPathCalled) {
            handleFirst()
            value += ".removeItemAtPathPathCalled"
        }

        value += "]"
        return value
    }
}

extension MockFileManager.MethodParameter: CustomStringConvertible {
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

        if self.contains(.path) {
            handleFirst()
            value += ".path"
        }
        if self.contains(.url) {
            handleFirst()
            value += ".url"
        }
        if self.contains(.createIntermediates) {
            handleFirst()
            value += ".createIntermediates"
        }
        if self.contains(.attributes) {
            handleFirst()
            value += ".attributes"
        }

        value += "]"
        return value
    }
}
