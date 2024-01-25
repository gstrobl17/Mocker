//
//  firstDifferenceBetweenStrings.swift
//  MockerTests
//
//  Created by Greg Strobl on 1/25/24.
//  Copyright © 2024 Goodman Productions. All rights reserved.
//

// Adpated from https://gist.github.com/kristopherjohnson/543687c763cd6e524c91

import Foundation

/// Find first differing character between two strings
///
/// :param: s1 First String
/// :param: s2 Second String
///
/// :returns: .DifferenceAtIndex(i) or .NoDifference
public func firstDifferenceBetweenStrings(s1: String, s2: String) -> FirstDifferenceResult {
    let len1 = s1.count
    let len2 = s2.count
    
    let lenMin = min(len1, len2)
    
    for i in 0..<lenMin {
        if s1[i] != s2[i] { //swiftlint:disable:this for_where
            return .DifferenceAtIndex(i)
        }
    }
    
    if len1 < len2 {
        return .DifferenceAtIndex(len1)
    }

    if len2 < len1 {
        return .DifferenceAtIndex(len2)
    }

    return .NoDifference
}

/// Create a formatted String representation of difference between strings
///
/// :param: s1 First string
/// :param: s2 Second string
///
/// :returns: a string, possibly containing significant whitespace and newlines
public func prettyFirstDifferenceBetweenStrings(s1: String, s2: String) -> String {
    let firstDifferenceResult = firstDifferenceBetweenStrings(s1: s1, s2: s2)
    return prettyDescriptionOfFirstDifferenceResult(firstDifferenceResult: firstDifferenceResult, s1: s1, s2: s2)
}

/// Create a formatted String representation of a FirstDifferenceResult for two strings
///
/// :param: firstDifferenceResult FirstDifferenceResult
/// :param: s1 First string used in generation of firstDifferenceResult
/// :param: s2 Second string used in generation of firstDifferenceResult
///
/// :returns: a printable string, possibly containing significant whitespace and newlines
public func prettyDescriptionOfFirstDifferenceResult(firstDifferenceResult: FirstDifferenceResult, s1: String, s2: String) -> String {

    func indexPathForDifference(index: Int, s: String) -> IndexPath {
        var column = 1
        var line = 1
        
        for i in 0..<index {
            if s[i] == "\n" {
                column = 1
                line += 1
            } else {
                column += 1
            }
        }
        
        return IndexPath(item: column, section: line)
    }
    
    func diffString(index: Int, s1: String, s2: String) -> String {
        let markerArrow = "\u{2b06}"  // "⬆"
        let ellipsis    = "\u{2026}"  // "…"

        /// Given a string and a range, return a string representing that substring.
        ///
        /// If the range starts at a position other than 0, an ellipsis
        /// will be included at the beginning.
        ///
        /// If the range ends before the actual end of the string,
        /// an ellipsis is added at the end.
        func windowSubstring(s: String, range: NSRange) -> String {
            let validRange = NSMakeRange(range.location, min(range.length, s.count - range.location))   //swiftlint:disable:this legacy_constructor
            let substring = s[Range(validRange, in: s)!]                                //swiftlint:disable:this force_unwrapping

            let prefix = range.location > 0 ? ellipsis : ""
            let suffix = (s.count - range.location > range.length) ? ellipsis : ""

            return "\(prefix)\(substring)\(suffix)"
        }

        // Show this many characters before and after the first difference
        let windowPrefixLength = 10
        let windowSuffixLength = 10
        let windowLength = windowPrefixLength + 1 + windowSuffixLength

        let windowIndex = max(index - windowPrefixLength, 0)
        let windowRange = NSMakeRange(windowIndex, windowLength)    //swiftlint:disable:this legacy_constructor

        let sub1 = windowSubstring(s: s1, range: windowRange)
        let sub2 = windowSubstring(s: s2, range: windowRange)

        let markerPosition = min(windowSuffixLength, index) + (windowIndex > 0 ? 1 : 0)

        let markerPrefix = String(repeating: " ", count: markerPosition)
        let markerLine = "\(markerPrefix)\(markerArrow)"

        let indexPath = indexPathForDifference(index: index, s: s1)
        
        return "Difference at index \(index) [line:\(indexPath.section), column:\(indexPath.item)]:\n\(sub1)\n\(sub2)\n\(markerLine)"
    }

    switch firstDifferenceResult {
    case .NoDifference:                 return "No difference"                              //swiftlint:disable:this switch_case_on_newline
    case .DifferenceAtIndex(let index): return diffString(index: index, s1: s1, s2: s2)     //swiftlint:disable:this switch_case_on_newline
    }
}

/// Result type for firstDifferenceBetweenStrings()
public enum FirstDifferenceResult {
    /// Strings are identical
    case NoDifference

    /// Strings differ at the specified index.
    ///
    /// This could mean that characters at the specified index are different,
    /// or that one string is longer than the other
    case DifferenceAtIndex(Int)
}

extension FirstDifferenceResult: CustomStringConvertible, CustomDebugStringConvertible {
    /// Textual representation of a FirstDifferenceResult
    public var description: String {
        switch self {
        case .NoDifference:
            return "NoDifference"
        case .DifferenceAtIndex(let index):
            return "DifferenceAtIndex(\(index))"
        }
    }

    /// Textual representation of a FirstDifferenceResult for debugging purposes
    public var debugDescription: String {
        self.description
    }
}
