//
//  FilteringOperation.swift
//  Mocker
//
//  Created by Greg on 10/13/18.
//

import Foundation

class FilteringOperation: Operation, @unchecked Sendable {
    
    weak var dataSource: (any SourceFileDataSource)?
    let filter: String
    let completionHandler: (ProjectTraversalResult) -> Void
    
    init(dataSource: any SourceFileDataSource, filter: String, completionHandler: @escaping (ProjectTraversalResult) -> Void) {
        self.dataSource = dataSource
        self.filter = filter
        self.completionHandler = completionHandler
        super.init()
    }
    
    override func main() {
        guard let dataSource = dataSource else { return }
        let result = dataSource.traverse(filteredBy: filter, monitoredBy: self)
        if !isCancelled {
            completionHandler(result)
        }
    }
}
