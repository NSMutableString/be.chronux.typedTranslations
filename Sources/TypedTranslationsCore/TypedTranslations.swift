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
    }

    typealias TranslationKeys = [Translation]

    private func parseLocalizationFile(name: String) throws -> TranslationKeys {
        let fileContent = try readFile(name: name)
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
            keys.append(Translation(key: key))
        }

        return keys
    }

    private func readFile(name: String) throws -> String {
        let currentDirectory = FileManager.default.currentDirectoryPath
        let filePath = "\(currentDirectory)/en.lproj/\(name)"
        return try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
    }

    private func writeFile(buffer: String, fileName: String) throws {
        let currentDirectory = FileManager.default.currentDirectoryPath
        let filePath = "\(currentDirectory)/\(fileName)"
        try buffer.write(to: URL(fileURLWithPath: filePath), atomically: false, encoding: .utf8)
    }

    func generateTranslationKeys(name: String) throws -> TranslationKeys {
        let translations = try parseLocalizationFile(name: name)

        var codeGenerator = TranslationConstantsGenerator()
        codeGenerator.writeHeader(name: name)
        codeGenerator.writeStringExtension(name: name)
        codeGenerator.writeContainingNamespaceStart()
        for translation in translations {
            let propertyName = translation.key
            codeGenerator.writeTranslationKeyLine(key: translation.key, propertyName: propertyName)
        }
        codeGenerator.writeContainingNamespaceEnd()

        try writeFile(buffer: codeGenerator.buffer, fileName: "Translations.swift")

        return translations
    }
}
