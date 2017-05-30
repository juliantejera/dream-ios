//
//  AuthenticationNetworkManager.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/13/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct AuthenticationNetworkManager {
    private let client: NetworkClient
    private let relativePath: String
    private let serializer: AccountRegistrationViewModelSerializer
    
    init(client: NetworkClient) {
        self.client = client
        self.relativePath = "auth"
        self.serializer = AccountRegistrationViewModelSerializer()
    }
    
    func register(user: AccountRegistrationViewModel, callback: @escaping (NetworkClientResult<Any>) -> Void) {
        
        let parameters: [String: Any] = serializer.serialize(from: user)
        let path = "\(client.basePath)\(relativePath)"
        
        client.request(method: .post, path: path, parameters: parameters) { (result) in
            callback(result)
        }
        
    }
}
