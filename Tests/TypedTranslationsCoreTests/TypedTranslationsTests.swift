//
//  Strings+CamelCaseTests.swift
//  be.chronux.typedtranslations
//
//  Created by Bram Huenaerts on 19/06/2020.
//

import XCTest
@testable import TypedTranslationsCore

class TypedTranslationsTests: XCTestCase {
    
    func testParseTranslationsKeys_fiveKeysSpecified_shouldReturnFiveKeys() throws {

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

    func testParseTranslationsKeys_keysSpecified_shouldReturnCorrectKeys() throws {

        let fileContent = """
        "cancel" = "Cancel";
        "NEXT" = "Next";
        "Lorem_Ipsum" = "Next";
        """

        let translation = try TypedTranslations().parseTranslationsKeys(from: fileContent)

        XCTAssertEqual(translation[0].key, "cancel")
        XCTAssertEqual(translation[1].key, "NEXT")
        XCTAssertEqual(translation[2].key, "Lorem_Ipsum")
    }

    func testParseTranslationsKeys_valuesSpecified_shouldReturnCorrectValues() throws {

        let fileContent = """
        "cancel" = "Cancel";
        "next" = "Next button";
        "Lorem_Ipsum" = "Doler %@ ipsum";
        """

        let translation = try TypedTranslations().parseTranslationsKeys(from: fileContent)

        XCTAssertEqual(translation[0].value, "Cancel")
        XCTAssertEqual(translation[1].value, "Next button")
        XCTAssertEqual(translation[2].value, "Doler %@ ipsum")
    }
}
