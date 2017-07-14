//
//  CurrentUserSerializer.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 7/14/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct CurrentUserSerializer: Serializer {
    func serialize(from object: CurrentUser) -> [String : Any] {
        return ["user": ["latitude": object.latitude, "longitude": object.longitude]]
    }
}
