//
//  FilteringOperation.swift
//  Mocker
//
//  Created by Greg on 10/13/18.
//

import Foundation

class FilteringOperation: Operation, @unchecked Sendable {
    
    let dataSource: any SourceFileDataSource
    let filter: String
    let completionHandler: (SendableTreeNode) -> Void
    
    init(dataSource: any SourceFileDataSource, filter: String, completionHandler: @escaping (SendableTreeNode) -> Void) {
        self.dataSource = dataSource
        self.filter = filter
        self.completionHandler = completionHandler
        super.init()
    }
    
    override func main() {
        let result = dataSource.traverse(filteredBy: filter, monitoredBy: self, fileManager: FileManager.default)
        if !isCancelled {
            DispatchQueue.main.async {
                self.completionHandler(result)
            }
        }
    }
}
