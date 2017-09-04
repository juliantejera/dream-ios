//
//  UsersViewControllerTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/18/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class UsersViewControllerTests: XCTestCase {
    
    var window: UIWindow?
    var controller: UsersViewController!
    var client: MockNetworkClient!
    var userNetworkManager: UserNetworkManager!

    override func setUp() {
        super.setUp()
        controller = createUsersViewController()
        client = MockNetworkClient()
        client.response = arrayFixture(name: "user_network_manager_find_all_success")
        userNetworkManager = UserNetworkManager(client: client)
        controller.userNetworkManager = userNetworkManager
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = controller
        controller.loadView()
    }
    
    private func createUsersViewController() -> UsersViewController {
        return UIStoryboard.users.instantiateViewController()
    }
    
    func test_collectionView_alwaysBouncesVertically() {
        XCTAssert(controller.collectionView.alwaysBounceVertical)
    }
    
    func test_collectionView_hasARefreshControl() {
        XCTAssertNotNil(controller.collectionView.refreshControl)
    }
    
    func test_fetchUsers_whenTheRequestSucceeds_itUpdatesTheUsers() {
        controller.fetchUsers()
        let actual = controller.users
        let expected = [User.create(), User.create()]
        XCTAssertEqual(actual, expected)
    }
    
    func test_fetchUsers_whenTheRequestFails_itPresentsAnAlertControler() {
        client.errors = ["Failure"]
        controller.fetchUsers()
        XCTAssert(controller.presentedViewController is UIAlertController)
    }
    
    func test_fetchUsers_whenTheRequestIsInProgress_itAnimatesTheActivityIndicatorView() {
        client.onRequest = {
            XCTAssert(self.controller.activityIndicatorView.isAnimating)
        }
        controller.fetchUsers()
        XCTAssertFalse(controller.activityIndicatorView.isAnimating)
    }
    
    func test_collectionViewNumberOfItemsInSection() {
        let actual = controller.collectionView(controller.collectionView, numberOfItemsInSection: 0)
        let expected = controller.users.count
        XCTAssertEqual(actual, expected)
    }
    
    func test_collectionViewCellForItemAtIndexPath_configuresCell() throws {
        
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = try JTAssertNotNilAndUnwrap(controller.collectionView(controller.collectionView, cellForItemAt: indexPath) as? UserCollectionViewCell)
        
        let user = controller.users[indexPath.item]
        let formatter = LengthFormatter()
        XCTAssertEqual(cell.distanceLabel.text, formatter.string(fromValue: user.distance, unit: .mile))
    }
    
}

