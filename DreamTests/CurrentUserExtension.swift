//
//  CurrentUserExtension.swift
//  DreamTests
//
//  Created by Julian Tejera-Frias on 7/14/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
@testable import Dream

extension CurrentUser {
    static func create() -> CurrentUser {
        return CurrentUser(id: 3, latitude: 40.2525, longitude: -25.2323)
    }
}
