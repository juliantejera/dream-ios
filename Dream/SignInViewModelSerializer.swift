//
//  SignInViewModelSerializer.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/1/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct SignInViewModelSerializer: Serializer {
    
    func serialize(from object: SignInViewModel) -> [String : Any] {
        return ["email": object.email, "password": object.password]
    }
    
}

