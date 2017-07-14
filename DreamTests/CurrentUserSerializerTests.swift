//
//  CurrentUserSerializerTests.swift
//  DreamTests
//
//  Created by Julian Tejera-Frias on 7/14/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class CurrentUserSerializerTests: XCTestCase {
    
    var serializer: CurrentUserSerializer!
    
    override func setUp() {
        super.setUp()
        serializer = CurrentUserSerializer()
    }
    
    func test_serialize() {
        let user = CurrentUser.create()
        let actual = serializer.serialize(from: user).description
        let expected = (["user": ["latitude": user.latitude, "longitude": user.longitude]]).description
        XCTAssertEqual(actual, expected)
    }
}
