//
//  NetworkManager.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/18/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

protocol NetworkManager {
    var client: NetworkClient { get }
    var relativePath: String { get }
    var path: String { get }
}

extension NetworkManager {
    var path: String {
        return "\(client.basePath)\(relativePath)"
    }
}
