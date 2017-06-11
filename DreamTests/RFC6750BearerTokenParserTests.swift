//
//  RFC6750BearerTokenParserTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/3/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class RFC6750BearerTokenParserTests: XCTestCase {
    
    var parser: RFC6750BearerTokenParser!
    
    override func setUp() {
        super.setUp()
        parser = RFC6750BearerTokenParser()
    }
    
    func testParseWhenAllTheRequiredFieldsArePresent() {
        let actual = parser.parse(from: fixture(name: "bearer_token"))
        let expected = RFC6750BearerToken.create()
        XCTAssertEqual(actual, expected)
    }
    
    func testParseWhenAnyOfTheRequiredFieldsAreMissing() {
        XCTAssertNil(parser.parse(from: [:]))
    }
    
}
