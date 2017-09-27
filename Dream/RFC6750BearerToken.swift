//
//  RFC6750BearerToken.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/2/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct RFC6750BearerToken: Codable {
    let accessToken: String
    let tokenType: String
    let client: String
    let expiry: String
    let uid: String
}

extension RFC6750BearerToken: Equatable {
    static func == (lhs: RFC6750BearerToken, rhs: RFC6750BearerToken) -> Bool {
        return lhs.accessToken == rhs.accessToken &&
            lhs.tokenType == rhs.tokenType &&
            lhs.client == rhs.client &&
            lhs.expiry == rhs.expiry &&
            lhs.uid == rhs.uid
    }
}
