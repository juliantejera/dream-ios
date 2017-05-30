//
//  Validator.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/16/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

protocol Validator {
    var errors: [String] { get }
    var isValid: Bool { get }
}

class CompositeValidator: Validator {
    private (set) var errors = [String]()
    var validators = [Validator]()
    var isValid: Bool {
        errors.removeAll()
        
        for v in validators {
            _ = v.isValid
            errors += v.errors
        }
        
        return errors.isEmpty
    }
}
