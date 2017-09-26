//
//  Photo.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/17/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let id: Int
    let order: Int
    let status: PhotoStatus
    let url: URL 
}

extension Photo: Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id &&
            lhs.order == rhs.order &&
            lhs.status == rhs.status &&
            lhs.url == rhs.url
    }
}
