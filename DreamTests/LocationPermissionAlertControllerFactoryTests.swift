//
//  LocationPermissionAlertControllerFactoryTests.swift
//  DreamTests
//
//  Created by Julian Tejera-Frias on 7/12/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class LocationPermissionAlertControllerFactoryTests: XCTestCase {
    
    var factory: LocationPermissionAlertControllerFactory!
    var application: MockUIApplication!
    
    override func setUp() {
        super.setUp()
        application = MockUIApplication()
        factory = LocationPermissionAlertControllerFactory(application: application)
    }
    
    func test_openAppSettings_whenTheAppCanOpenTheUrl_itOpensTheAppSettings() {
        application.canOpenUrl = true
        factory.openAppSettings()
        let actual = application.openUrlCallCount
        let expected = 1
        XCTAssertEqual(actual, expected)
    }
    
    func test_openAppSettings_whenTheAppCannotOpenTheUrl_itDoesNotOpenTheAppSettings() {
        application.canOpenUrl = false
        factory.openAppSettings()
        let actual = application.openUrlCallCount
        let expected = 0
        XCTAssertEqual(actual, expected)
    }
}
