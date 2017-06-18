//
//  PhotoParserTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/17/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class PhotoParserTests: XCTestCase {
    
    var parser: PhotoParser!
    
    override func setUp() {
        super.setUp()
        parser = PhotoParser()
    }
    
    func test_parse_whenAllTheRequiredFieldsArePresent_itReturnsAPhoto() {
        let actual = parser.parse(from: fixture(name: "photo"))
        let expected = Photo.create()
        XCTAssertEqual(actual, expected)
    }
    
    func test_parse_whenAnyOfTheRequiredFieldsIsMissing_itReturnsNil() {
        XCTAssertNil(parser.parse(from: [:]))
    }
    
}
