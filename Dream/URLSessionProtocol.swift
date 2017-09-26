//
//  URLSessionProtocol.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 9/21/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func task(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol
    func task(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol
}

extension URLSession: URLSessionProtocol {
    
    func task(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        return self.dataTask(with: url, completionHandler: completionHandler)
    }
    
    func task(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        return self.dataTask(with: request, completionHandler: completionHandler)
    }
    
}
