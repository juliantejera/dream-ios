
//
//  HomeAuthTableViewControllerTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/13/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class HomeAuthTableViewControllerTests: XCTestCase {
    
    var window: UIWindow!
    var controller: HomeAuthTableViewController!
    var navigationController: MockUINavigationController!
    
    override func setUp() {
        super.setUp()
        controller = AuthStoryboardFactory.homeAuthTableViewController
        navigationController = MockUINavigationController(rootViewController: controller)
        window = UIWindow()
        window.makeKeyAndVisible()
        window.rootViewController = navigationController
        controller.loadView()
    }
    
    func testPrepareForRegisterAccountTableViewControllerSegue() {
        let destination = AuthStoryboardFactory.registerAccountTableViewController
        let segue = UIStoryboardSegue(identifier: HomeAuthTableViewController.Segues.registerAccountTableViewController, source: controller, destination: destination)
        controller.prepare(for: segue, sender: nil)
        JTAssertIdentical(destination.delegate, controller)
    }
    
    func testPrepareForSignInTableViewControllerSegue() {
        let destination = AuthStoryboardFactory.signInTableViewController
        let segue = UIStoryboardSegue(identifier: HomeAuthTableViewController.Segues.signInTableViewController, source: controller, destination: destination)
        controller.prepare(for: segue, sender: nil)
        JTAssertIdentical(destination.delegate, controller)
    }

}
