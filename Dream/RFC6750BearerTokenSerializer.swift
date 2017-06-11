//
//  RFC6750BearerTokenSerializer.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/4/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct RFC6750BearerTokenSerializer: Serializer {
    func serialize(from object: RFC6750BearerToken) -> [String : Any] {
        return [
            RFC6750BearerTokenParser.Keys.accessToken: object.accessToken,
            RFC6750BearerTokenParser.Keys.tokenType: object.tokenType,
            RFC6750BearerTokenParser.Keys.client: object.client,
            RFC6750BearerTokenParser.Keys.expiry: object.expiry.description,
            RFC6750BearerTokenParser.Keys.uid: object.uid
        ]
    }
}
