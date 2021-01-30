//
//  TypedTranslations.swift
//  be.chronux.typedTranslations
//
//  Created by Bram Huenaerts on 13/03/2020.
//  Copyright © 2020 chronux bv. All rights reserved.
//

import Foundation

class TypedTranslations {

    struct Translation {
        let key: String
        let value: String
    }

    typealias TranslationKeys = [Translation]

    func parseTranslationsKeys(from fileContent: String) throws -> [Translation] {
        let lines = fileContent.split(separator: "\n")

        var keys = TranslationKeys()
        for line in lines {
            // Skip the lines with comments
            guard !line.starts(with: "/") else { continue }
            let lineParts = line.split(separator: "=")
            // Make sure we have two parts (key and value)
            guard lineParts.count == 2 else { continue }
            let trimmedKey = lineParts[0].trimmingCharacters(in: .whitespacesAndNewlines)
            // Remove the " character because we are only interested in the key
            let key = trimmedKey.replacingOccurrences(of: "\"", with: "")
            let value = lineParts[1].replacingOccurrences(of: "\"", with: "").dropFirst().dropLast()
            keys.append(Translation(key: key, value: String(value)))
        }

        return keys
    }

    func generateCodeFile(translations: TranslationKeys, from stringsFileName: String) -> String {
        var codeGenerator = TranslationConstantsGenerator()
        codeGenerator.writeHeader(stringsfileName: stringsFileName)
        codeGenerator.writeStringExtension(tableName: getTableName(from: stringsFileName))
        codeGenerator.writeContainingNamespaceStart()
        for translation in translations {
            let propertyName = translation.key.lowercasingFirst
            codeGenerator.writeTranslationKeyLine(translation: translation, propertyName: propertyName)
        }
        codeGenerator.writeContainingNamespaceEnd()

        return codeGenerator.buffer
    }

    func readFile(fileName: String) throws -> String {
        let currentDirectory = FileManager.default.currentDirectoryPath
        let filePath = "\(currentDirectory)/\(fileName)"
        return try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
    }

    func writeFile(buffer: String, fileName: String) throws {
        let currentDirectory = FileManager.default.currentDirectoryPath
        let filePath = "\(currentDirectory)/\(fileName)"
        try buffer.write(to: URL(fileURLWithPath: filePath), atomically: false, encoding: .utf8)
    }

    private func getTableName(from stringsFileName: String) -> String {
        if let lastSlashIndex = stringsFileName.lastIndex(of: "/") {
            return stringsFileName.suffix(from: lastSlashIndex).dropFirst().replacingOccurrences(of: ".strings", with: "")
        }
        return stringsFileName.replacingOccurrences(of: ".strings", with: "")
    }
}
