//
//  RegisterAccountTableViewControllerSpec.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 5/19/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit
@testable import Dream
import Quick
import Nimble

class RegisterAccountTableViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        describe("RegisterAccountTableViewController") {
            
            var controller: RegisterAccountTableViewController!
            var client: MockNetworkClient!
            
            beforeEach {
                let storyboard = UIStoryboard(name: "Auth", bundle: nil)
                controller = storyboard.instantiateViewController(withIdentifier: "RegisterAccountTableViewController") as? RegisterAccountTableViewController
                
                client = MockNetworkClient()
                controller.manager = AuthenticationNetworkManager(client: client)
                controller.loadView()
            }
            
            describe("emailTextField") {
                
                it("gets configured") {
                    expect(controller.emailTextField.keyboardType).to(equal(UIKeyboardType.emailAddress))
                    expect(controller.emailTextField.autocorrectionType).to(equal(UITextAutocorrectionType.no))
                    expect(controller.emailTextField.delegate).to(beIdenticalTo(controller))
                    expect(controller.emailTextField.returnKeyType).to(equal(UIReturnKeyType.next))
                }
                
            }
            
            describe("passwordTextField") {
                it("gets configured") {
                    expect(controller.passwordTextField.isSecureTextEntry).to(beTrue())
                    expect(controller.passwordTextField.autocorrectionType).to(equal(UITextAutocorrectionType.no))
                    expect(controller.passwordTextField.delegate).to(beIdenticalTo(controller))
                    expect(controller.passwordTextField.returnKeyType).to(equal(UIReturnKeyType.next))
                }
            }
            
            describe("passwordConfirmationTextField") {
                
                it("gets configured") {
                    expect(controller.passwordConfirmationTextField.isSecureTextEntry).to(beTrue())
                    expect(controller.passwordConfirmationTextField.autocorrectionType).to(equal(UITextAutocorrectionType.no))
                    expect(controller.passwordConfirmationTextField.delegate).to(beIdenticalTo(controller))
                    expect(controller.passwordConfirmationTextField.returnKeyType).to(equal(UIReturnKeyType.next))
                }
                
            }
            
            describe("birthdateTextField") {
                
                it("gets configured") {
                    expect(controller.passwordConfirmationTextField.delegate).to(beIdenticalTo(controller))
                    expect(controller.birthdateTextField.inputView is UIDatePicker).to(beTrue())
                }
                
            }
            
            
            describe("viewDidLoad") {
                
                beforeEach {
                    controller.viewDidLoad()
                }
                
                describe("tableView") {
                    it("has an on drag keyboard dismiss mode") {
                        expect(controller.tableView.keyboardDismissMode).to(equal(UIScrollViewKeyboardDismissMode.onDrag))
                    }
                }
            }
            
        }
    }
    
}
