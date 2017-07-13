//
//  MockLocationManagerProtocol.swift
//  DreamTests
//
//  Created by Julian Tejera-Frias on 7/11/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
import CoreLocation
@testable import Dream

class MockLocationManager: LocationManagerProtocol {
    
    weak var delegate: CLLocationManagerDelegate?
    var desiredAccuracy: CLLocationAccuracy = 0
    var distanceFilter: CLLocationDistance = 0
    
    var requestWhenInUseAuthorizationCallCount = 0
    func requestWhenInUseAuthorization() {
        requestWhenInUseAuthorizationCallCount += 1
    }
    
    var requestLocationCallCount = 0
    func requestLocation() {
        requestLocationCallCount += 1
    }
    
    static var authorizationStatusStub: CLAuthorizationStatus = .notDetermined
    static func authorizationStatus() -> CLAuthorizationStatus {
        return authorizationStatusStub
    }
}
