//
//  File.swift
//  
//
//  Created by Bram Huenaerts on 30/01/2021.
//

import Foundation

extension String {
    var uppercasingFirst: String {
        prefix(1).uppercased() + dropFirst()
    }

    var lowercasingFirst: String {
        prefix(1).lowercased() + dropFirst()
    }

    var tableName: String {
        if let lastSlashIndex = self.lastIndex(of: "/") {
            return self.suffix(from: lastSlashIndex).dropFirst().replacingOccurrences(of: ".strings", with: "")
        }
        return self.replacingOccurrences(of: ".strings", with: "")
    }

    func insensitiveCountOfOccurence(char: Character) -> Int {
        self.filter { $0 == "%" }.count
    }
}
