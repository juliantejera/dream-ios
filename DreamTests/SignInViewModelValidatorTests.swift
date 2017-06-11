//
//  SignInViewModelValidatorTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/1/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class SignInViewModelValidatorTests: XCTestCase {
    
    func testIsValidWhenAllTheValidatorsAreValid() {
        let validator = SignInViewModelValidator(viewModel: SignInViewModel.create())
        XCTAssert(validator.isValid)
    }
    
    func testIsValidWhenTheEmailIsInvalid() {
        let validator = SignInViewModelValidator(viewModel: SignInViewModel.create(email: "xxx"))
        let errors = ["'xxx' is not a valid email"]
        XCTAssertFalse(validator.isValid)
        XCTAssertEqual(validator.errors, errors)
    }
    
    func testIsValidWhenThePasswordIsInvalid() {
        let validator = SignInViewModelValidator(viewModel: SignInViewModel.create(password: "xxx"))
        let errors = ["Your password should have at least 8 characters"]
        XCTAssertFalse(validator.isValid)
        XCTAssertEqual(validator.errors, errors)
    }
}
