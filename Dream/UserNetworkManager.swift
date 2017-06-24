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
    private let userParser: UserParser
    
    init(client: NetworkClient) {
        self.client = client
        self.relativePath = "users"
        self.userParser = UserParser()
    }
    
    func findAll(limit: Int, radius: Int, callback: @escaping (NetworkClientResult<[User]>) -> Void) {
        let parameters = ["limit": limit, "radius": radius]
        
        client.request(method: .get, path: path, parameters: parameters) { (result) in
            switch result {
            case .success(let response):
                callback(self.parseFindAll(response: response))
            case .failure(let errors):
                callback(.failure(errors))
            }
        }
    }
    
    private func parseFindAll(response: Any) -> NetworkClientResult<[User]> {
        if let array = response as? [[AnyHashable: Any]] {
            let users = array.flatMap(self.userParser.parse)
            return .success(users)
        }
        
        return .failure([DreamNetworkClientError.unparsableModel.localizedDescription])
    }
}
