//
//  User.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/18/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct User {
    let id: Int
    let distance: Double 
    let photos: [Photo]
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id && lhs.distance == rhs.distance && lhs.photos == rhs.photos
    }
}
