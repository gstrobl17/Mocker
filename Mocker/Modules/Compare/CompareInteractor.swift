//
//  CompareInteractor.swift
//  Mocker
//
//  Created Greg Strobl on 9/27/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import AppKit

@MainActor
class CompareInteractor {

    weak var presenter: (any CompareInteractorOutputProtocol)? {
        didSet {
            presenter?.showButton(showButton)
        }
    }
    private(set) var comparisonToolInvoker: any ComparisonToolInvoking
    private(set) var temporaryFileHandler: any TemporaryFileHandling
    private(set) var showButton = false

    init(
        comparisonToolInvoker: any ComparisonToolInvoking = BeyondCompareComparisonToolInvoker(fileManager: FileManager.default),
        temporaryFileHandler: any TemporaryFileHandling = TemporaryFileHandler()
    ) {
        self.comparisonToolInvoker = comparisonToolInvoker
        self.temporaryFileHandler = temporaryFileHandler
        self.comparisonToolInvoker.delegate = self
        
        self.comparisonToolInvoker.lookForComparisonTool()
    }
}

extension CompareInteractor: CompareInteractorInputProtocol {

    func fileToCompareSelected(_ fileToCompareAgainst: URL) {
        
        // Get the source of the mock
        let mockCode = presenter?.mockCodeForCompare() ?? ""
        if mockCode.isEmpty {
            presenter?.reportErrorCondition(with: "Unable to Compare", and: "Code for the Mock is empty")
            return
        }
        
        // Save the mock source in a temporary file
        let fileForMock: URL
        do {
            fileForMock = try temporaryFileHandler.saveToTemporaryFile(mockCode)
        } catch {
            presenter?.reportErrorCondition(with: "Unable to Compare", and: "Saving Mock code to temporary file failed: \(error.localizedDescription)")
            return
        }
        
        // Compare
        let result = comparisonToolInvoker.openComparisonTool(for: fileForMock, and: fileToCompareAgainst)
        if result.terminationStatus != 0 {
            presenter?.reportErrorCondition(with: "Comparison Error", and: "Attempt to comare returned a failure status: \(result.terminationStatus):\n\n\(result.output)")
        }
    }
}

// Had to use @preconcurrency here because the compiler thinks that Bools aren't sendable for some reason
extension CompareInteractor: @preconcurrency ComparisonToolInvokerDelegate {
    
   func invoker(_ invoker: any ComparisonToolInvoking, toolFound: Bool) {
        showButton = toolFound
        presenter?.showButton(toolFound)
    }
    
}
