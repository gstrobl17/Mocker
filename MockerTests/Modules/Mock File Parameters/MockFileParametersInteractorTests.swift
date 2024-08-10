//swiftlint:disable file_length
//
//  MockFileParametersInteractorTests.swift
//  MockerTests
//
//  Created by Greg on 2/26/18.
//

import XCTest
@testable import Mocker
import MacrosForStroblMocks

@UsesStroblMocks
//swiftlint:disable:next type_body_length
class MockFileParametersInteractorTests: XCTestCase {
    
    @StroblMock var presenter: MockMockFileParametersInteractorOutput!
    @StroblMock var userDefaults: MockUserDefaults!
    var interactor: MockFileParametersInteractor!
    
    override func setUp() {
        super.setUp()
        
        userDefaults = MockUserDefaults()
        presenter = MockMockFileParametersInteractorOutput()
        
        interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        userDefaults.reset()
        presenter.reset()
    }
    
    // MARK: - init -
    
    func testInit() {
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.swiftlintAware, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityPublicCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .public, .name])
        XCTAssertEqual(presenter.prefix, DefaultUserDefaultValue.mockPrefix)
        XCTAssertEqual(presenter.includeHeader, DefaultUserDefaultValue.includeHeader)
        XCTAssertEqual(presenter.stripTrailingProtocol, DefaultUserDefaultValue.stripTrailingProtocol)
        XCTAssertEqual(presenter.swiftlintAware, DefaultUserDefaultValue.swiftlintAware)
        XCTAssertEqual(presenter.includeTestableImport, DefaultUserDefaultValue.includeTestableImport)
        XCTAssertEqual(presenter.trackPropertyActivity, DefaultUserDefaultValue.trackPropertyActivity)
        XCTAssertEqual(presenter.public, DefaultUserDefaultValue.public)
        XCTAssertEqual(presenter.name, "")
    }
    
    func testInit_alternativePrefixValue() {
        let alternativePrefix = "Prefix"
        userDefaults.mockPrefix = alternativePrefix
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .setValueForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .value])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.mockPrefix, UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.swiftlintAware, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        XCTAssertEqual(userDefaults.values.count, 1)
        XCTAssertTrue(userDefaults.values is [String])
        if let values = userDefaults.values as? [String] {
            XCTAssertEqual(values, [alternativePrefix])
        }
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityPublicCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .public, .name])
        XCTAssertEqual(presenter.prefix, alternativePrefix)
        XCTAssertEqual(presenter.includeHeader, DefaultUserDefaultValue.includeHeader)
        XCTAssertEqual(presenter.stripTrailingProtocol, DefaultUserDefaultValue.stripTrailingProtocol)
        XCTAssertEqual(presenter.swiftlintAware, DefaultUserDefaultValue.swiftlintAware)
        XCTAssertEqual(presenter.includeTestableImport, DefaultUserDefaultValue.includeTestableImport)
        XCTAssertEqual(presenter.trackPropertyActivity, DefaultUserDefaultValue.trackPropertyActivity)
        XCTAssertEqual(presenter.public, DefaultUserDefaultValue.public)
        XCTAssertEqual(presenter.name, "")
    }
    
    func testInit_alternativeIncludeHeaderValue() {
        let alternativeIncludeHeader = !DefaultUserDefaultValue.includeHeader
        userDefaults.includeHeader = alternativeIncludeHeader
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled, .boolForKeyDefaultNameCalled, .setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.includeHeader, UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.swiftlintAware, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        XCTAssertEqual(userDefaults.values.count, 1)
        XCTAssertTrue(userDefaults.values is [Bool])
        if let values = userDefaults.values as? [Bool] {
            XCTAssertEqual(values, [alternativeIncludeHeader])
        }
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityPublicCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .public, .name])
        XCTAssertEqual(presenter.prefix, DefaultUserDefaultValue.mockPrefix)
        XCTAssertEqual(presenter.includeHeader, alternativeIncludeHeader)
        XCTAssertEqual(presenter.stripTrailingProtocol, DefaultUserDefaultValue.stripTrailingProtocol)
        XCTAssertEqual(presenter.swiftlintAware, DefaultUserDefaultValue.swiftlintAware)
        XCTAssertEqual(presenter.includeTestableImport, DefaultUserDefaultValue.includeTestableImport)
        XCTAssertEqual(presenter.trackPropertyActivity, DefaultUserDefaultValue.trackPropertyActivity)
        XCTAssertEqual(presenter.public, DefaultUserDefaultValue.public)
        XCTAssertEqual(presenter.name, "")
    }
    
    func testInit_alternativeStripTrailingProtocolValue() {
        let alternativeStripTrailingProtocol = !DefaultUserDefaultValue.stripTrailingProtocol
        userDefaults.stripTrailingProtocol = alternativeStripTrailingProtocol
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled, .boolForKeyDefaultNameCalled, .setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.swiftlintAware, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        XCTAssertEqual(userDefaults.values.count, 1)
        XCTAssertTrue(userDefaults.values is [Bool])
        if let values = userDefaults.values as? [Bool] {
            XCTAssertEqual(values, [alternativeStripTrailingProtocol])
        }
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityPublicCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .public, .name])
        XCTAssertEqual(presenter.prefix, DefaultUserDefaultValue.mockPrefix)
        XCTAssertEqual(presenter.includeHeader, DefaultUserDefaultValue.includeHeader)
        XCTAssertEqual(presenter.stripTrailingProtocol, alternativeStripTrailingProtocol)
        XCTAssertEqual(presenter.swiftlintAware, DefaultUserDefaultValue.swiftlintAware)
        XCTAssertEqual(presenter.includeTestableImport, DefaultUserDefaultValue.includeTestableImport)
        XCTAssertEqual(presenter.trackPropertyActivity, DefaultUserDefaultValue.trackPropertyActivity)
        XCTAssertEqual(presenter.public, DefaultUserDefaultValue.public)
        XCTAssertEqual(presenter.name, "")
    }
    
    func testInit_alternativeSwiftlintAwareValue() {
        let alternativeSwiftlintAware = !DefaultUserDefaultValue.swiftlintAware
        userDefaults.swiftlintAware = alternativeSwiftlintAware
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled, .boolForKeyDefaultNameCalled, .setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.swiftlintAware, UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.swiftlintAware, UserDefaultsKey.swiftlintAware, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        XCTAssertEqual(userDefaults.values.count, 1)
        XCTAssertTrue(userDefaults.values is [Bool])
        if let values = userDefaults.values as? [Bool] {
            XCTAssertEqual(values, [alternativeSwiftlintAware])
        }
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityPublicCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .public, .name])
        XCTAssertEqual(presenter.prefix, DefaultUserDefaultValue.mockPrefix)
        XCTAssertEqual(presenter.includeHeader, DefaultUserDefaultValue.includeHeader)
        XCTAssertEqual(presenter.stripTrailingProtocol, DefaultUserDefaultValue.stripTrailingProtocol)
        XCTAssertEqual(presenter.swiftlintAware, alternativeSwiftlintAware)
        XCTAssertEqual(presenter.includeTestableImport, DefaultUserDefaultValue.includeTestableImport)
        XCTAssertEqual(presenter.trackPropertyActivity, DefaultUserDefaultValue.trackPropertyActivity)
        XCTAssertEqual(presenter.public, DefaultUserDefaultValue.public)
        XCTAssertEqual(presenter.name, "")
    }
    
    func testInit_alternativeIncludeTestableImportValue() {
        let alternativeIncludeTestableImport = !DefaultUserDefaultValue.includeTestableImport
        userDefaults.includeTestableImport = alternativeIncludeTestableImport
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled, .boolForKeyDefaultNameCalled, .setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.includeTestableImport, UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.swiftlintAware, UserDefaultsKey.includeTestableImport, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        XCTAssertEqual(userDefaults.values.count, 1)
        XCTAssertTrue(userDefaults.values is [Bool])
        if let values = userDefaults.values as? [Bool] {
            XCTAssertEqual(values, [alternativeIncludeTestableImport])
        }
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityPublicCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .public, .name])
        XCTAssertEqual(presenter.prefix, DefaultUserDefaultValue.mockPrefix)
        XCTAssertEqual(presenter.includeHeader, DefaultUserDefaultValue.includeHeader)
        XCTAssertEqual(presenter.stripTrailingProtocol, DefaultUserDefaultValue.stripTrailingProtocol)
        XCTAssertEqual(presenter.swiftlintAware, DefaultUserDefaultValue.swiftlintAware)
        XCTAssertEqual(presenter.includeTestableImport, alternativeIncludeTestableImport)
        XCTAssertEqual(presenter.trackPropertyActivity, DefaultUserDefaultValue.trackPropertyActivity)
        XCTAssertEqual(presenter.public, DefaultUserDefaultValue.public)
        XCTAssertEqual(presenter.name, "")
    }
    
    func testInit_alternativeTrackPropertyActivityValue() {
        let alternativeTrackPropertyActivity = !DefaultUserDefaultValue.trackPropertyActivity
        userDefaults.trackPropertyActivity = alternativeTrackPropertyActivity
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled, .boolForKeyDefaultNameCalled, .setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.swiftlintAware, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        XCTAssertEqual(userDefaults.values.count, 1)
        XCTAssertTrue(userDefaults.values is [Bool])
        if let values = userDefaults.values as? [Bool] {
            XCTAssertEqual(values, [alternativeTrackPropertyActivity])
        }
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityPublicCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .public, .name])
        XCTAssertEqual(presenter.prefix, DefaultUserDefaultValue.mockPrefix)
        XCTAssertEqual(presenter.includeHeader, DefaultUserDefaultValue.includeHeader)
        XCTAssertEqual(presenter.stripTrailingProtocol, DefaultUserDefaultValue.stripTrailingProtocol)
        XCTAssertEqual(presenter.swiftlintAware, DefaultUserDefaultValue.swiftlintAware)
        XCTAssertEqual(presenter.includeTestableImport, DefaultUserDefaultValue.includeTestableImport)
        XCTAssertEqual(presenter.trackPropertyActivity, alternativeTrackPropertyActivity)
        XCTAssertEqual(presenter.public, DefaultUserDefaultValue.public)
        XCTAssertEqual(presenter.name, "")
    }
    
    func testInit_alternativePublicValue() {
        let alternativePublic = !DefaultUserDefaultValue.public
        userDefaults.public = alternativePublic
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled, .boolForKeyDefaultNameCalled, .setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.public, UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.swiftlintAware, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public, UserDefaultsKey.public])
        XCTAssertEqual(userDefaults.values.count, 1)
        XCTAssertTrue(userDefaults.values is [Bool])
        if let values = userDefaults.values as? [Bool] {
            XCTAssertEqual(values, [alternativePublic])
        }
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityPublicCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .public, .name])
        XCTAssertEqual(presenter.prefix, DefaultUserDefaultValue.mockPrefix)
        XCTAssertEqual(presenter.includeHeader, DefaultUserDefaultValue.includeHeader)
        XCTAssertEqual(presenter.stripTrailingProtocol, DefaultUserDefaultValue.stripTrailingProtocol)
        XCTAssertEqual(presenter.swiftlintAware, DefaultUserDefaultValue.swiftlintAware)
        XCTAssertEqual(presenter.includeTestableImport, DefaultUserDefaultValue.includeTestableImport)
        XCTAssertEqual(presenter.trackPropertyActivity, DefaultUserDefaultValue.trackPropertyActivity)
        XCTAssertEqual(presenter.public, alternativePublic)
        XCTAssertEqual(presenter.name, "")
    }

    // MARK: - mockFileName -
    
    func test_mockFileName_defaultValuesNoProtocolName() {
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        
        let value = interactor.mockFileName
        
        XCTAssertEqual(value, "")
    }
    
    func test_mockFileName_defaultValuesWithProtocolName() {
        let protocolName = "MySpecialProtocol"
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.setProtocolName(protocolName)
        
        let value = interactor.mockFileName
        
        XCTAssertEqual(value, "MockMySpecial")
    }
    
    func test_mockFileName_stripTrailingProtocolFalse() {
        let protocolName = "MySpecialProtocol"
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.setProtocolName(protocolName)
        interactor.stripTrailingProtocolFlagUpdated(to: false)
        
        let value = interactor.mockFileName
        
        XCTAssertEqual(value, "MockMySpecialProtocol")
    }
    
    func test_mockFileName_prefixSetToFake() {
        let protocolName = "MySpecialProtocol"
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.setProtocolName(protocolName)
        interactor.prefixUpdated(to: "Fake")
        
        let value = interactor.mockFileName
        
        XCTAssertEqual(value, "FakeMySpecial")
    }
    
    func test_mockFileName_extraWhiteSpaceAddedToProtocolNameAndPrefix() {
        let protocolName = "   MySpecialProtocol   "
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.setProtocolName(protocolName)
        interactor.prefixUpdated(to: "   Fake    ")
        
        let value = interactor.mockFileName
        
        XCTAssertEqual(value, "FakeMySpecial")
    }
    
    // MARK: - MockFileParametersInteractorInputProtocol methods -
    
    func test_setProtocolName() {
        
        interactor.setProtocolName("MyProtocol")
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.mockPrefix, UserDefaultsKey.stripTrailingProtocol])
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled])
        XCTAssertEqual(presenter.assignedParameters, [.name])
        XCTAssertEqual(presenter.name, "MockMy")
    }
    
    func test_prefixUpdated() {
        
        interactor.prefixUpdated(to: "Prefix")
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.setValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .value])
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled])
        XCTAssertEqual(presenter.assignedParameters, [.name])
        XCTAssertEqual(presenter.name, "")
        XCTAssertEqual(userDefaults.mockPrefix, "Prefix")
    }
    
    func test_includeHeaderFlagUpdated_false() {
        
        interactor.includeHeaderFlagUpdated(to: false)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.includeHeader)
        XCTAssertEqual(userDefaults.boolValue, false)
    }
    
    func test_includeHeaderFlagUpdated_true() {
        
        interactor.includeHeaderFlagUpdated(to: true)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.includeHeader)
        XCTAssertEqual(userDefaults.boolValue, true)
    }
    
    func test_stripTrailingProtocolFlagUpdated_false() {
        
        interactor.stripTrailingProtocolFlagUpdated(to: false)
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.stripTrailingProtocol)
        XCTAssertEqual(userDefaults.boolValue, false)
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled])
        XCTAssertEqual(presenter.assignedParameters, [.name])
        XCTAssertEqual(presenter.name, "")
        XCTAssertEqual(userDefaults.stripTrailingProtocol, false)
    }
    
    func test_stripTrailingProtocolFlagUpdated_true() {
        
        interactor.stripTrailingProtocolFlagUpdated(to: true)
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.stripTrailingProtocol)
        XCTAssertEqual(userDefaults.boolValue, true)
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled])
        XCTAssertEqual(presenter.assignedParameters, [.name])
        XCTAssertEqual(presenter.name, "")
        XCTAssertEqual(userDefaults.stripTrailingProtocol, true)
    }
    
    func test_swiftlintAwareFlagUpdated_false() {
        
        interactor.swiftlintAwareFlagUpdated(to: false)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.swiftlintAware)
        XCTAssertEqual(userDefaults.boolValue, false)
    }
    
    func test_swiftlintAwareFlagUpdated_true() {
        
        interactor.swiftlintAwareFlagUpdated(to: true)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.swiftlintAware)
        XCTAssertEqual(userDefaults.boolValue, true)
    }
    
    func test_includeTestableImportFlagUpdated_false() {
        
        interactor.includeTestableImportFlagUpdated(to: false)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.includeTestableImport)
        XCTAssertEqual(userDefaults.boolValue, false)
    }
    
    func test_includeTestableImportFlagUpdated_true() {
        
        interactor.includeTestableImportFlagUpdated(to: true)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.includeTestableImport)
        XCTAssertEqual(userDefaults.boolValue, true)
    }
    
    func test_trackPropertyActivityFlagUpdated_false() {
        
        interactor.trackPropertyActivityFlagUpdated(to: false)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.trackPropertyActivity)
        XCTAssertEqual(userDefaults.boolValue, false)
    }
    
    func test_trackPropertyActivityFlagUpdated_true() {
        
        interactor.trackPropertyActivityFlagUpdated(to: true)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.trackPropertyActivity)
        XCTAssertEqual(userDefaults.boolValue, true)
    }
    
    func test_publicFlagUpdated_false() {
        
        interactor.publicFlagUpdated(to: false)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.public)
        XCTAssertEqual(userDefaults.boolValue, false)
    }
    
    func test_publicFlagUpdated_true() {
        
        interactor.publicFlagUpdated(to: true)
        
        verifyStroblMocksUnused(except: [.userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.setBoolValueForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName, .boolValue])
        XCTAssertEqual(userDefaults.defaultName, UserDefaultsKey.public)
        XCTAssertEqual(userDefaults.boolValue, true)
    }
    
    func test_viewHasLoaded() {
        
        interactor.viewHasLoaded()
        
        verifyStroblMocksUnused(except: [.presenter, .userDefaults])
        XCTAssertEqual(userDefaults.calledMethods, [.objectForKeyDefaultNameCalled, .stringForKeyDefaultNameCalled])
        XCTAssertEqual(userDefaults.assignedParameters, [.defaultName])
        XCTAssertEqual(userDefaults.defaultNames, [UserDefaultsKey.mockPrefix, UserDefaultsKey.includeHeader, UserDefaultsKey.stripTrailingProtocol, UserDefaultsKey.swiftlintAware, UserDefaultsKey.includeTestableImport, UserDefaultsKey.trackPropertyActivity, UserDefaultsKey.public])
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityPublicCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .public, .name])
    }
}
//swiftlint:enable file_length
