//swiftlint:disable identifier_name
//
//  MockFileManager.swift
//  Mocker
//
// Created by Greg on 10/12/18.
//

@testable import Mocker
import Foundation

class MockFileManager: FileManaging {

    // MARK: - Variables for Trackings Method Invocation

    struct Method: OptionSet, Sendable {
        let rawValue: UInt
        static let fileExistsAtPathPathCalled = Method(rawValue: 1 << 0)
        static let createDirectoryAtUrlWithIntermediateDirectoriesCreateIntermediatesAttributesCalled = Method(rawValue: 1 << 1)
        static let removeItemAtPathPathCalled = Method(rawValue: 1 << 2)
        static let contentsOfDirectoryAtUrlIncludingPropertiesForKeysKeysOptionsMaskCalled = Method(rawValue: 1 << 3)
    }
    private(set) var calledMethods = Method()

    struct MethodParameter: OptionSet, Sendable {
        let rawValue: UInt
        static let path = MethodParameter(rawValue: 1 << 0)
        static let url = MethodParameter(rawValue: 1 << 1)
        static let createIntermediates = MethodParameter(rawValue: 1 << 2)
        static let attributes = MethodParameter(rawValue: 1 << 3)
        static let keys = MethodParameter(rawValue: 1 << 4)
        static let mask = MethodParameter(rawValue: 1 << 5)
    }
    private(set) var assignedParameters = MethodParameter()

    // MARK: - Variables for Captured Parameter Values

    private(set) var path: String?
    private(set) var url: URL?
    private(set) var createIntermediates: Bool?
    private(set) var attributes: [FileAttributeKey: Any]?
    private(set) var keys: [URLResourceKey]?
    private(set) var mask: FileManager.DirectoryEnumerationOptions?

    // MARK: - Variables to Use as Method Return Values

    var fileExistsAtPathPathReturnValue = false
    var contentsOfDirectoryAtUrlIncludingPropertiesForKeysKeysOptionsMaskReturnValue = [URL]()

    var errorToThrow: Error!
    var createDirectoryAtUrlWithIntermediateDirectoriesCreateIntermediatesAttributesShouldThrowError = false
    var removeItemAtPathPathShouldThrowError = false
    var contentsOfDirectoryAtUrlIncludingPropertiesForKeysKeysOptionsMaskShouldThrowError = false

    func reset() {
        calledMethods = []
        assignedParameters = []
        path = nil
        url = nil
        createIntermediates = nil
        attributes = nil
        keys = nil
        mask = nil
    }

    // MARK: - Methods for Protocol Conformance

    func fileExists(atPath path: String) -> Bool {
        calledMethods.insert(.fileExistsAtPathPathCalled)
        self.path = path
        assignedParameters.insert(.path)
        return fileExistsAtPathPathReturnValue
    }

    func createDirectory(at url: URL, withIntermediateDirectories createIntermediates: Bool, attributes: [FileAttributeKey: Any]?) throws {
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

    func contentsOfDirectory(at url: URL, includingPropertiesForKeys keys: [URLResourceKey]?, options mask: FileManager.DirectoryEnumerationOptions) throws -> [URL] {
        calledMethods.insert(.contentsOfDirectoryAtUrlIncludingPropertiesForKeysKeysOptionsMaskCalled)
        self.url = url
        assignedParameters.insert(.url)
        self.keys = keys
        assignedParameters.insert(.keys)
        self.mask = mask
        assignedParameters.insert(.mask)
        if contentsOfDirectoryAtUrlIncludingPropertiesForKeysKeysOptionsMaskShouldThrowError && errorToThrow != nil {
            throw errorToThrow
        }
        return contentsOfDirectoryAtUrlIncludingPropertiesForKeysKeysOptionsMaskReturnValue
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
        if self.contains(.contentsOfDirectoryAtUrlIncludingPropertiesForKeysKeysOptionsMaskCalled) {
            handleFirst()
            value += ".contentsOfDirectoryAtUrlIncludingPropertiesForKeysKeysOptionsMaskCalled"
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
        if self.contains(.keys) {
            handleFirst()
            value += ".keys"
        }
        if self.contains(.mask) {
            handleFirst()
            value += ".mask"
        }

        value += "]"
        return value
    }
}

extension MockFileManager: CustomReflectable {
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
//swiftlint:enable identifier_name
