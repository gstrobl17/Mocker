//
//  MockFileParametersInteractorTests.swift
//  MockerTests
//
//  Created by Greg on 2/26/18.
//

import XCTest
@testable import Mocker

//swiftlint:disable:next type_body_length
class MockFileParametersInteractorTests: XCTestCase {

    var presenter: MockMockFileParametersInteractorOutput!
    var userDefaults: MockUserDefaults!
    
    override func setUp() {
        super.setUp()
        
        userDefaults = MockUserDefaults()
        presenter = MockMockFileParametersInteractorOutput()
    }
    
    // MARK: - init -
    
    func testInit() {
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .name])
        XCTAssertEqual(presenter.prefix, DefaultUserDefaultValue.mockPrefix)
        XCTAssertEqual(presenter.includeHeader, DefaultUserDefaultValue.includeHeader)
        XCTAssertEqual(presenter.stripTrailingProtocol, DefaultUserDefaultValue.stripTrailingProtocol)
        XCTAssertEqual(presenter.swiftlintAware, DefaultUserDefaultValue.swiftlintAware)
        XCTAssertEqual(presenter.includeTestableImport, DefaultUserDefaultValue.includeTestableImport)
        XCTAssertEqual(presenter.trackPropertyActivity, DefaultUserDefaultValue.trackPropertyActivity)
        XCTAssertEqual(presenter.name, "")
    }
    
    func testInit_alternativePrefixValue() {
        let alternativePrefix = "Prefix"
        userDefaults.mockPrefix = alternativePrefix
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .name])
        XCTAssertEqual(presenter.prefix, alternativePrefix)
        XCTAssertEqual(presenter.includeHeader, DefaultUserDefaultValue.includeHeader)
        XCTAssertEqual(presenter.stripTrailingProtocol, DefaultUserDefaultValue.stripTrailingProtocol)
        XCTAssertEqual(presenter.swiftlintAware, DefaultUserDefaultValue.swiftlintAware)
        XCTAssertEqual(presenter.includeTestableImport, DefaultUserDefaultValue.includeTestableImport)
        XCTAssertEqual(presenter.trackPropertyActivity, DefaultUserDefaultValue.trackPropertyActivity)
        XCTAssertEqual(presenter.name, "")
    }
    
    func testInit_alternativeIncludeHeaderValue() {
        let alternativeIncludeHeader = !DefaultUserDefaultValue.includeHeader
        userDefaults.includeHeader = alternativeIncludeHeader
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .name])
        XCTAssertEqual(presenter.prefix, DefaultUserDefaultValue.mockPrefix)
        XCTAssertEqual(presenter.includeHeader, alternativeIncludeHeader)
        XCTAssertEqual(presenter.stripTrailingProtocol, DefaultUserDefaultValue.stripTrailingProtocol)
        XCTAssertEqual(presenter.swiftlintAware, DefaultUserDefaultValue.swiftlintAware)
        XCTAssertEqual(presenter.includeTestableImport, DefaultUserDefaultValue.includeTestableImport)
        XCTAssertEqual(presenter.trackPropertyActivity, DefaultUserDefaultValue.trackPropertyActivity)
        XCTAssertEqual(presenter.name, "")
    }
    
    func testInit_alternativeStripTrailingProtocolValue() {
        let alternativeStripTrailingProtocol = !DefaultUserDefaultValue.stripTrailingProtocol
        userDefaults.stripTrailingProtocol = alternativeStripTrailingProtocol
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .name])
        XCTAssertEqual(presenter.prefix, DefaultUserDefaultValue.mockPrefix)
        XCTAssertEqual(presenter.includeHeader, DefaultUserDefaultValue.includeHeader)
        XCTAssertEqual(presenter.stripTrailingProtocol, alternativeStripTrailingProtocol)
        XCTAssertEqual(presenter.swiftlintAware, DefaultUserDefaultValue.swiftlintAware)
        XCTAssertEqual(presenter.includeTestableImport, DefaultUserDefaultValue.includeTestableImport)
        XCTAssertEqual(presenter.trackPropertyActivity, DefaultUserDefaultValue.trackPropertyActivity)
        XCTAssertEqual(presenter.name, "")
    }

    func testInit_alternativeSwiftlintAwareValue() {
        let alternativeSwiftlintAware = !DefaultUserDefaultValue.swiftlintAware
        userDefaults.swiftlintAware = alternativeSwiftlintAware
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .name])
        XCTAssertEqual(presenter.prefix, DefaultUserDefaultValue.mockPrefix)
        XCTAssertEqual(presenter.includeHeader, DefaultUserDefaultValue.includeHeader)
        XCTAssertEqual(presenter.stripTrailingProtocol, DefaultUserDefaultValue.stripTrailingProtocol)
        XCTAssertEqual(presenter.swiftlintAware, alternativeSwiftlintAware)
        XCTAssertEqual(presenter.includeTestableImport, DefaultUserDefaultValue.includeTestableImport)
        XCTAssertEqual(presenter.trackPropertyActivity, DefaultUserDefaultValue.trackPropertyActivity)
        XCTAssertEqual(presenter.name, "")
    }

    func testInit_alternativeIncludeTestableImportValue() {
        let alternativeIncludeTestableImport = !DefaultUserDefaultValue.includeTestableImport
        userDefaults.includeTestableImport = alternativeIncludeTestableImport
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .name])
        XCTAssertEqual(presenter.prefix, DefaultUserDefaultValue.mockPrefix)
        XCTAssertEqual(presenter.includeHeader, DefaultUserDefaultValue.includeHeader)
        XCTAssertEqual(presenter.stripTrailingProtocol, DefaultUserDefaultValue.stripTrailingProtocol)
        XCTAssertEqual(presenter.swiftlintAware, DefaultUserDefaultValue.swiftlintAware)
        XCTAssertEqual(presenter.includeTestableImport, alternativeIncludeTestableImport)
        XCTAssertEqual(presenter.trackPropertyActivity, DefaultUserDefaultValue.trackPropertyActivity)
        XCTAssertEqual(presenter.name, "")
    }

    func testInit_alternativeTrackPropertyActivityValue() {
        let alternativeTrackPropertyActivity = !DefaultUserDefaultValue.trackPropertyActivity
        userDefaults.trackPropertyActivity = alternativeTrackPropertyActivity
        
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .name])
        XCTAssertEqual(presenter.prefix, DefaultUserDefaultValue.mockPrefix)
        XCTAssertEqual(presenter.includeHeader, DefaultUserDefaultValue.includeHeader)
        XCTAssertEqual(presenter.stripTrailingProtocol, DefaultUserDefaultValue.stripTrailingProtocol)
        XCTAssertEqual(presenter.swiftlintAware, DefaultUserDefaultValue.swiftlintAware)
        XCTAssertEqual(presenter.includeTestableImport, DefaultUserDefaultValue.includeTestableImport)
        XCTAssertEqual(presenter.trackPropertyActivity, alternativeTrackPropertyActivity)
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
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.setProtocolName("MyProtocol")
        
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled])
        XCTAssertEqual(presenter.assignedParameters, [.name])
        XCTAssertEqual(presenter.name, "MockMy")
    }
    
    func test_prefixUpdated() {
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.prefixUpdated(to: "Prefix")
        
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled])
        XCTAssertEqual(presenter.assignedParameters, [.name])
        XCTAssertEqual(presenter.name, "")
        XCTAssertEqual(userDefaults.mockPrefix, "Prefix")
    }
    
    func test_includeHeaderFlagUpdated_false() {
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.includeHeaderFlagUpdated(to: false)
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(userDefaults.includeHeader, false)
    }
    
    func test_includeHeaderFlagUpdated_true() {
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.includeHeaderFlagUpdated(to: true)
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(userDefaults.includeHeader, true)
    }

    func test_stripTrailingProtocolFlagUpdated_false() {
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.stripTrailingProtocolFlagUpdated(to: false)
        
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled])
        XCTAssertEqual(presenter.assignedParameters, [.name])
        XCTAssertEqual(presenter.name, "")
        XCTAssertEqual(userDefaults.stripTrailingProtocol, false)
    }
    
    func test_stripTrailingProtocolFlagUpdated_true() {
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.stripTrailingProtocolFlagUpdated(to: true)
        
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled])
        XCTAssertEqual(presenter.assignedParameters, [.name])
        XCTAssertEqual(presenter.name, "")
        XCTAssertEqual(userDefaults.stripTrailingProtocol, true)
    }
    
    func test_swiftlintAwareFlagUpdated_false() {
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.swiftlintAwareFlagUpdated(to: false)
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(userDefaults.swiftlintAware, false)
    }
    
    func test_swiftlintAwareFlagUpdated_true() {
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.swiftlintAwareFlagUpdated(to: true)
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(userDefaults.swiftlintAware, true)
    }

    func test_includeTestableImportFlagUpdated_false() {
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.includeTestableImportFlagUpdated(to: false)
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(userDefaults.includeTestableImport, false)
    }
    
    func test_includeTestableImportFlagUpdated_true() {
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.includeTestableImportFlagUpdated(to: true)
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(userDefaults.includeTestableImport, true)
    }
    
    func test_trackPropertyActivityFlagUpdated_false() {
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.trackPropertyActivityFlagUpdated(to: false)
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(userDefaults.trackPropertyActivity, false)
    }
    
    func test_trackPropertyActivityFlagUpdated_true() {
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()
        
        interactor.trackPropertyActivityFlagUpdated(to: true)
        
        XCTAssertEqual(presenter.calledMethods, [])
        XCTAssertEqual(userDefaults.trackPropertyActivity, true)
    }

    func test_viewHasLoaded() {
        let interactor = MockFileParametersInteractor(userDefaults: userDefaults)
        interactor.presenter = presenter
        presenter.reset()

        interactor.viewHasLoaded()
        
        XCTAssertEqual(presenter.calledMethods, [.setNameNameCalled, .setParametersPrefixIncludeHeaderStripTrailingProtocolSwiftlintAwareIncludeTestableImportTrackPropertyActivityCalled])
        XCTAssertEqual(presenter.assignedParameters, [.prefix, .includeHeader, .stripTrailingProtocol, .swiftlintAware, .includeTestableImport, .trackPropertyActivity, .name])
    }
}
