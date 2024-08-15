//
//  RecentDocumentManagerTests.swift
//  MockerTests
//
//  Created by Greg Strobl on 2/3/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import XCTest
@testable import Mocker

//TODO: resolve
//final class RecentDocumentManagerTests: XCTestCase {
//    
//    var userDefaults: MockKeyValueStoring!
//    var manager: RecentDocumentManager!
//    
//    let projectAUrlString = "file:///Users/xyz/Projects/A/A.xcodeproj/"
//    let projectBUrlString = "file:///Users/xyz/Projects/B/B.xcodeproj/"
//    let projectCUrlString = "file:///Users/xyz/Projects/C/C.xcodeproj/"
//    let projectDUrlString = "file:///Users/xyz/Projects/D/D.xcodeproj/"
//    let projectEUrlString = "file:///Users/xyz/Projects/E/E.xcodeproj/"
//    var projectAUrl: URL!
//    var projectBUrl: URL!
//    var projectCUrl: URL!
//    var projectDUrl: URL!
//    var projectEUrl: URL!
//
//    override func setUpWithError() throws {
//        try super.setUpWithError()
//
//        projectAUrl = try XCTUnwrap(URL(string: projectAUrlString))
//        projectBUrl = try XCTUnwrap(URL(string: projectBUrlString))
//        projectCUrl = try XCTUnwrap(URL(string: projectCUrlString))
//        projectDUrl = try XCTUnwrap(URL(string: projectDUrlString))
//        projectEUrl = try XCTUnwrap(URL(string: projectEUrlString))
//        let urlSet: Set<URL> = [projectAUrl, projectBUrl, projectCUrl, projectDUrl, projectEUrl]
//        XCTAssertEqual(urlSet.count, 5, "One or more of the URL values are equivalent")
//        
//        userDefaults = MockKeyValueStoring()
//        userDefaults.objectForKeyDefaultNameReturnValue = [projectAUrlString, projectBUrlString, projectCUrlString, projectDUrlString, projectEUrlString]
//        manager = RecentDocumentManager(userDefaults: userDefaults)
//    }
//
//    // MARK: - getter:recents
//    
//    func testRecents_fiveRecentsStored() {
//        let expectedRecents = [projectAUrl, projectBUrl, projectCUrl, projectDUrl, projectEUrl]
//        
//        let recents = manager.recents
//        
//        XCTAssertEqual(recents, expectedRecents)
//        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled])
//        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName])
//        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.recentDocuments)
//    }
//    
//    func testRecents_storageNil() {
//        userDefaults.objectForKeyDefaultNameReturnValue = nil
//        let expectedRecents = [URL]()
//        
//        let recents = manager.recents
//        
//        XCTAssertEqual(recents, expectedRecents)
//        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled])
//        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName])
//        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.recentDocuments)
//    }
//
//    // MARK: - add(_:)
//    
//    func testAdd_addUrlToEmptyStorage() {
//        userDefaults.objectForKeyDefaultNameReturnValue = nil
//        
//        manager.add(projectAUrl)
//        
//        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled])
//        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .value])
//        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.recentDocuments)
//        XCTAssertNotNil(userDefaults.value)
//        XCTAssertTrue(userDefaults.value is [String])
//        if let value = userDefaults.value as? [String] {
//            XCTAssertEqual(value, [projectAUrlString])
//        }
//    }
//    
//    func testAdd_addTheSameUrlToStorageAlreadyContainingTheUrl() {
//        userDefaults.objectForKeyDefaultNameReturnValue = [projectBUrlString]
//        
//        manager.add(projectBUrl)
//        
//        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled])
//        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .value])
//        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.recentDocuments)
//        XCTAssertNotNil(userDefaults.value)
//        XCTAssertTrue(userDefaults.value is [String])
//        if let value = userDefaults.value as? [String] {
//            XCTAssertEqual(value, [projectBUrlString])
//        }
//    }
//    
//    func testAdd_addUrlToStorageAlreadyContainingTwoOtherUrls() {
//        userDefaults.objectForKeyDefaultNameReturnValue = [projectBUrlString, projectCUrlString]
//        
//        manager.add(projectAUrl)
//        
//        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled])
//        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .value])
//        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.recentDocuments)
//        XCTAssertNotNil(userDefaults.value)
//        XCTAssertTrue(userDefaults.value is [String])
//        if let value = userDefaults.value as? [String] {
//            XCTAssertEqual(value, [projectAUrlString, projectBUrlString, projectCUrlString])
//        }
//    }
//    
//    func testAdd_readdTheLastUrlToExistingStorage() {
//        
//        manager.add(projectEUrl)
//        
//        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled])
//        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .value])
//        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.recentDocuments)
//        XCTAssertNotNil(userDefaults.value)
//        XCTAssertTrue(userDefaults.value is [String])
//        if let value = userDefaults.value as? [String] {
//            XCTAssertEqual(value, [projectEUrlString, projectAUrlString, projectBUrlString, projectCUrlString, projectDUrlString])
//        }
//    }
//
//    // MARK: - remove(_:)
//    
//    func testRemove_tryToRemoveUrlFromEmptyStorage() {
//        userDefaults.objectForKeyDefaultNameReturnValue = nil
//        
//        manager.remove(projectAUrl)
//        
//        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled])
//        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .value])
//        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.recentDocuments)
//        XCTAssertNotNil(userDefaults.value)
//        XCTAssertTrue(userDefaults.value is [String])
//        if let value = userDefaults.value as? [String] {
//            XCTAssertEqual(value, [])
//        }
//    }
//    
//    func testRemove_removeTheSameUrlFromStorageOnlyContainingThatUrl() {
//        userDefaults.objectForKeyDefaultNameReturnValue = [projectBUrlString]
//        
//        manager.remove(projectBUrl)
//        
//        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled])
//        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .value])
//        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.recentDocuments)
//        XCTAssertNotNil(userDefaults.value)
//        XCTAssertTrue(userDefaults.value is [String])
//        if let value = userDefaults.value as? [String] {
//            XCTAssertEqual(value, [])
//        }
//    }
//    
//    func testRemove_removeMiddleUrlFromExistingStorage() {
//        
//        manager.remove(projectCUrl)
//        
//        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled])
//        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .value])
//        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.recentDocuments)
//        XCTAssertNotNil(userDefaults.value)
//        XCTAssertTrue(userDefaults.value is [String])
//        if let value = userDefaults.value as? [String] {
//            XCTAssertEqual(value, [projectAUrlString, projectBUrlString, projectDUrlString, projectEUrlString])
//        }
//    }
//
//    // MARK: - clear()
//    
//    func testClear() {
//        
//        manager.clear()
//        
//        XCTAssertEqual(userDefaults.calledMethods, [.setValueForKeyDefaultNameCalled])
//        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .value])
//        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.recentDocuments)
//        XCTAssertNotNil(userDefaults.value)
//        XCTAssertTrue(userDefaults.value is [String])
//        if let value = userDefaults.value as? [String] {
//            XCTAssertEqual(value, [])
//        }
//    }
//}
