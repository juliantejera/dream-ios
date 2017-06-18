//
//  PhotoExtension.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/17/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
@testable import Dream

extension Photo {
    
    static func create(id: Int = 1,
                       order: Int = 0,
                       status: PhotoStatus = .accepted,
                       url: URL = URL(string: "https://google.com")!) -> Photo {
        return Photo(id: id, order: order, status: status, url: url)
    }
    
}
