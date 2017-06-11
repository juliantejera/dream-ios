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
    
    var window: UIWindow!
    var controller: SignInTableViewController!
    var client: MockNetworkClient!
    
    override func setUp() {
        super.setUp()
        controller = UIStoryboard.auth.instantiateViewController(withIdentifier: "SignInTableViewController") as? SignInTableViewController
        window = UIWindow()
        window.makeKeyAndVisible()
        window.rootViewController = controller
        client = MockNetworkClient()
        client.response = self.fixture(name: "authentication_network_manager_sign_in_success")
        controller.manager = AuthenticationNetworkManager(client: client)
        controller.loadView()
        controller.viewDidLoad()
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
    
    func testEmailTextFieldConfiguration() {
        XCTAssertEqual(controller.emailTextField.keyboardType, .emailAddress)
        XCTAssertEqual(controller.emailTextField.returnKeyType, .next)
        JTAssertIdentical(controller.emailTextField.delegate, controller)
    }
    
    func testPasswordTextFieldConfiguration() {
        XCTAssert(controller.passwordTextField.isSecureTextEntry)
        XCTAssertEqual(controller.passwordTextField.returnKeyType, .send)
        JTAssertIdentical(controller.passwordTextField.delegate, controller)
    }
    
    func testTextFieldShouldReturnWhenTheEmailTextFieldIsTheArgumentThePasswordTextFieldBecomesTheFirstResponder() {
        let textField = MockUITextField()
        controller.passwordTextField = textField
        _ = controller.textFieldShouldReturn(controller.emailTextField)
        XCTAssertEqual(textField.didBecomeFirstResponder, 1)
    }
    
    func testSignIn_whenTheViewModelIsNotValid_ItPresentsAnAlertController() {
        controller.signIn()
        XCTAssert(controller.presentedViewController is UIAlertController)
    }
    
    func testSignIn_whenTheViewModelIsValidAndThereIsANetworkError() {
        controller.viewModel = SignInViewModel.create()
        controller.emailTextField.text = controller.viewModel.email
        controller.passwordTextField.text = controller.viewModel.password
        client.errors = ["Failure"]
        controller.signIn()
        XCTAssert(controller.presentedViewController is UIAlertController)
    }
    
    func testSignIn_whenTheViewModelIsValidAndTheNetworkRequestSucceeds() {
        controller.viewModel = SignInViewModel.create()
        controller.emailTextField.text = controller.viewModel.email
        controller.passwordTextField.text = controller.viewModel.password
        controller.signIn()
        XCTAssertNil(controller.presentedViewController)
    }
}
