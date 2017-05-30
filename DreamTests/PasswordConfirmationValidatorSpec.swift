//
//  PasswordConfirmationValidatorSpec.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/16/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

@testable import Dream

import Quick
import Nimble

class PasswordConfirmationValidatorSpec: QuickSpec {
    
    override func spec() {
        
        describe("PasswordConfirmationValidator") {
            
            var validator: PasswordConfirmationValidator!
            
            describe("isValid") {
                
                context("when the passwords match") {
                    
                    beforeEach {
                        validator = PasswordConfirmationValidator(password: "secure01", passwordConfirmation: "secure01")
                    }
                    
                    it("returns true") {
                        expect(validator.isValid).to(beTrue())
                    }
                    
                    it("does not have any error messages") {
                        _ = validator.isValid
                        expect(validator.errors.isEmpty).to(beTrue())
                    }
                    
                }
                
                context("when the passwords do not match") {
                    
                    beforeEach {
                        validator = PasswordConfirmationValidator(password: "01", passwordConfirmation: "02")
                    }
                    
                    it("returns false") {
                        expect(validator.isValid).to(beFalse())
                    }
                    
                    it("has error messages") {
                        _ = validator.isValid
                        let errors = ["The password confirmation does not match"]
                        expect(validator.errors).to(equal(errors))
                    }
                }
            }
        }
    }
    
}
