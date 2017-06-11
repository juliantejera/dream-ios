//
//  AuthenticationController.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/2/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
import KeychainAccess.Swift

struct AuthenticationController {
    
    private let keychain: KeychainProtocol
    
    init(keychain: KeychainProtocol) {
        self.keychain = keychain
    }
    
    init() {
        let service = Bundle.main.bundleIdentifier ?? "com.juliantejera.Dream"
        self.init(keychain: Keychain(service: service))
    }
    
    func persist(token: RFC6750BearerToken) {
        do {
            try keychain.set(token.accessToken, key: RFC6750BearerTokenParser.Keys.accessToken)
            try keychain.set(token.tokenType, key: RFC6750BearerTokenParser.Keys.tokenType)
            try keychain.set(token.client, key: RFC6750BearerTokenParser.Keys.client)
            try keychain.set(token.expiry.description, key: RFC6750BearerTokenParser.Keys.expiry)
            try keychain.set(token.uid, key: RFC6750BearerTokenParser.Keys.uid)
        } catch let error {
            print("Keychain error: \(error)")
        }
    }
    
    func extract() -> RFC6750BearerToken? {
        do {
            let dictionary = [
                RFC6750BearerTokenParser.Keys.accessToken: try keychain.get(RFC6750BearerTokenParser.Keys.accessToken),
                RFC6750BearerTokenParser.Keys.tokenType: try keychain.get(RFC6750BearerTokenParser.Keys.tokenType),
                RFC6750BearerTokenParser.Keys.client: try keychain.get(RFC6750BearerTokenParser.Keys.client),
                RFC6750BearerTokenParser.Keys.expiry: try keychain.get(RFC6750BearerTokenParser.Keys.expiry),
                RFC6750BearerTokenParser.Keys.uid: try keychain.get(RFC6750BearerTokenParser.Keys.uid)
            ]
            
            return RFC6750BearerTokenParser().parse(from: dictionary)
        } catch let error {
            print("Keychain error: \(error)")
            return nil
        }
    }

}
