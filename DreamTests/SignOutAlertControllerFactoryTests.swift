//
//  SignOutAlertControllerFactoryTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/15/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class SignOutAlertControllerFactoryTests: XCTestCase {
    
    var factory: SignOutAlertControllerFactory!
    var authenticationController: AuthenticationController!
    var keychain: MockKeychainProtocol!
    var application: MockUIApplication!

    override func setUp() {
        super.setUp()
        keychain = MockKeychainProtocol()
        authenticationController = AuthenticationController(keychain: keychain)
        application = MockUIApplication()
        factory = SignOutAlertControllerFactory(authenticationController: authenticationController, application: application)
    }
    
    func testSignOut() {
        authenticationController.persist(token: RFC6750BearerToken.create())
        factory.signOut()
        XCTAssertNil(authenticationController.extract())
        XCTAssert(application.keyWindow?.rootViewController is AuthNavigationController)
    }
    
}
