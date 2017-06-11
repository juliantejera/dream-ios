//
//  RFC6750BearerTokenSerializerTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/7/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class RFC6750BearerTokenSerializerTests: XCTestCase {
    
    func testSerialize() throws {
        let viewModel = RFC6750BearerToken.create()
        let actual = try JTAssertNotNilAndUnwrap(RFC6750BearerTokenSerializer().serialize(from: viewModel) as? [String: String])
        let expected = try JTAssertNotNilAndUnwrap(fixture(name: "bearer_token") as? [String: String])
        XCTAssertEqual(actual, expected)
    }
    
}
