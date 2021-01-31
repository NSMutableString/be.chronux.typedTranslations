//
//  Strings+CamelCaseTests.swift
//  be.chronux.typedtranslations
//
//  Created by Bram Huenaerts on 19/06/2020.
//

import XCTest
@testable import TypedTranslationsCore

class StringCamelCaseTests: XCTestCase {
    
    func testUppercasingFirst_lowerCaseString_shouldReturnStringWithUppercaseFirstCharacter() throws {

        let text = "lorem Ipsum doler"

        let output = text.uppercasingFirst

        XCTAssertEqual(output, "Lorem Ipsum doler")
    }

    func testLowerCasingFirst_lowerCaseString_shouldReturnStringWithLowercaseFirstCharacter() throws {

        let text = "Lorem Ipsum doler"

        let output = text.lowercasingFirst

        XCTAssertEqual(output, "lorem Ipsum doler")
    }

    func testTableName_fileNameWithoutPathProvided_correctTableNameShouldBeReturned() throws {
        let text = "Localisable.strings"

        let output = text.tableName

        XCTAssertEqual(output, "Localisable")
    }

    func testTableName_fileNameWithPathProvided_correctTableNameShouldBeReturned() throws {
        let text = "en.lproj/Localisable.strings"

        let output = text.tableName

        XCTAssertEqual(output, "Localisable")
    }

    func testInsensitiveCountOfOccurence_scenarioWithTwo() throws {
        let text = "lorem %@ ipsum doler %@ bacon"

        let count = text.insensitiveCountOfOccurence(char: "%")

        XCTAssertEqual(count, 2)
    }

    func testRemoveNotSupportedCharacters_givenTextWithInvalidCharacter_shouldReturnTextWithoutInvalidCharacters() throws {
        let text = "🍏lorem!@#$%^&*()_+{}[]ipsumë"

        let result = text.removeNotSupportedCharacters()

        XCTAssertEqual(result, "loremipsumë")
    }
}
