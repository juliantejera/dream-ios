//
//  Parser.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/13/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

protocol Parser {
    associatedtype T
    func parse(from dictionary: [AnyHashable: Any]) -> T?
}
