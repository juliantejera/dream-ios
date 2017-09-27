//
//  RFC6750BearerTokenExtension.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/3/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
@testable import Dream

extension RFC6750BearerToken {
    
    static func create() -> RFC6750BearerToken {
        return RFC6750BearerToken(accessToken: "4P9fHIJ5eX6v1PYJI4iF8Q", tokenType: "Bearer", client: "3XmvWP5VZ7J4VbxTa0Wp0w", expiry: "1497673221", uid: "jtejera27@gmail.com")
    }
    
}
