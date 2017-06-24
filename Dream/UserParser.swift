//
//  UserParser.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/18/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct UserParser: Parser {
    
    struct Keys {
        static let id = "id"
        static let distance = "distance"
        static let photos = "photos"
    }
    
    private let photoParser: PhotoParser
    
    init(photoParser: PhotoParser = PhotoParser()) {
        self.photoParser = photoParser
    }
    
    func parse(from dictionary: [AnyHashable : Any]) -> User? {
        guard let id = dictionary[Keys.id] as? Int,
            let distance = dictionary[Keys.distance] as? Double,
            let photosArray = dictionary[Keys.photos] as? [[AnyHashable: Any]] else {
            return nil
        }
        let photos = photosArray.flatMap(photoParser.parse)
        return User(id: id, distance: distance, photos: photos)
    }
}
