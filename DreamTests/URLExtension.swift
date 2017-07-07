//
//  URLExtension.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/29/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

extension URL {
    
    static func create(string: String = "https://google.com") -> URL {
        return URL(string: string)!
    }
    
}
