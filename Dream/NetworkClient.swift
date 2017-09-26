//
//  NetworkClient.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/13/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

protocol NetworkClient {
    var basePath: String { get }
    func request(method: HttpMethod, path: String, parameters: [String: Any]?, httpBody: Data?, callback: @escaping (NetworkClientResult<Data>) -> Void)
    func request<T: Codable>(method: HttpMethod, path: String, parameters: [String: Any]?, httpBody: Data?, callback: @escaping (NetworkClientResult<T>) -> Void)
}

enum NetworkClientResult<Type> {
    case success(Type)
    // array of error messages
    case failure([String])
}
