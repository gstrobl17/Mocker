//
//  AsyncFilteringHandler.swift
//  Mocker
//
//  Created by Greg on 10/13/18.
//

import Foundation

protocol AsyncFilteringHandler {
    
    func performFiltering(on project: Project, with filter: String, completionHandler: @escaping (ProjectTraversalResult) -> Void)
    
}
