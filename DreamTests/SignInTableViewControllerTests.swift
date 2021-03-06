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
    var delegate: MockSignInTableViewControllerDelegate!
    
    override func setUp() {
        super.setUp()
        controller = AuthStoryboardFactory.signInTableViewController
        window = UIWindow()
        window.makeKeyAndVisible()
        window.rootViewController = controller
        client = MockNetworkClient()
        client.response = try? jsonData(from: "authentication_network_manager_sign_in_success")
        controller.manager = AuthenticationNetworkManager(client: client)
        delegate = MockSignInTableViewControllerDelegate()
        controller.delegate = delegate
        controller.loadView()
        controller.viewDidLoad()
    }
    
    func testTableViewKeyboardDismissMode() {
        let actual = controller.tableView.keyboardDismissMode
        let expected = UIScrollViewKeyboardDismissMode.onDrag
        XCTAssertEqual(actual, expected)
    }
    
    func testViewWillAppearMakesTheEmailTextFieldTheFirstResponder() {
        let textField = MockUITextField()
        controller.emailTextField = textField
        controller.viewWillAppear(false)
        XCTAssertEqual(textField.didBecomeFirstResponder, 1)
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
        XCTAssertEqual(delegate.didSignIn, 0)
    }
    
    func testSignIn_whenTheViewModelIsValidAndThereIsANetworkError() {
        controller.viewModel = SignInViewModel.create()
        client.errors = ["Failure"]
        controller.signIn()
        XCTAssert(controller.presentedViewController is UIAlertController)
        XCTAssertEqual(delegate.didSignIn, 0)
    }
    
    func testSignIn_whenTheViewModelIsValidAndTheNetworkRequestSucceeds() {
        controller.viewModel = SignInViewModel.create()
        controller.signIn()
        XCTAssertEqual(delegate.didSignIn, 1)
        let user = controller.authenticationController.extractUser()
        XCTAssertNotNil(user)
    }
    
    func testSignIn_AnimatesTheActivityIndicatorView() {
        controller.viewModel = SignInViewModel.create()
        client.onRequest = {
            XCTAssert(self.controller.activityIndicatorView.isAnimating)
        }
        
        controller.signIn()
        XCTAssertFalse(self.controller.activityIndicatorView.isAnimating)
    }
        
    func testTextFieldDidChangeUpdatesTheViewModel() {
        let viewModel = SignInViewModel.create()
        controller.emailTextField.text = viewModel.email
        controller.passwordTextField.text = viewModel.password
        controller.textFieldDidChange(controller.emailTextField)
        XCTAssertEqual(controller.viewModel, viewModel)
    }

    func testForgotPasswordPerformsSegueToTheAppropriateViewController() throws {
        controller.viewModel = SignInViewModel.create()
        controller.forgotPassword()
        let forgotPasswordTableViewController = try JTAssertNotNilAndUnwrap(controller.presentedViewController as? ForgotPasswordTableViewController)
        XCTAssertEqual(forgotPasswordTableViewController.email, controller.viewModel.email)
    }
}
