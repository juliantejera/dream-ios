//
//  MockLocationObserverDelegate.swift
//  DreamTests
//
//  Created by Julian Tejera-Frias on 7/11/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
import CoreLocation
@testable import Dream

class MockLocationObserverDelegate: LocationObserverDelegate {
    
    var location: CLLocation?
    func locationObserver(_ observer: LocationObserver, didUpdateLocation location: CLLocation) {
        self.location = location
    }
    
    var error: Error?
    func locationObserver(_ observer: LocationObserver, didFailWithError error: Error) {
        self.error = error
    }
    
}
