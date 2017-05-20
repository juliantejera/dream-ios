//
//  AccountRegistrationViewModelSerializer.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 5/13/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct AccountRegistrationViewModelSerializer: Serializer {
    
    func serialize(from object: AccountRegistrationViewModel) -> [String : Any] {
        return [
            "email": object.email,
            "password": object.password,
            "password_confirmation": object.passwordConfirmation,
            "birthdate": object.birthdate
        ]
    }
}
