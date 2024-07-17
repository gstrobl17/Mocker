//
//  LabeledExprListSyntax+Extensions.swift
//  Mocker
//
//  Created by Greg Strobl on 5/17/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

import SwiftSyntax

struct TargetDetail: Equatable {
    let type: String    //i.e. "target" or "testTarget"
    let name: String
}

extension LabeledExprListSyntax.Element {
    
    /// Used to extract a string value from a code like the following:
    /// ```
    /// name: "FoundationAbstractions",
    /// ```
    var stringLiteral: String? {
        guard let expression = expression.as(StringLiteralExprSyntax.self),
              expression.segments.count == 1,
              let segment = expression.segments.first?.as(StringSegmentSyntax.self) else { return nil }
        return segment.content.text
    }
    
    /// Use to extract data form a `targets` parameter in a Swift Package into an array of ``TargetDetail``
    ///
    /// The following
    /// ```
    /// targets: [
    ///     .target(
    ///         name: "FooBar"),
    ///     .testTarget(
    ///         name: "FooBarTests",
    ///         dependencies: ["FooBar"]),
    /// ]
    /// ```
    ///
    /// should be turned into
    /// ```
    /// [TargetDetail(type: "target", name: "FooBarTests"), TargetDetail(type: "testTarget", name: "FooBarTests")]
    /// ```
    var arrayOfTargetInformation: [TargetDetail] {
        var targets = [TargetDetail]()

        if let expression = expression.as(ArrayExprSyntax.self),
           let elements = expression.elements.as(ArrayElementListSyntax.self) {
            elements.forEach { element in
             
                // Look for the target type (.target or .testTarget)
                if let functionCall = element.expression.as(FunctionCallExprSyntax.self),
                   let memberAccess = functionCall.calledExpression.as(MemberAccessExprSyntax.self),
                   memberAccess.period.tokenKind == .period,
                   memberAccess.declName.baseName.text == SwiftPackageConstant.Manifest.TargetType.target || memberAccess.declName.baseName.text == SwiftPackageConstant.Manifest.TargetType.testTarget {
                    
                    let targetDetailType = memberAccess.declName.baseName.text
                    var targetDetailName: String?
                    
                    // Walk the argument list looking for the "name"
                    functionCall.arguments.forEach { argument in
                        if argument.label?.text == SwiftPackageConstant.Manifest.ArgumentName.name {
                            targetDetailName = argument.stringLiteral
                        }
                    }
                    
                    if let targetDetailName {
                        let detail = TargetDetail(type: targetDetailType, name: targetDetailName)
                        targets.append(detail)
                    }
                }
            }
        }
        
        return targets
    }
    
}
