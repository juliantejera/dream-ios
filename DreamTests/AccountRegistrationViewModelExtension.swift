//
//  AccountRegistrationViewModelExtension.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 5/19/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
@testable import Dream

extension AccountRegistrationViewModel {
    
    static func create(birthdate: Date = Date(timeIntervalSince1970: 0)) -> AccountRegistrationViewModel {
        return AccountRegistrationViewModel(email: "jt@gmail.com", password: "password", passwordConfirmation: "password", birthdate: birthdate)
    }
    
}

