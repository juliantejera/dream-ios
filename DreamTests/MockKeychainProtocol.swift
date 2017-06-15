//
//  MockKeychainProtocol.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/3/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
@testable import Dream

enum MockKeychainProtocolState: Error {
    case failure
    case none
}

class MockKeychainProtocol: KeychainProtocol {
 
    var attributes: [String: String] = [:]
    var state = MockKeychainProtocolState.none
    
    func get(_ key: String) throws -> String? {
        switch state {
        case .failure:
            throw state
        case .none:
            return attributes[key]
        }
    }
    
    func set(_ value: String, key: String) throws {
        switch state {
        case .failure:
            throw state
        case .none:
            attributes[key] = value
        }
    }
    
    func remove(_ key: String) throws {
        switch state {
        case .failure:
            throw state
        case .none:
            attributes.removeValue(forKey: key)
        }
    }
}
