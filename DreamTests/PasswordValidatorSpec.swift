//
//  PasswordValidatorSpec.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/16/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

@testable import Dream
import Quick
import Nimble

class PasswordValidatorSpec: QuickSpec {
    
    override func spec() {
        
        describe("PasswordValidator") {
            
            var validator: PasswordValidator!
            
            describe("isValid") {
                
                context("when the password has 8 characters or more") {
                    
                    beforeEach {
                        validator = PasswordValidator(password: "secure01")
                    }
                    
                    it("returns true") {
                        expect(validator.isValid).to(beTrue())
                    }
                    
                    it("does not have any error messages") {
                        _ = validator.isValid
                        expect(validator.errors.isEmpty).to(beTrue())
                    }
                    
                }
                
                context("when the password has less than 8 characters") {
                    
                    beforeEach {
                        validator = PasswordValidator(password: "secure")
                    }
                    
                    it("returns false") {
                        expect(validator.isValid).to(beFalse())
                    }
                    
                    it("has error messages") {
                        _ = validator.isValid
                        let errors = ["Your password should have at least 8 characters"]
                        expect(validator.errors).to(equal(errors))
                    }
                }
            }
            
        }
    }
    
}
