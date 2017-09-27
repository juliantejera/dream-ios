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
    
    func test_persistToken_whenItSucceeds() throws {
        let token = RFC6750BearerToken.create()
        authenticationController.persist(token: token)
        let actual = keychain.attributes[AuthenticationController.Keys.token]
        let expected = try JSONEncoder().encode(token)
        XCTAssertEqual(actual, expected)
    }
    
    func test_persistToken_whenItFails() {
        keychain.state = .failure
        authenticationController.persist(token: RFC6750BearerToken.create())
        XCTAssertNil(keychain.attributes[AuthenticationController.Keys.token])
    }
    
    func test_extractToken_whenItSucceeds() {
        let expected = RFC6750BearerToken.create()
        authenticationController.persist(token: expected)
        let actual = authenticationController.extractToken()
        XCTAssertEqual(actual, expected)
    }
    
    func test_extractToken_whenThereIsntAPersistedToken() {
        XCTAssertNil(authenticationController.extractToken())
    }
    
    func test_extractToken_whenThereIsAKeychainError() {
        let expected = RFC6750BearerToken.create()
        authenticationController.persist(token: expected)
        keychain.state = .failure
        XCTAssertNil(authenticationController.extractToken())
    }
    
    func test_removeToken_whenItSucceeds() {
        authenticationController.persist(token: RFC6750BearerToken.create())
        authenticationController.removeToken()
        XCTAssertNil(authenticationController.extractToken())
    }
    
    func test_removeToken_whenItFails() {
        let expected = RFC6750BearerToken.create()
        authenticationController.persist(token: expected)
        keychain.state = .failure
        authenticationController.removeToken()
        keychain.state = .none
        let actual = authenticationController.extractToken()
        XCTAssertEqual(actual, expected)
    }
    
    func test_persistCurrentUser_savesToUserDefaults() {
        let user = CurrentUser.create()
        authenticationController.persist(user: user)
        let dictionary = UserDefaults.standard.value(forKey: AuthenticationController.Keys.currentUser)
        XCTAssertNotNil(dictionary)
    }
    
    func test_extractCurrentUser_whenTheresAPersistedUser_itReturnsIt() {
        let user = CurrentUser.create()
        authenticationController.persist(user: user)
        let extractedUser = authenticationController.extractUser()
        XCTAssertEqual(extractedUser, user)
    }
    
    func test_extractCurrentUser_whenThereIsNotAPersistedUser_itReturnsNil() {
        UserDefaults.standard.set(nil, forKey: AuthenticationController.Keys.currentUser)
        XCTAssertNil(authenticationController.extractUser())
    }
    
    func test_removeUser() {
        let user = CurrentUser.create()
        authenticationController.persist(user: user)
        authenticationController.removeUser()
        XCTAssertNil(authenticationController.extractUser())
    }
}
