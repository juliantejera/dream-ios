//
//  ErrorsParser.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/26/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct ErrorsParser: Parser {
    
    private struct Keys {
        static let errors = "errors"
        static let fullMessages = "full_messages"
    }
    
    func parse(from dictionary: [AnyHashable : Any]) -> [String]? {
        guard let errorsDictionary = dictionary[Keys.errors] as? [String: Any], let errors = errorsDictionary[Keys.fullMessages] as? [String] else {
            return nil
        }
        
        return errors
    }
    
}