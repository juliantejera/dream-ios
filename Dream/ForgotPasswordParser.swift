//
//  ForgotPasswordParser.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/11/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct ForgotPasswordParser: Parser {
    
    func parse(from dictionary: [AnyHashable : Any]) -> String? {
        return dictionary["message"] as? String
    }
    
}
