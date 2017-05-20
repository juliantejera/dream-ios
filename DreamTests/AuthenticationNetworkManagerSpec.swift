//
//  AuthenticationNetworkManagerSpec.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 5/19/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Dream

class AuthenticationNetworkManagerSpec: QuickSpec {
    
    override func spec() {
        
        describe("AuthenticationNetworkManager") {
            
            describe("register") {
                var manager: AuthenticationNetworkManager!
                var client: MockNetworkClient!
                var user: AccountRegistrationViewModel!
                
                beforeEach {
                    user = AccountRegistrationViewModel.create()
                    client = MockNetworkClient()
                    manager = AuthenticationNetworkManager(client: client)
                }
                
                context("when the network request succeeds") {
                    
                    beforeEach {
                        client.response = self.fixture(name: "authentication_network_manager_register_success")
                    }
                    
                    it("returns a successful result") {
                        manager.register(user: user) { (result) in
                            JTAssertNetworkClientResultSucceeds(result)
                        }
                    }
                }
                
                context("when the network request fails") {
                    beforeEach {
                        client.response = nil
                    }
                    
                    it("returns a failed result") {
                        manager.register(user: user) { (result) in
                            JTAssertNetworkClientResultFails(result)
                        }
                    }
                }


            }
        }
    }
    
}
