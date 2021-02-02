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

    /// Step 1: read the strings file and return a file content
    func readFile(fileName: String) throws -> String {
        let currentDirectory = FileManager.default.currentDirectoryPath
        let filePath = "\(currentDirectory)/\(fileName)"
        return try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
    }

    /// Step 2: parse the the translation keys and value from the given file content
    func parseTranslationsKeys(from fileContent: String) throws -> [Translation] {
        let lines = fileContent.split(separator: "\n")

        var keys = TranslationKeys()
        for line in lines {
            // Skip the lines with comments and not starting with "
            guard !line.starts(with: "/") && line.starts(with: "\"") else { continue }
            let lineParts = line.split(separator: "=")
            // Make sure we have at least two parts (key and value)
            guard lineParts.count >= 2 else { continue }
            let trimmedKey = lineParts[0].trimmingCharacters(in: .whitespacesAndNewlines)
            // Remove the " character because we are only interested in the key
            let key = trimmedKey.removeDoubleQuotes()
            let value = lineParts.dropFirst().joined(separator: "=").removeDoubleQuotes().dropFirst().dropLast()
            keys.append(Translation(key: key, value: String(value)))
        }

        return keys
    }

    /// Step 3: generate elegant swift code from the given translations
    func generateCodeFile(translations: TranslationKeys, from stringsFileName: String) -> String {
        var codeGenerator = TranslationConstantsGenerator()
        codeGenerator.writeHeader(stringsfileName: stringsFileName)
        codeGenerator.writeStringExtension(tableName: stringsFileName.tableName)
        codeGenerator.writeContainingNamespaceStart()
        for translation in translations {
            if translation.value.insensitiveCountOfOccurence(char: "%") == 0 {
                let propertyName = translation.key.lowercasingFirst.removeNotSupportedCharacters()
                codeGenerator.writeTranslationConstant(translation: translation, propertyName: propertyName)
            } else {
                let methodName = translation.key.lowercasingFirst.removeNotSupportedCharacters()
                codeGenerator.writeTranslationMethod(translation: translation, methodName: methodName)
            }

        }
        codeGenerator.writeContainingNamespaceEnd()

        return codeGenerator.buffer
    }

    /// Step 4: write the generated code to a file
    func writeFile(buffer: String, fileName: String) throws {
        let currentDirectory = FileManager.default.currentDirectoryPath
        let filePath = "\(currentDirectory)/\(fileName)"
        try buffer.write(to: URL(fileURLWithPath: filePath), atomically: false, encoding: .utf8)
    }
}
