//
//  LocationManagerProtocol.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 7/7/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol: class {
    weak var delegate: CLLocationManagerDelegate? { get set }
    var desiredAccuracy: CLLocationAccuracy { get set }
    var distanceFilter: CLLocationDistance { get set }
    func requestWhenInUseAuthorization()
    func requestLocation()
    func startUpdatingLocation()
    func stopUpdatingLocation()
    static func authorizationStatus() -> CLAuthorizationStatus
}

extension CLLocationManager: LocationManagerProtocol {}
