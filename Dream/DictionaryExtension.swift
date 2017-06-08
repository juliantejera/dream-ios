//
//  DictionaryExtension.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/4/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func add(dictionary: [Key: Value]) {
        dictionary.forEach { (key, value) in
            self.updateValue(value, forKey: key)
        }
    }
}
