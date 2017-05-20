//
//  CompositeValidatorSpec.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/16/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

@testable import Dream
import Quick
import Nimble

class CompositeValidatorSpec: QuickSpec {
    
    override func spec() {
        
        describe("CompositeValidator") {
            
            describe("isValid") {
                
                var validator: CompositeValidator!
                
                context("when all the validators are valid") {
                    
                    beforeEach {
                        validator = CompositeValidator()
                        validator.validators.append(EmailValidator(email: "julian.tejera@soundcloud.com"))
                        validator.validators.append(PasswordValidator(password: "veryverysecure"))
                    }
                    
                    it("returns true") {
                        expect(validator.isValid).to(beTrue())
                    }
                    
                    it("does not have any error messages") {
                        _ = validator.isValid
                        expect(validator.errors.isEmpty).to(beTrue())
                    }

                }
                
                context("when any of the validators is not valid") {
                    
                    beforeEach {
                        validator = CompositeValidator()
                        validator.validators.append(EmailValidator(email: "julian.tejera@@soundcloud.com"))
                        validator.validators.append(PasswordValidator(password: "1234"))
                    }
                    
                    it("returns false") {
                        expect(validator.isValid).to(beFalse())
                    }
                    
                    it("has error messages") {
                        let errors = [
                            "'julian.tejera@@soundcloud.com' is not a valid email",
                            "Your password should have at least 8 characters"
                        ]
                        _ = validator.isValid
                        expect(validator.errors).to(equal(errors))
                    }
                }


                
            }
        }
    }
    
    
    
}
