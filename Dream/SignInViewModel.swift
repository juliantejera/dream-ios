//
//  SignInViewModel.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/1/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

struct SignInViewModel {
    var email: String
    var password: String
}

extension SignInViewModel: Equatable {
    static func == (lhs: SignInViewModel, rhs: SignInViewModel) -> Bool {
        return lhs.email == rhs.email && lhs.password == rhs.password
    }
}
