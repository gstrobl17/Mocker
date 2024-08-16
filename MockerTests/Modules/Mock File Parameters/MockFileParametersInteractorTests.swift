//swiftlint:disable file_length
//
//  MockFileParametersInteractorTests.swift
//  MockerTests
//
//  Created by Greg on 2/26/18.
//

import Testing
@testable import Mocker
import MacrosForStroblMocks

@MainActor @UsesStroblMocks
//swiftlint:disable:next type_body_length
struct MockFileParametersInteractorTests {
    
    @StroblMock var presenter: MockMockFileParametersInteractorOutput!
    @StroblMock var userDefaults: MockUserDefaults!
    var interactor: MockFileParametersInteractor!
    
    init() async {
        userDefaults = MockUserDefaults()
        presenter = MockMockFileParametersInteractorOutput()
        
        interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        userDefaults.reset()
        presenter.reset()
    }
    
    // MARK: - init -
    
    @Test func testInit() {
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        #expect(presenter.calledMethods == [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolIncludeTestableImportTrackPropertyActivityPublicCalled])
        #expect(presenter.assignedParameters == [.prefix, .includeHeader, .stripTrailingProtocol, .includeTestableImport, .trackPropertyActivity, .public, .name])
        #expect(presenter.prefix == DefaultUserDefaultValue.mockPrefix)
        #expect(presenter.includeHeader == DefaultUserDefaultValue.includeHeader)
        #expect(presenter.stripTrailingProtocol == DefaultUserDefaultValue.stripTrailingProtocol)
        #expect(presenter.includeTestableImport == DefaultUserDefaultValue.includeTestableImport)
        #expect(presenter.trackPropertyActivity == DefaultUserDefaultValue.trackPropertyActivity)
        #expect(presenter.public == DefaultUserDefaultValue.public)
        #expect(presenter.name == "")
    }
    
    @Test mutating func initWithAlternativePrefixValue() throws {
        let alternativePrefix = "Prefix"
        userDefaults.mockPrefix = alternativePrefix
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.mockPrefix, UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        #expect(userDefaults.values.count == 1)
        let values = try #require(userDefaults.values as? [String])
        #expect(values == [alternativePrefix])
        #expect(presenter.calledMethods == [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolIncludeTestableImportTrackPropertyActivityPublicCalled])
        #expect(presenter.assignedParameters == [.prefix, .includeHeader, .stripTrailingProtocol, .includeTestableImport, .trackPropertyActivity, .public, .name])
        #expect(presenter.prefix == alternativePrefix)
        #expect(presenter.includeHeader == DefaultUserDefaultValue.includeHeader)
        #expect(presenter.stripTrailingProtocol == DefaultUserDefaultValue.stripTrailingProtocol)
        #expect(presenter.includeTestableImport == DefaultUserDefaultValue.includeTestableImport)
        #expect(presenter.trackPropertyActivity == DefaultUserDefaultValue.trackPropertyActivity)
        #expect(presenter.public == DefaultUserDefaultValue.public)
        #expect(presenter.name == "")
    }
    
    @Test mutating func initWithAlternativeIncludeHeaderValue() throws {
        let alternativeIncludeHeader = !DefaultUserDefaultValue.includeHeader
        userDefaults.includeHeader = alternativeIncludeHeader
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled, .boolForKeyDefaultNameCalled, .setBoolValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .boolValue])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.includeHeader, UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        #expect(userDefaults.values.count == 1)
        #expect(userDefaults.values is [Bool])
        let values = try #require(userDefaults.values as? [Bool])
        #expect(values == [alternativeIncludeHeader])
        #expect(presenter.calledMethods == [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolIncludeTestableImportTrackPropertyActivityPublicCalled])
        #expect(presenter.assignedParameters == [.prefix, .includeHeader, .stripTrailingProtocol, .includeTestableImport, .trackPropertyActivity, .public, .name])
        #expect(presenter.prefix == DefaultUserDefaultValue.mockPrefix)
        #expect(presenter.includeHeader == alternativeIncludeHeader)
        #expect(presenter.stripTrailingProtocol == DefaultUserDefaultValue.stripTrailingProtocol)
        #expect(presenter.includeTestableImport == DefaultUserDefaultValue.includeTestableImport)
        #expect(presenter.trackPropertyActivity == DefaultUserDefaultValue.trackPropertyActivity)
        #expect(presenter.public == DefaultUserDefaultValue.public)
        #expect(presenter.name == "")
    }
    
    @Test mutating func initWithAlternativeStripTrailingProtocolValue() throws {
        let alternativeStripTrailingProtocol = !DefaultUserDefaultValue.stripTrailingProtocol
        userDefaults.stripTrailingProtocol = alternativeStripTrailingProtocol
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled, .boolForKeyDefaultNameCalled, .setBoolValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .boolValue])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        #expect(userDefaults.values.count == 1)
        let values = try #require(userDefaults.values as? [Bool])
        #expect(values == [alternativeStripTrailingProtocol])
        #expect(presenter.calledMethods == [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolIncludeTestableImportTrackPropertyActivityPublicCalled])
        #expect(presenter.assignedParameters == [.prefix, .includeHeader, .stripTrailingProtocol, .includeTestableImport, .trackPropertyActivity, .public, .name])
        #expect(presenter.prefix == DefaultUserDefaultValue.mockPrefix)
        #expect(presenter.includeHeader == DefaultUserDefaultValue.includeHeader)
        #expect(presenter.stripTrailingProtocol == alternativeStripTrailingProtocol)
        #expect(presenter.includeTestableImport == DefaultUserDefaultValue.includeTestableImport)
        #expect(presenter.trackPropertyActivity == DefaultUserDefaultValue.trackPropertyActivity)
        #expect(presenter.public == DefaultUserDefaultValue.public)
        #expect(presenter.name == "")
    }
    
    @Test mutating func initWithAlternativeIncludeTestableImportValue() throws {
        let alternativeIncludeTestableImport = !DefaultUserDefaultValue.includeTestableImport
        userDefaults.includeTestableImport = alternativeIncludeTestableImport
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled, .boolForKeyDefaultNameCalled, .setBoolValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .boolValue])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.includeTestableImport, UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.includeTestableImport, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        #expect(userDefaults.values.count == 1)
        #expect(userDefaults.values is [Bool])
        let values = try #require(userDefaults.values as? [Bool])
        #expect(values == [alternativeIncludeTestableImport])
        #expect(presenter.calledMethods == [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolIncludeTestableImportTrackPropertyActivityPublicCalled])
        #expect(presenter.assignedParameters == [.prefix, .includeHeader, .stripTrailingProtocol, .includeTestableImport, .trackPropertyActivity, .public, .name])
        #expect(presenter.prefix == DefaultUserDefaultValue.mockPrefix)
        #expect(presenter.includeHeader == DefaultUserDefaultValue.includeHeader)
        #expect(presenter.stripTrailingProtocol == DefaultUserDefaultValue.stripTrailingProtocol)
        #expect(presenter.includeTestableImport == alternativeIncludeTestableImport)
        #expect(presenter.trackPropertyActivity == DefaultUserDefaultValue.trackPropertyActivity)
        #expect(presenter.public == DefaultUserDefaultValue.public)
        #expect(presenter.name == "")
    }
    
    @Test mutating func initWithAlternativeTrackPropertyActivityValue() throws {
        let alternativeTrackPropertyActivity = !DefaultUserDefaultValue.trackPropertyActivity
        userDefaults.trackPropertyActivity = alternativeTrackPropertyActivity
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled, .boolForKeyDefaultNameCalled, .setBoolValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .boolValue])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        #expect(userDefaults.values.count == 1)
        #expect(userDefaults.values is [Bool])
        let values = try #require(userDefaults.values as? [Bool])
        #expect(values == [alternativeTrackPropertyActivity])
        #expect(presenter.calledMethods == [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolIncludeTestableImportTrackPropertyActivityPublicCalled])
        #expect(presenter.assignedParameters == [.prefix, .includeHeader, .stripTrailingProtocol, .includeTestableImport, .trackPropertyActivity, .public, .name])
        #expect(presenter.prefix == DefaultUserDefaultValue.mockPrefix)
        #expect(presenter.includeHeader == DefaultUserDefaultValue.includeHeader)
        #expect(presenter.stripTrailingProtocol == DefaultUserDefaultValue.stripTrailingProtocol)
        #expect(presenter.includeTestableImport == DefaultUserDefaultValue.includeTestableImport)
        #expect(presenter.trackPropertyActivity == alternativeTrackPropertyActivity)
        #expect(presenter.public == DefaultUserDefaultValue.public)
        #expect(presenter.name == "")
    }
    
    @Test mutating func initWithAlternativePublicValue() throws {
        let alternativePublic = !DefaultUserDefaultValue.public
        userDefaults.public = alternativePublic
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled, .boolForKeyDefaultNameCalled, .setBoolValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .boolValue])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.public, UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public, UserDefaultsKey.public])
        #expect(userDefaults.values.count == 1)
        #expect(userDefaults.values is [Bool])
        let values = try #require(userDefaults.values as? [Bool])
        #expect(values == [alternativePublic])
        #expect(presenter.calledMethods == [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolIncludeTestableImportTrackPropertyActivityPublicCalled])
        #expect(presenter.assignedParameters == [.prefix, .includeHeader, .stripTrailingProtocol, .includeTestableImport, .trackPropertyActivity, .public, .name])
        #expect(presenter.prefix == DefaultUserDefaultValue.mockPrefix)
        #expect(presenter.includeHeader == DefaultUserDefaultValue.includeHeader)
        #expect(presenter.stripTrailingProtocol == DefaultUserDefaultValue.stripTrailingProtocol)
        #expect(presenter.includeTestableImport == DefaultUserDefaultValue.includeTestableImport)
        #expect(presenter.trackPropertyActivity == DefaultUserDefaultValue.trackPropertyActivity)
        #expect(presenter.public == alternativePublic)
        #expect(presenter.name == "")
    }

    // MARK: - mockFileName
    
    @Test func mockFileName_defaultValuesNoProtocolName() {
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        
        let value = interactor.mockFileName
        
        verifyStroblMocksUnused()
        #expect(value == "")
    }
    
    @Test func mockFileName_defaultValuesWithProtocolName() {
        let protocolName = "MySpecialProtocol"
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.setProtocolName(protocolName)
        
        let value = interactor.mockFileName
        
        #expect(value == "MockMySpecial")
        verifyStroblMocksUnused(except: [.userDefaults])
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.mockPrefix, UserDefaultsKey.stripTrailingProtocol])
    }
    
    @Test func mockFileName_stripTrailingProtocolFalse() {
        let protocolName = "MySpecialProtocol"
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.setProtocolName(protocolName)
        interactor.stripTrailingProtocolFlagUpdated(to: false)
        
        let value = interactor.mockFileName
        
        #expect(value == "MockMySpecialProtocol")
        verifyStroblMocksUnused(except: [.userDefaults])
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled, .boolForKeyDefaultNameCalled, .setBoolValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .boolValue])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.mockPrefix, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.stripTrailingProtocol])
    }
    
    @Test func mockFileName_prefixSetToFake() {
        let protocolName = "MySpecialProtocol"
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.setProtocolName(protocolName)
        interactor.prefixUpdated(to: "Fake")
        
        let value = interactor.mockFileName
        
        #expect(value == "FakeMySpecial")
        verifyStroblMocksUnused(except: [.userDefaults])
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.mockPrefix, UserDefaultsKey.mockPrefix, UserDefaultsKey.stripTrailingProtocol])
    }
    
    @Test func mockFileName_extraWhiteSpaceAddedToProtocolNameAndPrefix() {
        let protocolName = "   MySpecialProtocol   "
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.setProtocolName(protocolName)
        interactor.prefixUpdated(to: "   Fake    ")
        
        let value = interactor.mockFileName
        
        #expect(value == "FakeMySpecial")
        verifyStroblMocksUnused(except: [.userDefaults])
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.mockPrefix, UserDefaultsKey.mockPrefix, UserDefaultsKey.stripTrailingProtocol])
    }
    
    // MARK: - MockFileParametersInteractorInputProtocol methods
    
    @Test func setProtocolName() {
        
        interactor.setProtocolName("MyProtocol")
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.mockPrefix, UserDefaultsKey.stripTrailingProtocol])
        #expect(presenter.calledMethods == [.setNameNameCalled])
        #expect(presenter.assignedParameters == [.name])
        #expect(presenter.name == "MockMy")
    }
    
    @Test func prefixUpdated() {
        
        interactor.prefixUpdated(to: "Prefix")
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        #expect(userDefaults.calledMethods == [.setValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .value])
        #expect(userDefaults.mockPrefix == "Prefix")
        #expect(presenter.calledMethods == [.setNameNameCalled])
        #expect(presenter.assignedParameters == [.name])
        #expect(presenter.name == "")
    }
    
    @Test func includeHeaderFlagUpdated_false() {
        
        interactor.includeHeaderFlagUpdated(to: false)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        #expect(userDefaults.calledMethods == [.setBoolValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .boolValue])
        #expect(userDefaults.defaultName == UserDefaultsKey.includeHeader)
        #expect(userDefaults.boolValue == false)
    }
    
    @Test func includeHeaderFlagUpdated_true() {
        
        interactor.includeHeaderFlagUpdated(to: true)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        #expect(userDefaults.calledMethods == [.setBoolValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .boolValue])
        #expect(userDefaults.defaultName == UserDefaultsKey.includeHeader)
        #expect(userDefaults.boolValue == true)
    }
    
    @Test func stripTrailingProtocolFlagUpdated_false() {
        
        interactor.stripTrailingProtocolFlagUpdated(to: false)
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        #expect(userDefaults.calledMethods == [.setBoolValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .boolValue])
        #expect(userDefaults.defaultName == UserDefaultsKey.stripTrailingProtocol)
        #expect(userDefaults.boolValue == false)
        #expect(userDefaults.stripTrailingProtocol == false)
        #expect(presenter.calledMethods == [.setNameNameCalled])
        #expect(presenter.assignedParameters == [.name])
        #expect(presenter.name == "")
    }
    
    @Test func stripTrailingProtocolFlagUpdated_true() {
        
        interactor.stripTrailingProtocolFlagUpdated(to: true)
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        #expect(userDefaults.calledMethods == [.setBoolValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .boolValue])
        #expect(userDefaults.defaultName == UserDefaultsKey.stripTrailingProtocol)
        #expect(userDefaults.boolValue == true)
        #expect(userDefaults.stripTrailingProtocol == true)
        #expect(presenter.calledMethods == [.setNameNameCalled])
        #expect(presenter.assignedParameters == [.name])
        #expect(presenter.name == "")
    }
    
    @Test func includeTestableImportFlagUpdated_false() {
        
        interactor.includeTestableImportFlagUpdated(to: false)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        #expect(userDefaults.calledMethods == [.setBoolValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .boolValue])
        #expect(userDefaults.defaultName == UserDefaultsKey.includeTestableImport)
        #expect(userDefaults.boolValue == false)
    }
    
    @Test func includeTestableImportFlagUpdated_true() {
        
        interactor.includeTestableImportFlagUpdated(to: true)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        #expect(userDefaults.calledMethods == [.setBoolValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .boolValue])
        #expect(userDefaults.defaultName == UserDefaultsKey.includeTestableImport)
        #expect(userDefaults.boolValue == true)
    }
    
    @Test func trackPropertyActivityFlagUpdated_false() {
        
        interactor.trackPropertyActivityFlagUpdated(to: false)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        #expect(userDefaults.calledMethods == [.setBoolValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .boolValue])
        #expect(userDefaults.defaultName == UserDefaultsKey.trackPropertyActivity)
        #expect(userDefaults.boolValue == false)
    }
    
    @Test func trackPropertyActivityFlagUpdated_true() {
        
        interactor.trackPropertyActivityFlagUpdated(to: true)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        #expect(userDefaults.calledMethods == [.setBoolValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .boolValue])
        #expect(userDefaults.defaultName == UserDefaultsKey.trackPropertyActivity)
        #expect(userDefaults.boolValue == true)
    }
    
    @Test func publicFlagUpdated_false() {
        
        interactor.publicFlagUpdated(to: false)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        #expect(userDefaults.calledMethods == [.setBoolValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .boolValue])
        #expect(userDefaults.defaultName == UserDefaultsKey.public)
        #expect(userDefaults.boolValue == false)
    }
    
    @Test func publicFlagUpdated_true() {
        
        interactor.publicFlagUpdated(to: true)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        #expect(userDefaults.calledMethods == [.setBoolValueForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName, .boolValue])
        #expect(userDefaults.defaultName == UserDefaultsKey.public)
        #expect(userDefaults.boolValue == true)
    }
    
    @Test func viewHasLoaded() {
        
        interactor.viewHasLoaded()
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        #expect(userDefaults.calledMethods == [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        #expect(userDefaults.assignedParameters == [.defaultName])
        #expect(userDefaults.defaultNames == [UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        #expect(presenter.calledMethods == [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolIncludeTestableImportTrackPropertyActivityPublicCalled])
        #expect(presenter.assignedParameters == [.prefix, .includeHeader, .stripTrailingProtocol, .includeTestableImport, .trackPropertyActivity, .public, .name])
    }
}
//swiftlint:enable file_length
