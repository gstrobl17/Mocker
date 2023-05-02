//
//  String+Extensions.swift
//  Mocker
//
//  Created by Greg on 2/28/18.
//

import Foundation

extension String {
    
    func index(of string: String, options: CompareOptions = .literal) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    
    func endIndex(of string: String, options: CompareOptions = .literal) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
    
    var firstLowercased: String {
        guard let first = first else { return "" }
        return String(first).lowercased() + dropFirst()
    }

    func replacedAngleEnclosed(value: String, with startingReplacement: String, and endingReplacement: String) -> String {
        var source = self
        
        let startAngle: Character = "<"
        let endAngle: Character = ">"
        let start = value + String(startAngle)
        
        // Find the next instance of the value
        while let startIndex = source.index(of: start), let endIndex = source.endIndex(of: start) {

            // Find the matching closing angle for the current instance
            var depth = 0
            var current = endIndex
            var indexOfClosingAngle: String.Index?
            
            while source.distance(from: current, to: source.endIndex) > 0 {
                let character = source[current]
                if character == startAngle {
                    depth += 1
                }
                if character == endAngle {
                    if depth == 0 {
                        indexOfClosingAngle = current
                        break
                    }
                    depth -= 1
                }
                current = source.index(after: current)
            }
            
            if let indexOfClosingAngle = indexOfClosingAngle {
                // Start and close found. Replace text in string.
                let startRange = startIndex..<endIndex
                let endRange = indexOfClosingAngle..<index(indexOfClosingAngle, offsetBy: 1)
                source.replaceSubrange(endRange, with: endingReplacement)
                source.replaceSubrange(startRange, with: startingReplacement)
            } else {
                // Replace able value< > instance not found. Exit.
                break
            }
        }
        
        return source
    }
    
    func replacedAngleEnclosedSyntax() -> String {
        var string = self
        if string.contains("protocol<") {
            string = string.replacingOccurrences(of: ", ", with: " & ")
        }
        string = string.replacedAngleEnclosed(value: "Type", with: "", and: ".Type")
        string = string.replacedAngleEnclosed(value: "protocol", with: "(", and: ")")
        string = string.replacedAngleEnclosed(value: "Array", with: "[", and: "]")
        if string.contains("Dictionary<") {
            string = string.replacedAngleEnclosed(value: "Dictionary", with: "[", and: "]").replacingOccurrences(of: ",", with: ":")
        }
        string = string.replacedAngleEnclosed(value: "Optional", with: "", and: "?")
        return string
    }
    
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
}
