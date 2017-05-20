//
//  Serializer.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/23/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

protocol Serializer {
    associatedtype T
    func serialize(from object: T) -> [String: Any]
}
