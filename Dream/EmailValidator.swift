//
//  EmailValidator.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/16/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

class EmailValidator: Validator {
    var errors = [String]()
    let email: String

    init(email: String) {
        self.email = email
    }
    
    var isValid: Bool {
        errors.removeAll()
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        if !predicate.evaluate(with: email) {
            errors.append("'\(email)' is not a valid email")
        }
        return errors.isEmpty
    }
}
