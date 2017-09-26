//
//  SignInResponseContainer.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 9/25/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct SignInResponseContainer: Codable {
    enum CodingKeys: String, CodingKey {
        case user = "data"
    }
    
    let user: CurrentUser
}
