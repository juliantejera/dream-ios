//
//  SignInViewModelExtension.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/1/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
@testable import Dream

extension SignInViewModel {
    
    static func create(email: String = "jt@gmail.com", password: String = "whogothepower") -> SignInViewModel {
        return SignInViewModel(email: email, password: password)
    }
    
}
