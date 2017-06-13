//
//  SignInTableViewControllerSectionsTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/1/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream
class SignInTableViewControllerSectionsTests: XCTestCase {
    
    func testCount() {
        let actual = 2
        let expected = SignInTableViewControllerSections.count
        XCTAssertEqual(actual, expected)
    }
    
    func testNumberOfRowsForCredentials() {
        let actual = 2
        let expected = SignInTableViewControllerSections.credentials.numberOfRows
        XCTAssertEqual(actual, expected)
    }
    
    func testNumberOfRowsForSignIn() {
        let actual = 2
        let expected = SignInTableViewControllerSections.signIn.numberOfRows
        XCTAssertEqual(actual, expected)
    }
    
}
