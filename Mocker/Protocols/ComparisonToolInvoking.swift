//
//  ComparisonToolInvoking.swift
//  Mocker
//
//  Created by Greg Strobl on 9/27/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

protocol ComparisonToolInvokerDelegate: AnyObject {
    
    func invoker(_ invoker: any ComparisonToolInvoking, toolFound: Bool)
    
}

protocol ComparisonToolInvoking {
    
    var delegate: (any ComparisonToolInvokerDelegate)? { get set }
    
    func lookForComparisonTool()
    func openComparisonTool(for url1: URL, and url2: URL) -> (terminationStatus: Int32, output: String)
    
}
