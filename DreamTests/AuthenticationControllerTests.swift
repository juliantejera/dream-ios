//
//  AuthenticationControllerTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/3/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class AuthenticationControllerTests: XCTestCase {
    
    var authenticationController: AuthenticationController!
    var keychain: MockKeychainProtocol!
    
    override func setUp() {
        super.setUp()
        keychain = MockKeychainProtocol()
        authenticationController = AuthenticationController(keychain: keychain)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testPersistWhenItSucceeds() throws {
        authenticationController.persist(token: RFC6750BearerToken.create())
        let actual = keychain.attributes
        let expected = try JTAssertNotNilAndUnwrap(fixture(name: "bearer_token") as? [String: String])
        XCTAssertEqual(actual, expected)
    }
    
    func testPersistWhenItFails() {
        keychain.state = .failure
        authenticationController.persist(token: RFC6750BearerToken.create())
        let actual = keychain.attributes
        let expected = [String: String]()
        XCTAssertEqual(actual, expected)
    }
    
    func testExtractWhenItSucceeds() {
        let expected = RFC6750BearerToken.create()
        authenticationController.persist(token: expected)
        let actual = authenticationController.extract()
        XCTAssertEqual(actual, expected)
    }
    
    func testExtractWhenThereIsntAPersistedToken() {
        XCTAssertNil(authenticationController.extract())
    }
    
    func testExtractWhenThereIsAKeychainError() {
        let expected = RFC6750BearerToken.create()
        authenticationController.persist(token: expected)
        keychain.state = .failure
        XCTAssertNil(authenticationController.extract())
    }
}
