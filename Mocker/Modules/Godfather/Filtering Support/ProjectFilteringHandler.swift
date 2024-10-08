//
//  ProjectFilteringHandler.swift
//  Mocker
//
//  Created by Greg on 10/13/18.
//

import Foundation

class ProjectFilteringHandler: AsyncFilteringHandler {

    let queue: OperationQueue
    
    init() {
        queue = OperationQueue()
        queue.qualityOfService = .userInteractive
        queue.maxConcurrentOperationCount = 1
    }
    
    func performFiltering(on dataSource: any SourceFileDataSource, with filter: String, completionHandler: @escaping (SendableTreeNode) -> Void) {
        
        queue.cancelAllOperations()
        let operation = FilteringOperation(dataSource: dataSource, filter: filter, completionHandler: completionHandler)
        queue.addOperation(operation)
    }
    
}
