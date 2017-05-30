//
//  DreamNetworkClient.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/13/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
import Alamofire

enum DreamNetworkClientError: Error {
    case unparsableModel
}

class DreamNetworkClient: NetworkClient {
    
    let basePath = "http://localhost:3000/"
    
    private lazy var sessionManager = SessionManager.default
    
    func request(method: HTTPMethod, path: String, parameters: [String : Any]?, callback: @escaping (NetworkClientResult<Any>) -> Void) {
        
        let request = self.sessionManager.request(path, method: method, parameters: parameters, headers: headers)
        request.responseJSON { (dataResponse) in
            switch dataResponse.result {
            case .success(let value):
                callback(self.result(for: value))
            case .failure(let error):
                callback(.failure([error.localizedDescription]))
            }
        }
    }
    
    private func result(for value: Any) -> NetworkClientResult<Any> {
        if let dictionary = value as? [AnyHashable: Any], let errors = ErrorsParser().parse(from: dictionary) {
            return .failure(errors)
        } else {
            return .success(value)
        }
    }
    
    var headers: [String: String] {
        return ["Accept": "application/json"]
    }
    
}
