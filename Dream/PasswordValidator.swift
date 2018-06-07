//
//  PasswordValidator.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/16/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

class PasswordValidator: Validator {
    var errors = [String]()
    let password: String
    
    init(password: String) {
        self.password = password
    }
    
    var isValid: Bool {
        errors.removeAll()
        if password.count < 8 {
            errors.append("Your password should have at least 8 characters")
        }
        return errors.isEmpty
    }
}
