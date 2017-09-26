//
//  UserNetworkManagerTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/18/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class UserNetworkManagerTests: XCTestCase {
    
    var manager: UserNetworkManager!
    var client: MockNetworkClient!
    
    override func setUp() {
        super.setUp()
        client = MockNetworkClient()
        manager = UserNetworkManager(client: client)
    }
    
    func test_findAll_whenTheRequestSucceeds_itReturnsUsers() throws {
        client.response = try jsonData(from: "user_network_manager_find_all_success")
        
        manager.findAll(limit: 2, radius: 100) { (result) in
            switch result {
            case .success(let users):
                XCTAssertEqual(users, [User.create(), User.create()])
            case .failure(_):
                XCTFail()
            }
        }
    }
    
    func test_findAll_whenTheRequestSucceedsButTheResponseCannotBeParsed_itFails() {
        client.response = nil
        manager.findAll(limit: 1, radius: 100) { (result) in
            JTAssertNetworkClientResultFails(result)
        }
    }
    
    func test_findAll_whenTheRequestFails() {
        client.errors = ["One error"]
        manager.findAll(limit: 1, radius: 100) { (result) in
            JTAssertNetworkClientResultFails(result)
        }
    }
    
}
