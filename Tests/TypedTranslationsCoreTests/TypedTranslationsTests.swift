//
//  Strings+CamelCaseTests.swift
//  be.chronux.typedtranslations
//
//  Created by Bram Huenaerts on 19/06/2020.
//

import XCTest
@testable import TypedTranslationsCore

class TypedTranslationsTests: XCTestCase {
    func testParseTranslationsKeys() throws {

        let fileContent = """
        "cancel" = "Cancel";
        "next" = "Next";
        "previous" = "Previous";
        "loading" = "Loading";
        "close" = "Close";
        """

        let translations = try TypedTranslations().parseTranslationsKeys(from: fileContent)

        XCTAssertEqual(translations.count, 5)
    }
}
