//
//  UserParserTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/18/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class UserParserTests: XCTestCase {
    
    var parser: UserParser!
    
    override func setUp() {
        super.setUp()
        parser = UserParser()
    }
    
    func test_parse_whenAllTheRequiredFieldsArePresent_itReturnsAUser() {
        let actual = parser.parse(from: fixture(name: "user"))
        let expected = User.create()
        XCTAssertEqual(actual, expected)
    }
    
    func test_parse_whenAnyOfTheRequiredFieldsIsMissing_itReturnsNil() {
        XCTAssertNil(parser.parse(from: [:]))
    }

}
