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
    private let userDefaults: UserDefaults
    
    init(keychain: KeychainProtocol, userDefaults: UserDefaults = .standard) {
        self.keychain = keychain
        self.userDefaults = userDefaults
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
    
    func persist(user: CurrentUser) {
        do {
            let data = try JSONEncoder().encode(user)
            userDefaults.set(data, forKey: "current_user")
        } catch {
            
        }
    }
    
    func extractUser() -> CurrentUser? {
        guard let data = userDefaults.value(forKey: "current_user") as? Data else {
            return nil
        }
        
        return try? JSONDecoder().decode(CurrentUser.self, from: data)        
    }
    
    func removeUser() {
        userDefaults.set(nil, forKey: "current_user")
    }
    
    func removeToken() {
        do {
            try keychain.remove(RFC6750BearerTokenParser.Keys.accessToken)
            try keychain.remove(RFC6750BearerTokenParser.Keys.tokenType)
            try keychain.remove(RFC6750BearerTokenParser.Keys.client)
            try keychain.remove(RFC6750BearerTokenParser.Keys.expiry)
            try keychain.remove(RFC6750BearerTokenParser.Keys.uid)
        } catch let error {
            print("Keychain error: \(error)")
        }

    }
    
    func extractToken() -> RFC6750BearerToken? {
        do {
            let dictionary = [
                RFC6750BearerTokenParser.Keys.accessToken: try keychain.get(RFC6750BearerTokenParser.Keys.accessToken),
                RFC6750BearerTokenParser.Keys.tokenType: try keychain.get(RFC6750BearerTokenParser.Keys.tokenType),
                RFC6750BearerTokenParser.Keys.client: try keychain.get(RFC6750BearerTokenParser.Keys.client),
                RFC6750BearerTokenParser.Keys.expiry: try keychain.get(RFC6750BearerTokenParser.Keys.expiry),
                RFC6750BearerTokenParser.Keys.uid: try keychain.get(RFC6750BearerTokenParser.Keys.uid)
            ]
            
            return RFC6750BearerTokenParser().parse(from: dictionary as [AnyHashable : Any])
        } catch let error {
            print("Keychain error: \(error)")
            return nil
        }
    }

}
