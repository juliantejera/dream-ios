//
//  CurrentUserParser.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 7/14/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct CurrentUserParser: Parser {
    
    struct Keys {
        static let id = "id"
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    
    func parse(from dictionary: [AnyHashable : Any]) -> CurrentUser? {
        guard let id = dictionary[Keys.id] as? Int,
              let latitude = dictionary[Keys.latitude] as? Double,
            let longitude = dictionary[Keys.longitude] as? Double else  {
                return nil
        }
        
        return CurrentUser(id: id, latitude: latitude, longitude: longitude)
    }
}
