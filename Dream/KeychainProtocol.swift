//
//  KeychainProtocol.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/3/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
import KeychainAccess

protocol KeychainProtocol {
    func get(_ key: String) throws -> String?
    func set(_ value: String, key: String) throws
}

extension Keychain: KeychainProtocol {}
