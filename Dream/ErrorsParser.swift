//
//  ErrorsParser.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/26/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct ErrorsParser: Parser {
    
    func parse(from dictionary: [AnyHashable : Any]) -> [String]? {
        guard let errorsDictionary = dictionary["errors"] as? [String: Any], let errors = errorsDictionary["full_messages"] as? [String] else {
            return nil
        }
        
        return errors
    }
    
}
