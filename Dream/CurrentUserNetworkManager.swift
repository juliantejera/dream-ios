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
    private let currentUserParser: CurrentUserParser
    
    init(client: NetworkClient) {
        self.client = client
        self.relativePath = "users"
        self.currentUserParser = CurrentUserParser()
    }
    
    func update(user: CurrentUser, callback: ((NetworkClientResult<CurrentUser>) -> Void)?) {
        let parameters = CurrentUserSerializer().serialize(from: user)
        let updatePath = "\(path)/\(user.id)"
        client.request(method: .put, path: updatePath, parameters: parameters) { (result) in
            switch result {
            case .success(let response):
                callback?(self.parseCurrentUser(response: response))
            case .failure(let errors):
                callback?(.failure(errors))
            }
        }
    }
    
    private func parseCurrentUser(response: Any) -> NetworkClientResult<CurrentUser> {
        if let dictionary = response as? [AnyHashable: Any], let user = currentUserParser.parse(from: dictionary) {
            return .success(user)
        }
        
        return .failure([DreamNetworkClientError.unparsableModel.localizedDescription])
    }
    
}
