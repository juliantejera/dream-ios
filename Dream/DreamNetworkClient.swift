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
    private let sessionManager: SessionManager
    private let authenticationController: AuthenticationController
    
    init() {
        let config = URLSessionConfiguration.default
        config.httpShouldSetCookies = false
        config.httpCookieAcceptPolicy = .never
        sessionManager = SessionManager(configuration: config)
        authenticationController = AuthenticationController()
    }
    
    func request(method: HTTPMethod, path: String, parameters: [String : Any]?, callback: @escaping (NetworkClientResult<Any>) -> Void) {
        let request = self.sessionManager.request(path, method: method, parameters: parameters, headers: headers)
        request.responseJSON { (dataResponse) in
            self.updateBearerToken(dataResponse: dataResponse)
            switch dataResponse.result {
            case .success(let value):
                callback(self.result(for: value))
            case .failure(let error):
                callback(.failure([error.localizedDescription]))
            }
        }
    }
    
    private func updateBearerToken(dataResponse: DataResponse<Any>) {
        guard let httpHeaders = dataResponse.response?.allHeaderFields,
              let token = RFC6750BearerTokenParser().parse(from: httpHeaders) else {
            return
        }
        
        authenticationController.persist(token: token)
    }
    
    private func result(for value: Any) -> NetworkClientResult<Any> {
        if let dictionary = value as? [AnyHashable: Any], let errors = ErrorsParser().parse(from: dictionary) {
            return .failure(errors)
        } else {
            return .success(value)
        }
    }
    
    var headers: [String: String] {
        var dictionary = SessionManager.defaultHTTPHeaders
        dictionary["Accept"] = "application/json"

        guard let token = authenticationController.extractToken(), let tokenHeaders = RFC6750BearerTokenSerializer().serialize(from: token) as? [String: String] else {
            return dictionary
        }
        
        dictionary.add(dictionary: tokenHeaders)

        return dictionary
    }
    
}
