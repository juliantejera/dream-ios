//
//  UserNetworkManager.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/18/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct UserNetworkManager: NetworkManager {
    
    let client: NetworkClient
    let relativePath: String
    
    init(client: NetworkClient) {
        self.client = client
        self.relativePath = "users"
    }
    
    func findAll(limit: Int, radius: Int, callback: @escaping (NetworkClientResult<[User]>) -> Void) {
        let parameters = ["limit": limit, "radius": radius]
        
        client.request(method: .get, path: path, parameters: parameters, httpBody: nil) { (result: NetworkClientResult<[User]>) in
            callback(result)
        }

    }
}
