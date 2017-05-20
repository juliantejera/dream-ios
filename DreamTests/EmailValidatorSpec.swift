//
//  EmailValidatorSpec.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/16/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

@testable import Dream
import Quick
import Nimble

class EmailValidatorSpec: QuickSpec {
    
    override func spec() {
        
        describe("EmailValidator") {
            
            describe("isValid") {
                
                var validator: EmailValidator!
                
                context("when the email has subdomains") {
                    
                    beforeEach {
                        validator = EmailValidator(email: "julian@gmail.dcc.com")
                    }
                    
                    it("returns true") {
                        expect(validator.isValid).to(beTrue())
                    }
                    
                    it("doesnt have any error messages") {
                        _ = validator.isValid
                        expect(validator.errors.isEmpty).to(beTrue())
                    }

                }
                
                context("when the email doesnt have subdomains") {
                    beforeEach {
                        validator = EmailValidator(email: "lady@gaga.com")
                    }
                    
                    it("returns true") {
                        expect(validator.isValid).to(beTrue())
                    }
                    
                    it("doesnt have any error messages") {
                        _ = validator.isValid
                        expect(validator.errors.isEmpty).to(beTrue())
                    }
                }
                
                context("when the email is an empty string") {
                    beforeEach {
                        validator = EmailValidator(email: "")
                    }
                    
                    it("returns false") {
                        expect(validator.isValid).to(beFalse())
                    }
                    
                    it("has an error message") {
                        _ = validator.isValid
                        let errors = ["'' is not a valid email"]
                        expect(validator.errors).to(equal(errors))
                    }
                }
                
                context("when the email is invalid") {
                    beforeEach {
                        validator = EmailValidator(email: "lady@@gaga.com")
                    }
                    
                    it("returns false") {
                        expect(validator.isValid).to(beFalse())
                    }
                    
                    it("has an error message") {
                        _ = validator.isValid
                        let errors = ["'lady@@gaga.com' is not a valid email"]
                        expect(validator.errors).to(equal(errors))
                    }
                }

            }
        }
    }
    
}
