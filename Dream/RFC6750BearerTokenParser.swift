//
//  RFC6750BearerTokenParser.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/2/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct RFC6750BearerTokenParser: Parser {
     struct Keys {
        static let accessToken = "access-token"
        static let tokenType = "token-type"
        static let client = "client"
        static let expiry = "expiry"
        static let uid = "uid"
     }
    
    func parse(from dictionary: [AnyHashable : Any]) -> RFC6750BearerToken? {
        guard let accessToken = dictionary[Keys.accessToken] as? String,
            let tokenType = dictionary[Keys.tokenType] as? String,
            let client = dictionary[Keys.client] as? String,
            let expiryString = dictionary[Keys.expiry] as? String,
            let expiry = Int(expiryString),
            let uid = dictionary[Keys.uid] as? String else {
                return nil
        }
        
        return RFC6750BearerToken(accessToken: accessToken, tokenType: tokenType, client: client, expiry: expiry, uid: uid)
    }
}
