//
//  PasswordConfirmationValidator.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/16/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

class PasswordConfirmationValidator: Validator {
    var errors = [String]()
    let password: String
    let passwordConfirmation: String
    
    init(password: String, passwordConfirmation: String) {
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
    
    var isValid: Bool {
        errors.removeAll()
        if password != passwordConfirmation {
            errors.append("The password confirmation does not match")
        }
        return errors.isEmpty
    }
}
