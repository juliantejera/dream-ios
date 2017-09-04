//
//  ImageNetworkManagerProtocol.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/19/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

protocol ImageNetworkManagerProtocol {
    func request(url: URL, callback: @escaping (UIImage?) -> Void) -> URLSessionTaskProtocol
}
