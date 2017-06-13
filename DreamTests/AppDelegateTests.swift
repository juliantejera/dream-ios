//
//  AppDelegateTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/13/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class AppDelegateTests: XCTestCase {
    
    var appDelegate: AppDelegate!
    var authenticationController: AuthenticationController!
    var keychain: MockKeychainProtocol!
    var window: UIWindow!

    override func setUp() {
        super.setUp()
        keychain = MockKeychainProtocol()
        authenticationController = AuthenticationController(keychain: keychain)
        window = UIWindow()
        appDelegate = AppDelegate(authenticationController: authenticationController)
        appDelegate.window = window
    }
    
    func testWindowsRootViewControllerWhenTheUserIsSignedInItPresentsTheHomeViewController() {
        authenticationController.persist(token: RFC6750BearerToken.create())
        _ = appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        XCTAssert(appDelegate.window?.rootViewController is HomeViewController)
    }
    
    func testWindowsRootViewControllerWhenTheUserIsNotSignedInItPresentsTheAuthNavigationController() {
        _ = appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        XCTAssert(appDelegate.window?.rootViewController is UINavigationController)
    }
    
}
