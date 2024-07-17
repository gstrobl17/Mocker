//
//  TupleTypeSyntax+Extensions.swift
//  Mocker
//
//  Created by Greg Strobl on 6/23/22.
//

import SwiftSyntax

extension TupleTypeSyntax {
    
    var concatenatedVariableName: String {
        var concatenatedVariableName = "UNDETERMINED TUPLE NAME"
        for (index, element) in elements.enumerated() {
            if index == 0, let name = element.firstName {
                concatenatedVariableName = name.text.firstLowercased
            } else if let name = element.firstName {
                concatenatedVariableName += name.text.firstUppercased
            }
        }
        concatenatedVariableName += "Tuple"
        return concatenatedVariableName
    }

}
