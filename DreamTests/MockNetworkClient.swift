//
//  MockNetworkClient.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 5/19/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
@testable import Dream

class MockNetworkClient: NetworkClient {

    
    var basePath: String = "localhost:3000"
    var response: Data?
    var errors = [String]()
    var parameters: [String: Any]?
    var onRequest: (() -> Void)?
    
    func request(method: HttpMethod, path: String, parameters: [String : Any]?, httpBody: Data?, callback: @escaping (NetworkClientResult<Data>) -> Void) {
        onRequest?()
        self.parameters = parameters
        if let response = response, errors.isEmpty {
            callback(.success(response))
        } else {
            callback(.failure(errors))
        }
    }
    
    func request<T>(method: HttpMethod, path: String, parameters: [String : Any]?, httpBody: Data?, callback: @escaping (NetworkClientResult<T>) -> Void) where T : Decodable, T : Encodable {
        request(method: method, path: path, parameters: parameters, httpBody: httpBody) { (dataResult) in
            switch dataResult {
            case .success(let data):
                do {
                    let codable = try JSONDecoder().decode(T.self, from: data)
                    callback(.success(codable))
                } catch let error {
                    callback(.failure([error.localizedDescription]))
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }

}
