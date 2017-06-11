//
//  ErrorsParserSpec.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 5/13/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

@testable import Dream
import Quick
import Nimble

class ErrorsParserSpec: QuickSpec {
    
    override func spec() {
        
        describe("ErrorsParserSpec") {
            
            describe("parse") {
                
                var parser: ErrorsParser!
                var errors: [String]!
                
                beforeEach {
                    parser = ErrorsParser()
                }
                
                context("when the dictionary is valid") {
                    beforeEach {
                        errors = parser.parse(from: self.fixture(name: "errors_parser_valid"))
                    }
                    
                    it("returns the correct error messages") {
                        let expectedErrors = ["Error 1", "Error 2"]
                        expect(errors).to(equal(expectedErrors))
                    }
                }
                
                context("when we are getting an error message from the sign in endpoint") {
                    beforeEach {
                        errors = parser.parse(from: ["errors": ["hello world"]])
                    }
                    
                    it("returns the correct error messages") {
                        expect(errors).to(equal(["hello world"]))
                    }
                }

                
                context("when the dictionary is not valid") {
                    beforeEach {
                        errors = parser.parse(from: [:])
                    }
                    
                    it("returns nil") {
                        expect(errors).to(beNil())
                    }
                }


            }
        }
    }
    
}
