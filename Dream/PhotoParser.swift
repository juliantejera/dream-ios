//
//  PhotoParser.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/17/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct PhotoParser: Parser {
    
    struct Keys {
        static let id = "id"
        static let order = "order"
        static let status = "status"
        static let url = "url"
    }
    
    func parse(from dictionary: [AnyHashable : Any]) -> Photo? {
        guard let id = dictionary[Keys.id] as? Int,
            let order = dictionary[Keys.order] as? Int,
            let statusInt = dictionary[Keys.status] as? Int,
            let status = PhotoStatus(rawValue: statusInt),
            let urlString = dictionary[Keys.url] as? String,
            let url = URL(string: urlString) else {
            return nil
        }
        
        return Photo(id: id, order: order, status: status, url: url)
    }
}
