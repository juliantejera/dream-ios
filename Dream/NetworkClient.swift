//
//  NetworkClient.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/13/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkClient {
    var basePath: String { get }
    func request(method: HTTPMethod, path: String, parameters: [String: Any]?, callback: @escaping (NetworkClientResult<Any>) -> Void)
}

enum NetworkClientResult<Type> {
    case success(Type)
    // array of error messages
    case failure([String])
}
