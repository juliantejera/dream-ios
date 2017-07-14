//
//  CurrentUserParserTests.swift
//  DreamTests
//
//  Created by Julian Tejera-Frias on 7/14/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class CurrentUserParserTests: XCTestCase {
    
    var parser: CurrentUserParser!
    
    override func setUp() {
        super.setUp()
        parser = CurrentUserParser() 
    }
    
    func test_parse_whenAllTheRequiredFieldsArePresent_itReturnsACurrentUser() {
        let actual = parser.parse(from: fixture(name: "current_user"))
        let expected = CurrentUser.create()
        XCTAssertEqual(actual, expected)
    }
    
    func test_parse_whenAnyOfTheRequiredFieldsIsMissing_itReturnsNil() {
        XCTAssertNil(parser.parse(from: [:]))
    }
    
}
