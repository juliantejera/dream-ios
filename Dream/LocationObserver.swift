//
//  LocationObserver.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 7/7/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
import CoreLocation

class LocationObserver: NSObject, CLLocationManagerDelegate {
    
    private let locationManagerType: LocationManagerProtocol.Type
    private var manager: LocationManagerProtocol?
    weak var delegate: LocationObserverDelegate?
    
    init(locationManagerType: LocationManagerProtocol.Type = CLLocationManager.self) {
        self.locationManagerType = locationManagerType
        super.init()
    }
    
    func startObserving(manager: LocationManagerProtocol) {
        self.manager = manager
        manager.delegate = self
        manager.distanceFilter = 50.0 // Meters
        manager.desiredAccuracy = kCLLocationAccuracyBest
        requestAuthorizationIfNeeded()
    }
    
    private func requestAuthorizationIfNeeded() {
        switch locationManagerType.authorizationStatus() {
        case .notDetermined:
            self.manager?.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            self.manager?.requestLocation()
        case .denied:
            delegate?.locationObserver(self, didFailWithError: LocationObserverError.locationAccessDenied)
        case .restricted:
            delegate?.locationObserver(self, didFailWithError: LocationObserverError.locationAccessRestricted)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationObserver(self, didFailWithError: error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        delegate?.locationObserver(self, didUpdateLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            self.manager?.requestLocation()
        case .denied:
            delegate?.locationObserver(self, didFailWithError: LocationObserverError.locationAccessDenied)
        case .restricted:
            delegate?.locationObserver(self, didFailWithError: LocationObserverError.locationAccessRestricted)
        default:
            break
        }
    }
    
}
