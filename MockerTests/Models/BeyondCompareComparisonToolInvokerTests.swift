//
//  BeyondCompareComparisonToolInvokerTests.swift
//  MockerTests
//
//  Created by Greg Strobl on 9/29/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Testing
import Foundation
@testable import Mocker
import MacrosForStroblMocks

@UsesStroblMocks
struct BeyondCompareComparisonToolInvokerTests {
    
    @StroblMock var delegate: MockComparisonToolInvokerDelegate!
    @StroblMock var fileManager: MockFileManager!
    var invoker: BeyondCompareComparisonToolInvoker!
    
    init() {
        delegate = MockComparisonToolInvokerDelegate()
        fileManager = MockFileManager()
        invoker = BeyondCompareComparisonToolInvoker(fileManager: fileManager)
        invoker.delegate = delegate
    }

    @Test func lookForComparisonTool_bcompareNotFound() {
        fileManager.fileExistsAtPathPathReturnValue = false
        
        invoker.lookForComparisonTool()
        
        verifyStroblMocksUnused(except: [.fileManager, .delegate])
        #expect(fileManager.calledMethods == [.fileExistsAtPathPathCalled])
        #expect(fileManager.assignedParameters == [.path])
        #expect(fileManager.path == BeyondCompareComparisonToolInvoker.Constant.executablePath)
        #expect(delegate.calledMethods == [.invokerInvokerToolFoundCalled])
        #expect(delegate.assignedParameters == [.invoker, .toolFound])
        #expect(delegate.invoker != nil)
        #expect(delegate.toolFound == false)
    }

    @Test func lookForComparisonTool_bcompareFound() {
        fileManager.fileExistsAtPathPathReturnValue = true
        
        invoker.lookForComparisonTool()
        
        verifyStroblMocksUnused(except: [.fileManager, .delegate])
        #expect(fileManager.calledMethods == [.fileExistsAtPathPathCalled])
        #expect(fileManager.assignedParameters == [.path])
        #expect(fileManager.path == BeyondCompareComparisonToolInvoker.Constant.executablePath)
        #expect(delegate.calledMethods == [.invokerInvokerToolFoundCalled])
        #expect(delegate.assignedParameters == [.invoker, .toolFound])
        #expect(delegate.invoker != nil)
        #expect(delegate.toolFound == true)
    }
    
    // Can't test openComparisonTool(for:and:) unless Process() and Pipe() are abstracted
}
