//
//  LocationObserverTests.swift
//  DreamTests
//
//  Created by Julian Tejera-Frias on 7/11/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Dream

class LocationObserverTests: XCTestCase {
    
    var observer: LocationObserver!
    var locationManager: MockLocationManager!
    var delegate: MockLocationObserverDelegate!
    
    override func setUp() {
        super.setUp()
        observer = LocationObserver(locationManagerType: MockLocationManager.self)
        locationManager = MockLocationManager()
        delegate = MockLocationObserverDelegate()
        observer.delegate = delegate
    }
    
    func test_startObserving_configuresTheLocationManager() {
        observer.startObserving(manager: locationManager)
        JTAssertIdentical(locationManager.delegate, observer)
        XCTAssertEqual(locationManager.distanceFilter, 50.0)
        XCTAssertEqual(locationManager.desiredAccuracy, kCLLocationAccuracyBest)
    }
    
    func test_startObserving_whenTheStatusIsNotDetermined_itRequestsWhenInUseAuthorization() {
        MockLocationManager.authorizationStatusStub = .notDetermined
        observer.startObserving(manager: locationManager)
        let actual = locationManager.requestWhenInUseAuthorizationCallCount
        let expected = 1
        XCTAssertEqual(actual, expected)
    }
    
    func test_startObserving_whenTheStatusIsAuthorizedWhenInUse_itRequestsTheLocation() {
        MockLocationManager.authorizationStatusStub = .authorizedWhenInUse
        observer.startObserving(manager: locationManager)
        let actual = locationManager.startUpdatingLocationCallCount
        let expected = 1
        XCTAssertEqual(actual, expected)
    }
    
    func test_startObserving_whenTheStatusIsAuthorizedAlways_itRequestsTheLocation() {
        MockLocationManager.authorizationStatusStub = .authorizedWhenInUse
        observer.startObserving(manager: locationManager)
        let actual = locationManager.startUpdatingLocationCallCount
        let expected = 1
        XCTAssertEqual(actual, expected)
    }
    
    func test_startObserving_whenTheStatusIsDenied_itInformsTheDelegate() {
        MockLocationManager.authorizationStatusStub = .denied
        observer.startObserving(manager: locationManager)
        let actual = delegate.error?.localizedDescription
        let expected = LocationObserverError.locationAccessDenied.localizedDescription
        XCTAssertEqual(actual, expected)
    }
    
    func test_startObserving_whenTheStatusIsRestricted_itInformsTheDelegate() {
        MockLocationManager.authorizationStatusStub = .restricted
        observer.startObserving(manager: locationManager)
        let actual = delegate.error?.localizedDescription
        let expected = LocationObserverError.locationAccessRestricted.localizedDescription
        XCTAssertEqual(actual, expected)
    }
    
    func test_locationManagerDidFailWithError_itInformsTheDelegate() {
        let error = LocationObserverError.locationAccessRestricted
        observer.locationManager(CLLocationManager(), didFailWithError: error)
        let actual = delegate.error?.localizedDescription
        let expected = error.localizedDescription
        XCTAssertEqual(actual, expected)
    }
    
    func test_locationManagerDidUpdateLocations_whenThereAreLocations_itInformsTheDelegateWithTheLastLocation() {
        let locations = [
            CLLocation(latitude: 1, longitude: 2),
            CLLocation(latitude: 2, longitude: 3)
        ]
        observer.locationManager(CLLocationManager(), didUpdateLocations: locations)
        let actual = delegate.location
        let expected = locations.last
        XCTAssertEqual(actual, expected)
    }
    
    func test_locationManagerDidUpdateLocations_whenThereArentAnyLocations_itDoesNotInformTheDelegate() {
        observer.locationManager(CLLocationManager(), didUpdateLocations: [])
        XCTAssertNil(delegate.location)
    }
    
    func test_locationManagerDidChangeAuthorization_whenTheStatusIsAuthorizedWhenInUse_itRequestsTheLocation() {
        MockLocationManager.authorizationStatusStub = .notDetermined
        observer.startObserving(manager: locationManager)
        observer.locationManager(CLLocationManager(), didChangeAuthorization: .authorizedWhenInUse)
        let actual = locationManager.startUpdatingLocationCallCount
        let expected = 1
        XCTAssertEqual(actual, expected)
    }
    
    func test_locationManagerDidChangeAuthorization_whenTheStatusIsAuthorizedAlways_itRequestsTheLocation() {
        MockLocationManager.authorizationStatusStub = .notDetermined
        observer.startObserving(manager: locationManager)
        observer.locationManager(CLLocationManager(), didChangeAuthorization: .authorizedAlways)
        let actual = locationManager.startUpdatingLocationCallCount
        let expected = 1
        XCTAssertEqual(actual, expected)
    }
    
    func test_locationManagerDidChangeAuthorization_whenTheStatusIsDenied_itInformsTheDelegate() {
        observer.locationManager(CLLocationManager(), didChangeAuthorization: .denied)
        let actual = delegate.error?.localizedDescription
        let expected = LocationObserverError.locationAccessDenied.localizedDescription
        XCTAssertEqual(actual, expected)
    }
    
    func test_locationManagerDidChangeAuthorization_whenTheStatusIsRestricted_itInformsTheDelegate() {
        observer.locationManager(CLLocationManager(), didChangeAuthorization: .restricted)
        let actual = delegate.error?.localizedDescription
        let expected = LocationObserverError.locationAccessRestricted.localizedDescription
        XCTAssertEqual(actual, expected)
    }
    
}
