//
//  FilteringOperation.swift
//  Mocker
//
//  Created by Greg on 10/13/18.
//

import Foundation

class FilteringOperation: Operation {
    
    weak var dataSource: SourceFileDataSource?
    let filter: String
    let completionHandler: (ProjectTraversalResult) -> Void
    
    init(dataSource: SourceFileDataSource, filter: String, completionHandler: @escaping (ProjectTraversalResult) -> Void) {
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
