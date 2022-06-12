//
//  string_utils.swift
//  aliasengine
//
//  Created by Liviu Coman on 05.06.2022.
//

import Foundation

extension String {
    
    func limitTo(width: Int32) -> String {
        let limit = Int(width) - 3
        var copy = self
        var len = copy.count
        
        while len > limit {
            copy.removeLast()
            len = copy.count
        }
        
        return copy
    }
    
    func splitWordLines(thatFitIn width: Int32) -> [String] {
        let words = self.replacingOccurrences(of: "\n", with: " ")
            .split(separator: " ")
            .map { e in
                return "\(e)"
            }
        
        var result: [String] = []
        var currentLine = "# "
        let limit = Int(width) - 3

        for word in words {
            let nextWord = "\(word) "
            let nextLimit = currentLine.count + nextWord.count
            if nextLimit < limit {
                currentLine += nextWord
            } else {
                result.append(currentLine)
                currentLine = "# "
                currentLine += nextWord
            }
        }
        
        result.append(currentLine)
        
        return result
    }
    
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    var fileName: String {
        return URL(fileURLWithPath: self).lastPathComponent
    }
    
    var deletingAllExtensions: String {
        let components = self.split(separator: ".")
        if components.count > 0 {
            return String(components[0])
        } else {
            return self
        }
    }
    
    var isAlphanumeric: Bool {
        return self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil && !isEmpty
    }
}