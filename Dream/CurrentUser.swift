//
//  CurrentUser.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 7/14/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
import CoreLocation

class CurrentUser: Codable {
    let id: Int
    var latitude: Double?
    var longitude: Double?
    
    init(id: Int, latitude: Double?, longitude: Double?) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func update(location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
    }
}

extension CurrentUser: Equatable {
    static func == (lhs: CurrentUser, rhs: CurrentUser) -> Bool {
        return lhs.id == rhs.id && lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
