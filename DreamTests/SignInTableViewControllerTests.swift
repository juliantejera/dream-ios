//
//  SignInTableViewControllerTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/1/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class SignInTableViewControllerTests: XCTestCase {
    
    var controller: SignInTableViewController!
    
    override func setUp() {
        super.setUp()
        controller = UIStoryboard.auth.instantiateViewController(withIdentifier: "SignInTableViewController") as? SignInTableViewController
    }
    
    func testTableViewKeyboardDismissMode() {
        let actual = controller.tableView.keyboardDismissMode
        let expected = UIScrollViewKeyboardDismissMode.onDrag
        XCTAssertEqual(actual, expected)
    }
    
    func testTableViewNumberOfSections() {
        let actual = controller.numberOfSections(in: controller.tableView)
        let expected = SignInTableViewControllerSections.count
        XCTAssertEqual(actual, expected)
    }
    
    func testTableViewNumberOfRowsForCredentialsSection() {
        let actual = controller.tableView(controller.tableView, numberOfRowsInSection: 0)
        let expected = SignInTableViewControllerSections.credentials.numberOfRows
        XCTAssertEqual(actual, expected)
    }
    
    func testTableViewNumberOfRowsForSignInSection() {
        let actual = controller.tableView(controller.tableView, numberOfRowsInSection: 1)
        let expected = SignInTableViewControllerSections.signIn.numberOfRows
        XCTAssertEqual(actual, expected)
    }
    
}
