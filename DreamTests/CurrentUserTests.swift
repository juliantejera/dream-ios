//
//  CurrentUserTests.swift
//  DreamTests
//
//  Created by Julian Tejera-Frias on 7/14/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Dream

class CurrentUserTests: XCTestCase {
    
    var user: CurrentUser!
    
    override func setUp() {
        super.setUp()
        user = CurrentUser.create()
    }
    
    func test_updateCoordinates() {
        let location = CLLocation(latitude: 10, longitude: 20)
        user.update(location: location)
        XCTAssertEqual(user.latitude, location.coordinate.latitude)
        XCTAssertEqual(user.longitude, location.coordinate.longitude)
    }
    
}
