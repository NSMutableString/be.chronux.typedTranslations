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

    @Argument(default: "Localizable.strings", help: "the strings filename")
    public var stringsFileName: String

    public init() {}

    public func run() throws {
        let name = stringsFileName.replacingOccurrences(of: ".strings", with: "")
        let translations = try TypedTranslations().generateTranslationKeys(name: name)

        print("Done generating \(translations.count) translations.")
    }
}
