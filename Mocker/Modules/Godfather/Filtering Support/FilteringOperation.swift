//
//  FilteringOperation.swift
//  Mocker
//
//  Created by Greg on 10/13/18.
//

import Foundation

class FilteringOperation: Operation {
    
    weak var project: Project?
    let filter: String
    let completionHandler: (ProjectTraversalResult) -> Void
    
    init(project: Project, filter: String, completionHandler: @escaping (ProjectTraversalResult) -> Void) {
        self.project = project
        self.filter = filter
        self.completionHandler = completionHandler
        super.init()
    }
    
    override func main() {
        guard let project = project else { return }
        let result = project.traverse(filteredBy: filter, monitoredBy: self)
        if !isCancelled {
            completionHandler(result)
        }
    }
}
