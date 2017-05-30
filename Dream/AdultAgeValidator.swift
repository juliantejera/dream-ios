//
//  AdultAgeValidator.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/16/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

class AdultAgeValidator: Validator {
    let date: Date
    private(set) var errors = [String]()
    init(date: Date) {
        self.date = date
    }
    
    var isValid: Bool {
        errors.removeAll()
        
        if let age = Calendar.current.dateComponents([.year], from: date, to: Date()).year, age < 18 {
            errors.append("You need to be at least 18 years old to use this app")
        }
        
        return errors.isEmpty
    }
    
}
