//
//  SignInViewModelValidator.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/1/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

class SignInViewModelValidator: CompositeValidator {
    init(viewModel: SignInViewModel) {
        super.init()
        validators.append(EmailValidator(email: viewModel.email))
        validators.append(PasswordValidator(password: viewModel.password))
    }
}
