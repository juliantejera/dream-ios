//
//  MockImageNetworkManagerProtocol.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/21/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit
@testable import Dream

class MockImageNetworkManager: ImageNetworkManagerProtocol {
    
    var image: UIImage?
    var onRequest: (() -> Void)?
    var task = MockURLSessionTaskProtocol()
    func request(url: URL, callback: @escaping (UIImage?) -> Void) -> URLSessionTaskProtocol {
        callback(image)
        return task
    }

}
