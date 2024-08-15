//
//  RecentDocumentManagerTests.swift
//  MockerTests
//
//  Created by Greg Strobl on 2/3/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation
import Testing
@testable import Mocker

@MainActor
struct RecentDocumentManagerTests {

    var userDefaults: MockKeyValueStoring!
    var manager: RecentDocumentManager!

    let projectAUrlString = "file:///Users/xyz/Projects/A/A.xcodeproj/"
    let projectBUrlString = "file:///Users/xyz/Projects/B/B.xcodeproj/"
    let projectCUrlString = "file:///Users/xyz/Projects/C/C.xcodeproj/"
    let projectDUrlString = "file:///Users/xyz/Projects/D/D.xcodeproj/"
    let projectEUrlString = "file:///Users/xyz/Projects/E/E.xcodeproj/"
    var projectAUrl: URL!
    var projectBUrl: URL!
    var projectCUrl: URL!
    var projectDUrl: URL!
    var projectEUrl: URL!

    init() async throws {
        projectAUrl = try #require(URL(string: projectAUrlString))
        projectBUrl = try #require(URL(string: projectBUrlString))
        projectCUrl = try #require(URL(string: projectCUrlString))
        projectDUrl = try #require(URL(string: projectDUrlString))
        projectEUrl = try #require(URL(string: projectEUrlString))
        let urlSet: Set<URL> = [projectAUrl, projectBUrl, projectCUrl, projectDUrl, projectEUrl]
        #expect(urlSet.count == 5, "One or more of the URL values are equivalent")

        userDefaults = MockKeyValueStoring()
        userDefaults.objectForKeyDefaultNameReturnValue = [projectAUrlString, projectBUrlString, projectCUrlString, projectDUrlString, projectEUrlString]
        manager = RecentDocumentManager(userDefaults: userDefaults)
    }
    
    // MARK: - getter:recents
    
    @Test func fiveRecentsStored() {
        let expectedRecents = [projectAUrl, projectBUrl, projectCUrl, projectDUrl, projectEUrl]

        let recents = manager.recents

        #expect(recents == expectedRecents)
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName])
        #expect(userDefaults.defaultName == UserDefaultsKey.recentDocuments)
    }
    
    @Test func noRecentsStoredWhenStorageNil() {
        userDefaults.objectForKeyDefaultNameReturnValue = nil
        let expectedRecents = [URL]()

        let recents = manager.recents

        #expect(recents == expectedRecents)
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName])
        #expect(userDefaults.defaultName == UserDefaultsKey.recentDocuments)
    }

    // MARK: - add(_:)
    
    @Test func addUrlToEmptyStorage() throws {
        userDefaults.objectForKeyDefaultNameReturnValue = nil

        manager.add(projectAUrl)

        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultName == UserDefaultsKey.recentDocuments)
        let value = try #require(userDefaults.value as? [String])
        #expect(value == [projectAUrlString])
    }
    
    @Test func addTheSameUrlToStorageAlreadyContainingTheUrl() throws {
        userDefaults.objectForKeyDefaultNameReturnValue = [projectBUrlString]

        manager.add(projectBUrl)

        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultName == UserDefaultsKey.recentDocuments)
        let value = try #require(userDefaults.value as? [String])
        #expect(value == [projectBUrlString])
    }
    
    @Test func addUrlToStorageAlreadyContainingTwoOtherUrls() throws {
        userDefaults.objectForKeyDefaultNameReturnValue = [projectBUrlString, projectCUrlString]

        manager.add(projectAUrl)

        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultName == UserDefaultsKey.recentDocuments)
        let value = try #require(userDefaults.value as? [String])
        #expect(value == [projectAUrlString, projectBUrlString, projectCUrlString])
    }
    
    @Test func readdTheLastUrlToExistingStorage() throws {

        manager.add(projectEUrl)

        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultName == UserDefaultsKey.recentDocuments)
        let value = try #require(userDefaults.value as? [String])
        #expect(value == [projectEUrlString, projectAUrlString, projectBUrlString, projectCUrlString, projectDUrlString])
    }
    
    // MARK: - remove(_:)
    
    @Test func tryToRemoveUrlFromEmptyStorage() throws {
        userDefaults.objectForKeyDefaultNameReturnValue = nil
        
        manager.remove(projectAUrl)
        
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultName == UserDefaultsKey.recentDocuments)
        let value = try #require(userDefaults.value as? [String])
        #expect(value == [])
    }
    
    @Test func removeTheSameUrlFromStorageOnlyContainingThatUrl() throws {
        userDefaults.objectForKeyDefaultNameReturnValue = [projectBUrlString]
        
        manager.remove(projectBUrl)
        
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultName == UserDefaultsKey.recentDocuments)
        let value = try #require(userDefaults.value as? [String])
        #expect(value == [])
    }
    
    @Test func removeMiddleUrlFromExistingStorage() throws {
        
        manager.remove(projectCUrl)
        
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultName == UserDefaultsKey.recentDocuments)
        let value = try #require(userDefaults.value as? [String])
        #expect(value == [projectAUrlString, projectBUrlString, projectDUrlString, projectEUrlString])
    }
    
    // MARK: - clear()

    @Test func clear() throws {
        
        manager.clear()
        
        #expect(userDefaults.calledMethods == [.setValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultName == UserDefaultsKey.recentDocuments)
        let value = try #require(userDefaults.value as? [String])
        #expect(value == [])
    }
}
