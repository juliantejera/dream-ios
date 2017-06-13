//
//  AuthenticationNetworkManagerTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/12/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class AuthenticationNetworkManagerTests: XCTestCase {
    
    var manager: AuthenticationNetworkManager!
    var client: MockNetworkClient!
    private var email: String {
        return "jt@gmail.com"
    }
    override func setUp() {
        super.setUp()
        client = MockNetworkClient()
        manager = AuthenticationNetworkManager(client: client)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testForgotPasswordConfiguresParameters() throws {
        manager.forgotPassword(email: email) { (_) in
            
        }
        let expected = ["email": email, "redirect_url": "dream://"]
        let actual = try JTAssertNotNilAndUnwrap(client.parameters as? [String: String])
        XCTAssertEqual(actual, expected)
    }
    
    func testForgotPasswordWhenNetworkRequestFailsItReturnsAFailureResult() {
        manager.forgotPassword(email: email) { (result) in
            JTAssertNetworkClientResultFails(result)
        }
    }
    
    func testForgotPasswordWhenNetworkRequestSucceedsAndItCanBeParsedItReturnsASuccessResult() {
        client.response = fixture(name: "authentication_network_manager_forgot_password_success")
        manager.forgotPassword(email: email) { (result) in
            JTAssertNetworkClientResultSucceeds(result)
        }
    }
    
    func testForgotPasswordWhenNetworkRequestSucceedsAndItCannotBeParsedItReturnsAFailure() {
        client.response = fixture(name: "authentication_network_manager_forgot_password_unknown_email")
        manager.forgotPassword(email: email) { (result) in
            JTAssertNetworkClientResultFails(result)
        }
    }
    
}
