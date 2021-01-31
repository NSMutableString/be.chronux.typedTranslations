//
//  CodeGenerator.swift
//  be.chronux.typedTranslations
//
//  Created by Bram Huenaerts on 13/03/2020.
//  Copyright © 2020 chronux bv. All rights reserved.
//

import Foundation

protocol CodeGenerator {
    mutating func writeHeader(stringsfileName: String)
    mutating func writeStringExtension(tableName: String)
    mutating func writeContainingNamespaceStart()
    mutating func writeTranslationKeyLine(translation: TypedTranslations.Translation, propertyName: String)
    mutating func writeContainingNamespaceEnd()
}

struct TranslationConstantsGenerator: CodeGenerator {

    var buffer: String

    init() {
        buffer = ""
    }

    mutating func writeHeader(stringsfileName: String) {
        buffer.append("//\n")
        buffer.append("//  Localizations.swift\n")
        buffer.append("//\n")
        buffer.append("//  Generated code that contains the available keys from \(stringsfileName)\n")
        buffer.append("//  Copyright © 2020. All rights reserved.\n")
        buffer.append("//\n")
        buffer.append("\n")
        buffer.append("import Foundation\n")
        buffer.append("\n")
    }

    mutating func writeStringExtension(tableName: String) {
        buffer.append("extension String {\n")
        buffer.append("\tfunc localized(bundle: Bundle = .main, tableName: String = \"\(tableName)\") -> String {\n")
        buffer.append("\t\treturn NSLocalizedString(self, tableName: tableName, bundle: bundle, value: self, comment: \"\")\n")
        buffer.append("\t}\n")
        buffer.append("}\n")
        buffer.append("\n")
    }

    mutating func writeContainingNamespaceStart() {
        buffer.append("struct Localizations {\n")
        buffer.append("\n")
        buffer.append("\tprivate init() {}\n")
        buffer.append("\n")
    }

    mutating func writeTranslationKeyLine(translation: TypedTranslations.Translation, propertyName: String) {
        buffer.append("\t/// Base translation: \(translation.value)\n")
        buffer.append("\tstatic let " + propertyName + " = \"" +  translation.key + "\".localized()\n")
    }

    mutating func writeContainingNamespaceEnd() {
        buffer.append("}\n")
    }
}
