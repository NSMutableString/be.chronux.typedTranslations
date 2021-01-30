//
//  File.swift
//  
//
//  Created by Bram Huenaerts on 30/01/2021.
//

import Foundation

extension String {
    var uppercasingFirst: String {
        return prefix(1).uppercased() + dropFirst()
    }

    var lowercasingFirst: String {
        return prefix(1).lowercased() + dropFirst()
    }
}
