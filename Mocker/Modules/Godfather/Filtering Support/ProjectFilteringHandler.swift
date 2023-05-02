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
    
    func performFiltering(on project: Project, with filter: String, completionHandler: @escaping (ProjectTraversalResult) -> Void) {
        
        queue.cancelAllOperations()
        let operation = FilteringOperation(project: project, filter: filter, completionHandler: completionHandler)
        queue.addOperation(operation)
    }
    
}
