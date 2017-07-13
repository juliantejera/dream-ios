//
//  LocationObserverDelegate.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 7/8/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationObserverDelegate: class {
    func locationObserver(_ observer: LocationObserver, didUpdateLocation location: CLLocation)
    func locationObserver(_ observer: LocationObserver, didFailWithError error: Error)
}
