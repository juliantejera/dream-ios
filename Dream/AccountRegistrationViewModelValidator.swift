//
//  AccountRegistrationViewModelValidator.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/16/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

class AccountRegistrationViewModelValidator: CompositeValidator {
    
    init(viewModel: AccountRegistrationViewModel) {
        super.init()
        validators.append(EmailValidator(email: viewModel.email))
        validators.append(PasswordValidator(password: viewModel.password))
        validators.append(PasswordConfirmationValidator(password: viewModel.password, passwordConfirmation: viewModel.passwordConfirmation))
        validators.append(AdultAgeValidator(date: viewModel.birthdate))
    }
}
