//
//  FunctionSignatureSyntax+Extensions.swift
//  Mocker
//
//  Created by Greg Strobl on 6/22/22.
//

import SwiftSyntax

extension FunctionSignatureSyntax {
    
    var throwsOrRethrows: Bool {
        effectSpecifiers?.throwsSpecifier != nil
    }
    
}
