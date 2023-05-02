//
//  SwiftlintSupport.swift
//  Mocker
//
//  Created by Strobl, Greg X. -ND on 2/11/19.
//

import Foundation

enum SwiftlintSupport {
    
    enum IdentifierName {
        static let minLength = 3
        static let maxLength = 40
        static let disableThisComment = "//swiftlint:disable:this identifier_name"
        static let disableComment = "//swiftlint:disable identifier_name"
        static let enableComment = "//swiftlint:enable identifier_name"
    }

    enum FunctionParamterCount {
        static let max = 5
        static let disableNextComment = "//swiftlint:disable:next function_parameter_count"
    }
    
    enum ImplicitlyUnwrappedOptional {
        static let disableComment = "//swiftlint:disable implicitly_unwrapped_optional"
        static let enableComment = "//swiftlint:enable implicitly_unwrapped_optional"
    }
    
    enum WeakDelegate {
        static let disableThisComment = "//swiftlint:disable:this weak_delegate"
    }

}
