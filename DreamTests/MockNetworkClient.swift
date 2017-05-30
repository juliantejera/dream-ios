//
//  MockNetworkClient.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 5/19/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
import Alamofire
@testable import Dream

class MockNetworkClient: NetworkClient {
    var basePath: String = "localhost:3000"
    var response: Any?
    var errors = [String]()
    var parameters: [String: Any]?
    
    func request(method: HTTPMethod, path: String, parameters: [String: Any]?, callback: @escaping (NetworkClientResult<Any>) -> Void) {
        
        self.parameters = parameters
        if let response = response {
            callback(.success(response))
        } else {
            callback(.failure(errors))
        }
    }

}