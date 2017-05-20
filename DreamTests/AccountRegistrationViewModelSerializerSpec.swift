//
//  AccountRegistrationViewModelSerializerSpec.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 5/19/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Dream

class AccountRegistrationViewModelSerializerSpec: QuickSpec {
    
    override func spec() {
        
        describe("AccountRegistrationViewModelSerializer") {
            
            describe("serialize") {
                
                var serializer: AccountRegistrationViewModelSerializer!
                var user: AccountRegistrationViewModel!
                
                beforeEach {
                    let birthdate = Date(timeIntervalSince1970: 0)
                    user = AccountRegistrationViewModel.create(birthdate: birthdate)
                    serializer = AccountRegistrationViewModelSerializer()
                }
                
                it("creates the expected dictionary") {
                    let expected: [String: Any] = [
                        "email": user.email,
                        "password": user.password,
                        "password_confirmation": user.passwordConfirmation,
                        "birthdate": user.birthdate
                    ]
                    let actual = serializer.serialize(from: user)
                    expect(actual.description).to(equal(expected.description))
                }
            }
        }
    }
    
}
