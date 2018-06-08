//
//  User.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/18/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct User: Codable, Equatable {
    let id: Int
    let distance: Double 
    let photos: [Photo]
}
