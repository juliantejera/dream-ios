//
//  AdultAgeValidator.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/16/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

@testable import Dream

import Quick
import Nimble

class AdultAgeValidatorSpec: QuickSpec {
    
    override func spec() {
        
        describe("AdultAgeValidator") {
            
            var validator: AdultAgeValidator!
 
            describe("isValid") {
                
                context("when the age is over 18 or older") {
                    
                    beforeEach {
                        validator = AdultAgeValidator(date: Date(timeIntervalSince1970: 0))
                    }
                    
                    it("returns true") {
                        expect(validator.isValid).to(beTrue())
                    }
                    
                    it("does not have any error messages") {
                        _ = validator.isValid
                        expect(validator.errors.isEmpty).to(beTrue())
                    }
                    
                }
                
                context("when the age is under 18 years old") {
                    
                    beforeEach {
                        var components = DateComponents()
                        components.year = 2010
                        components.month = 11
                        components.day = 27
                        validator = AdultAgeValidator(date: Calendar.current.date(from: components)!)
                    }
                    
                    it("returns false") {
                        expect(validator.isValid).to(beFalse())
                    }
                    
                    it("has error messages") {
                        _ = validator.isValid
                        let errors = ["You need to be at least 18 years old to use this app"]
                        expect(validator.errors).to(equal(errors))
                    }
                }
                

            }
        }
    }
    
}
