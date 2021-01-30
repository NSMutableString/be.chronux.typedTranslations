//
//  TypedTranslationsCommand.swift
//  be.chronux.typedTranslations
//
//  Created by Bram Huenaerts on 18/06/2020.
//  Copyright © 2020 chronux bv. All rights reserved.
//

import ArgumentParser
import Foundation

public struct TypedTranslationsCommand: ParsableCommand {
    public static var configuration: CommandConfiguration = CommandConfiguration(
        commandName: "TypedTranslations",
        abstract: "Generate constants from a given .strings file",
        discussion: """
        Lightweight utility to provide typed access to your localization keys. This way, you can get rid off all the hardcoded strings.
        """,
        version: "1.0.0",
        shouldDisplay: true,
        subcommands: [],
        defaultSubcommand: nil,
        helpNames: .long)

    @Argument(help: ArgumentHelp("the strings filename"))
    public var stringsFileName: String = "en.lproj/Localizable.strings"

    public init() {}

    public func run() throws {

        let typedTranslations = TypedTranslations()
        let fileContent = try typedTranslations.readFile(fileName: stringsFileName)
        let translations = try typedTranslations.parseTranslationsKeys(from: fileContent)
        let generatedCode = typedTranslations.generateCodeFile(translations: translations, from: stringsFileName)
        try typedTranslations.writeFile(buffer: generatedCode, fileName: stringsFileName)

        print("Done generating \(translations.count) translations.")
    }
}
