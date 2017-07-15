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
        let dictionary: [String: Any] = ["id": user.id, "latitude": user.latitude, "longitude": user.longitude]
        userDefaults.set(dictionary, forKey: "current_user")
    }
    
    func extractUser() -> CurrentUser? {
        let parser = CurrentUserParser()
        guard let dictionary = userDefaults.value(forKey: "current_user") as? [AnyHashable: Any], let currrentUser = parser.parse(from: dictionary) else {
            return nil
        }
        
        return currrentUser
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
            
            return RFC6750BearerTokenParser().parse(from: dictionary)
        } catch let error {
            print("Keychain error: \(error)")
            return nil
        }
    }

}
