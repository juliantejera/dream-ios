//
//  CurrentUserNetworkManagerTests.swift
//  DreamTests
//
//  Created by Julian Tejera-Frias on 7/14/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class CurrentUserNetworkManagerTests: XCTestCase {
    
    var manager: CurrentUserNetworkManager!
    var client: MockNetworkClient!
    var currentUser: CurrentUser!
    
    override func setUp() {
        super.setUp()
        client = MockNetworkClient()
        manager = CurrentUserNetworkManager(client: client)
        currentUser = CurrentUser.create()
    }
    
    func test_update_whenTheRequestSucceeds_itReturnsACurrentUser() throws {
        client.response = try jsonData(from: "current_user")
        manager.update(user: currentUser) { (result) in
            switch result {
            case .success(let updatedUser):
                XCTAssertEqual(updatedUser, self.currentUser)
            case .failure(_):
                XCTFail()
            }
        }
    }
    
    func test_update_whenTheRequestSucceedsButTheResponseCannotBeParsed_itFails() {
        client.response = nil
        manager.update(user: currentUser) { (result) in
            JTAssertNetworkClientResultFails(result)
        }
    }

    func test_update_whenTheRequestFails_itDoesNotReturnACurrentUser() {
        client.errors = ["One error"]
        manager.update(user: currentUser) { (result) in
            JTAssertNetworkClientResultFails(result)
        }
    }
    
}
