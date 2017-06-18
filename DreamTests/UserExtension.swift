//
//  UserExtension.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/18/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
@testable import Dream

extension User {
    
    static func create(id: Int = 1, distance: Double = 50, photos: [Photo] = [Photo.create()]) -> User {
        return User(id: id, distance: distance, photos: photos)
    }
    
}
