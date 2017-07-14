//
//  CurrentUserNetworkManager.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 7/14/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct CurrentUserNetworkManager: NetworkManager {
    
    let client: NetworkClient
    let relativePath: String
    
    init(client: NetworkClient) {
        self.client = client
        self.relativePath = "users"
    }
    
    func update(user: CurrentUser, callback: @escaping (NetworkClientResult<CurrentUser>) -> Void) {
        
    }
}
