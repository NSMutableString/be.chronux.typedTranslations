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
}
