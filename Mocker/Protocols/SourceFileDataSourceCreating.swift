//
//  SourceFileDataSourceCreating.swift
//  Mocker
//
//  Created by Greg Strobl on 5/13/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import Foundation

/// Protocol used to describe a factory of ``SourceFileDataSource`` instances
protocol SourceFileDataSourceCreating {
    
    func createDataSource(for fileURL: URL) throws -> SourceFileDataSource?

}
