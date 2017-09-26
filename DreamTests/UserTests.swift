//
//  UserTests.swift
//  DreamTests
//
//  Created by Julian Tejera-Frias on 9/21/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class UserTests: XCTestCase {
    
    func test_codable_whenTheDataIsValid_itInstantiatesAnUser() throws {
        let data = try jsonData(from: "user")
        let actual = try JSONDecoder().decode(User.self, from: data)
        let expected: User = .create()
        XCTAssertEqual(actual, expected)
    }
    
}
