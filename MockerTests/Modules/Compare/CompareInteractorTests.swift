//
//  CompareInteractorTests.swift
//  MockerTests
//
//  Created by Greg Strobl on 9/29/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Testing
import Foundation
@testable import Mocker
import MacrosForStroblMocks

@MainActor @UsesStroblMocks
struct CompareInteractorTests {

    @StroblMock var comparisonToolInvoker: MockComparisonToolInvoking!
    @StroblMock var temporaryFileHandler: MockTemporaryFileHandling!
    @StroblMock var presenter: MockCompareInteractorOutput!
    var interactor: CompareInteractor!

    let mockCode = "MOCK-CODE"
    let fileForMockUrl = URL(fileURLWithPath: "fileForMock")
    let fileToCompareAgainstUrl = URL(fileURLWithPath: "fileToCompareAgainst")

    init() async {
        comparisonToolInvoker = MockComparisonToolInvoking()
        temporaryFileHandler = MockTemporaryFileHandling()
        temporaryFileHandler.errorToThrow = UnitTestError.generic
        temporaryFileHandler.saveToTemporaryFileStringReturnValue = fileForMockUrl
        presenter = MockCompareInteractorOutput()
        presenter.mockCodeForCompareReturnValue = mockCode
        interactor = CompareInteractor(
            comparisonToolInvoker: comparisonToolInvoker,
            temporaryFileHandler: temporaryFileHandler
        )
        interactor.presenter = presenter
        presenter.reset()
        comparisonToolInvoker.reset()
    }

    // MARK: - init
    
    @Test func testInit_showButtonFalse() {
        
        let interactor = CompareInteractor(
            comparisonToolInvoker: comparisonToolInvoker,
            temporaryFileHandler: temporaryFileHandler
        )
        interactor.showButton = false
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .comparisonToolInvoker])
        #expect(presenter.calledMethods == [.showButtonFlagCalled])
        #expect(presenter.assignedParameters == [.flag])
        #expect(presenter.flag == false)
        #expect(comparisonToolInvoker.calledMethods == [.lookForComparisonToolCalled])
        #expect(comparisonToolInvoker.assignedParameters == [])
    }
    
    @Test func testInit_showButtonTrue() {
        
        let interactor = CompareInteractor(
            comparisonToolInvoker: comparisonToolInvoker,
            temporaryFileHandler: temporaryFileHandler
        )
        interactor.showButton = true
        interactor.presenter = presenter
        
        verifyStroblMocksUnused(except: [.presenter, .comparisonToolInvoker])
        #expect(presenter.calledMethods == [.showButtonFlagCalled])
        #expect(presenter.assignedParameters == [.flag])
        #expect(presenter.flag == true)
        #expect(comparisonToolInvoker.calledMethods == [.lookForComparisonToolCalled])
        #expect(comparisonToolInvoker.assignedParameters == [])
    }

    // MARK: - CompareInteractorInputProtocol methods

    @Test func fileToCompareSelected_presenterNil() {
        interactor.presenter = nil
        
        interactor.fileToCompareSelected(fileToCompareAgainstUrl)
        
        verifyStroblMocksUnused()
    }

    @Test func fileToCompareSelected_mockCodeEmpty() {
        presenter.mockCodeForCompareReturnValue = ""
        
        interactor.fileToCompareSelected(fileToCompareAgainstUrl)
        
        verifyStroblMocksUnused(except: [.presenter])
        #expect(presenter.calledMethods == [.mockCodeForCompareCalled, .reportErrorConditionWithMessageTextAndInformativeTextCalled])
        #expect(presenter.assignedParameters == [.messageText, .informativeText])
        #expect(presenter.messageText == "Unable to Compare")
        #expect(presenter.informativeText == "Code for the Mock is empty")
    }

    @Test func fileToCompareSelected_saveToTemporaryFileThrows() {
        temporaryFileHandler.saveToTemporaryFileStringShouldThrowError = true
        
        interactor.fileToCompareSelected(fileToCompareAgainstUrl)
        
        verifyStroblMocksUnused(except: [.presenter, .temporaryFileHandler])
        #expect(presenter.calledMethods == [.mockCodeForCompareCalled, .reportErrorConditionWithMessageTextAndInformativeTextCalled])
        #expect(presenter.assignedParameters == [.messageText, .informativeText])
        #expect(presenter.messageText == "Unable to Compare")
        #expect(presenter.informativeText == "Saving Mock code to temporary file failed: The operation couldn’t be completed. (MockerTests.UnitTestError error 0.)")
        #expect(temporaryFileHandler.calledMethods == [.saveToTemporaryFileStringCalled])
        #expect(temporaryFileHandler.assignedParameters == [.string])
        #expect(temporaryFileHandler.string == mockCode)
    }

    @Test func fileToCompareSelected_openComparisonToolReturnsFailure() {
        comparisonToolInvoker.openComparisonToolForUrl1AndUrl2ReturnValue = (-1, "Something Failed")
        
        interactor.fileToCompareSelected(fileToCompareAgainstUrl)
        
        verifyStroblMocksUnused(except: [.presenter, .temporaryFileHandler, .comparisonToolInvoker])
        #expect(presenter.calledMethods == [.mockCodeForCompareCalled, .reportErrorConditionWithMessageTextAndInformativeTextCalled])
        #expect(presenter.assignedParameters == [.messageText, .informativeText])
        #expect(presenter.messageText == "Comparison Error")
        #expect(presenter.informativeText == "Attempt to compare returned a failure status: -1\n\nSomething Failed")
        #expect(temporaryFileHandler.calledMethods == [.saveToTemporaryFileStringCalled])
        #expect(temporaryFileHandler.assignedParameters == [.string])
        #expect(temporaryFileHandler.string == mockCode)
    }

    @Test func fileToCompareSelected_openComparisonToolReturnsSuccess() {
        
        interactor.fileToCompareSelected(fileToCompareAgainstUrl)
        
        verifyStroblMocksUnused(except: [.presenter, .temporaryFileHandler, .comparisonToolInvoker])
        #expect(presenter.calledMethods == [.mockCodeForCompareCalled])
        #expect(presenter.assignedParameters == [])
        #expect(temporaryFileHandler.calledMethods == [.saveToTemporaryFileStringCalled])
        #expect(temporaryFileHandler.assignedParameters == [.string])
        #expect(temporaryFileHandler.string == mockCode)
    }

    // MARK: - ComparisonToolInvokerDelegate methods

    @Test func invokerToolFoundTrue_presenterNil() {
        interactor.presenter = nil
        
        interactor.invoker(comparisonToolInvoker, toolFound: true)
        
        #expect(interactor.showButton == true)
        verifyStroblMocksUnused()
    }

    @Test func invokerToolFoundTrue() {
        
        interactor.invoker(comparisonToolInvoker, toolFound: true)
        
        #expect(interactor.showButton == true)
        verifyStroblMocksUnused(except: [.presenter])
        #expect(presenter.calledMethods == [.showButtonFlagCalled])
        #expect(presenter.assignedParameters == [.flag])
        #expect(presenter.flag == true)
    }

    @Test func invokerToolFoundFalse() {
        
        interactor.invoker(comparisonToolInvoker, toolFound: false)
        
        #expect(interactor.showButton == false)
        verifyStroblMocksUnused(except: [.presenter])
        #expect(presenter.calledMethods == [.showButtonFlagCalled])
        #expect(presenter.assignedParameters == [.flag])
        #expect(presenter.flag == false)
    }
}
