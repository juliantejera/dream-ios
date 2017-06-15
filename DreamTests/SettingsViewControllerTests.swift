//
//  SettingsViewControllerTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/15/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class SettingsViewControllerTests: XCTestCase {
    
    var controller: SettingsViewController!
    var authenticationController: AuthenticationController!
    var keychain: MockKeychainProtocol!
    var application: MockUIApplication!
    
    override func setUp() {
        super.setUp()
        keychain = MockKeychainProtocol()
        authenticationController = AuthenticationController(keychain: keychain)
        application = MockUIApplication()
        controller = createSettingsViewController()
        controller.authenticationController = authenticationController
        controller.application = application
        controller.loadView()
    }
    
    func createSettingsViewController() -> SettingsViewController {
        return UIStoryboard.settings.instantiateViewController()
    }
    
    func testTableViewDelegate() {
        let actual = controller.tableView.delegate
        let expected = controller
        JTAssertIdentical(actual, expected)
    }
    
    func testTableViewDataSource() {
        let actual = controller.tableView.dataSource
        let expected = controller
        JTAssertIdentical(actual, expected)
    }
    
    func testTableViewNumberOfRowsInSection() {
        let actual = controller.tableView(controller.tableView, numberOfRowsInSection: 0)
        let expected = SettingsItem.count
        XCTAssertEqual(actual, expected)
    }
    
    func testCellForRowAtIndexPath_whenSignOutSettingsItem_itConfiguresTheCell() {
        let settingsItem = SettingsItem.signOut
        let indexPath = IndexPath(row: settingsItem.rawValue, section: 0)
        let cell = controller.tableView(controller.tableView, cellForRowAt: indexPath) as? SettingsItemTableViewCell
        XCTAssertEqual(cell?.textLabel?.text, settingsItem.title)
    }
    
    func testTableViewDidSelectRow_whenTheSignOutSettingsItemIsSelected_itSignsOutTheUser() {
        let settingsItem = SettingsItem.signOut
        let indexPath = IndexPath(row: settingsItem.rawValue, section: 0)
        authenticationController.persist(token: RFC6750BearerToken.create())
        controller.tableView(controller.tableView, didSelectRowAt: indexPath)
        
        XCTAssertNil(authenticationController.extract())
        XCTAssert(application.keyWindow?.rootViewController is AuthNavigationController)
    }

}
