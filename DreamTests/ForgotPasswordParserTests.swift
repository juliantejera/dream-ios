//
//  ForgotPasswordParserTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/12/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class ForgotPasswordParserTests: XCTestCase {
    
    var parser: ForgotPasswordParser!
    
    override func setUp() {
        super.setUp()
        parser = ForgotPasswordParser()
    }
    
    func testParseWhenAllTheRequiredFieldsArePresent() {
        let dictionary = fixture(name: "authentication_network_manager_forgot_password_success")
        let actual = parser.parse(from: dictionary)
        let expected = dictionary["message"] as? String
        XCTAssertEqual(actual, expected)

    }
    
    func testParseWhenAnyOfTheRequiredFieldsAreMissing() {
        XCTAssertNil(parser.parse(from: fixture(name: "authentication_network_manager_forgot_password_unknown_email")))
    }
    
}
