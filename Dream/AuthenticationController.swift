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
    
    struct Keys {
        static let token = "token"
        static let currentUser = "current_user"
    }
    
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
            let data = try JSONEncoder().encode(token)
            try keychain.set(data, key: Keys.token)
        } catch let error {
            print("Keychain error: \(error)")
        }
    }
    
    func persist(user: CurrentUser) {
        do {
            let data = try JSONEncoder().encode(user)
            userDefaults.set(data, forKey: Keys.currentUser)
        } catch {
            
        }
    }
    
    func extractUser() -> CurrentUser? {
        guard let data = userDefaults.value(forKey: Keys.currentUser) as? Data else {
            return nil
        }
        
        return try? JSONDecoder().decode(CurrentUser.self, from: data)        
    }
    
    func removeUser() {
        userDefaults.set(nil, forKey: Keys.currentUser)
    }
    
    func removeToken() {
        do {
            try keychain.remove(Keys.token)
        } catch let error {
            print("Keychain error: \(error)")
        }

    }
    
    func extractToken() -> RFC6750BearerToken? {
        do {            
            guard let data = try keychain.getData(Keys.token) else {
                return nil
            }
            return try JSONDecoder().decode(RFC6750BearerToken.self, from: data)
        } catch let error {
            print("Keychain error: \(error)")
            return nil
        }
    }

}
