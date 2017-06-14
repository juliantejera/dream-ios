//
//  ForgotPasswordTableViewControllerTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/12/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class ForgotPasswordTableViewControllerTests: XCTestCase {
    
    var window: UIWindow!
    var controller: ForgotPasswordTableViewController!
    var navigationController: MockUINavigationController!
    var client: MockNetworkClient!
    

    override func setUp() {
        super.setUp()
        controller = AuthStoryboardFactory.forgotPasswordTableViewController
        window = UIWindow()
        window.makeKeyAndVisible()
        navigationController = MockUINavigationController(rootViewController: controller)
        window.rootViewController = navigationController
        client = MockNetworkClient()
        client.response = self.fixture(name: "authentication_network_manager_forgot_password_success")
        controller.manager = AuthenticationNetworkManager(client: client)
        controller.email = "jt@gmail.com"
        controller.loadView()
        controller.viewDidLoad()
    }
    
    func testViewDidLoadConfiguresEmailTextField() {
        let actual = controller.email
        let expected = controller.emailTextField.text
        XCTAssertEqual(actual, expected)
    }
    
    func testTableViewNumberOfRowsInSection() {
        let actual = controller.tableView(controller.tableView, numberOfRowsInSection: 0)
        let expected = 1
        XCTAssertEqual(actual, expected)
    }
    
    func testEmailTextFieldConfiguration() {
        XCTAssertEqual(controller.emailTextField.keyboardType, .emailAddress)
        XCTAssertEqual(controller.emailTextField.returnKeyType, .send)
        XCTAssertEqual(controller.emailTextField.autocorrectionType, .no)
    }
    
    
    func testTextFieldDidChangeUpdatesTheViewModel() {
        let email = "jj@gmail.com"
        controller.emailTextField.text = email
        controller.textFieldDidChange(controller.emailTextField)
        XCTAssertEqual(controller.email, email)
    }
    
    func testForgotPassword_whenTheViewModelIsNotValid_ItPresentsAnAlertController() {
        controller.email = "j"
        controller.sendForgotPasswordRequest(UIBarButtonItem())
        XCTAssert(controller.presentedViewController is UIAlertController)
    }
    
    func testForgotPassword_whenTheViewModelIsValidAndThereIsANetworkError() {
        client.errors = ["Failure"]
        controller.sendForgotPasswordRequest(UIBarButtonItem())
        XCTAssert(controller.presentedViewController is UIAlertController)
    }
    
    func testForgotPassword_whenTheViewModelIsValidAndTheNetworkRequestSucceeds() throws {
        controller.sendForgotPasswordRequest(UIBarButtonItem())
        let alertController = try JTAssertNotNilAndUnwrap(controller.presentedViewController as? UIAlertController)
        XCTAssertEqual(alertController.title, "Email sent 📧")
    }
    
    func testForgotPassword_AnimatesTheActivityIndicatorView() {
        client.onRequest = {
            XCTAssert(self.controller.activityIndicatorView.isAnimating)
        }
        
        controller.sendForgotPasswordRequest(UIBarButtonItem())
        XCTAssertFalse(self.controller.activityIndicatorView.isAnimating)
    }
}
