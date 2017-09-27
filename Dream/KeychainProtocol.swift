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
    func getData(_ key: String) throws -> Data?
    func set(_ value: Data, key: String) throws
    func remove(_ key: String) throws    
}

extension Keychain: KeychainProtocol {}
