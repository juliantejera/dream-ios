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
            var window: UIWindow!
            
            beforeEach {
                controller = AuthStoryboardFactory.registerAccountTableViewController
                window = UIWindow()
                window.makeKeyAndVisible()
                window.rootViewController = controller
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
            
            describe("registerAccount") {
                context("when the view model is valid") {
                    
                    beforeEach {
                        controller.viewModel = AccountRegistrationViewModel.create()
                    }
                    
                    context("when the network request succeeds") {
                        
                        var delegate: MockRegisterAccountTableViewControllerDelegate!
                        
                        beforeEach {
                            client.response = self.fixture(name: "authentication_network_manager_register_success")
                            delegate = MockRegisterAccountTableViewControllerDelegate()
                            controller.delegate = delegate
                        }
                        
                        it("informs the delegate") {
                            controller.registerAccount(UIBarButtonItem())
                            expect(delegate.didCreateAccount).to(equal(1))
                        }
                        
                    }
                    
                    context("when the network request fails") {
                        it("presents an error alert") {
                            controller.registerAccount(UIBarButtonItem())
                            expect(controller.presentedViewController is UIAlertController).to(beTrue())
                        }
                    }

                }
                
                context("when the view model is not valid") {
                    it("displays validation errors") {
                        controller.registerAccount(UIBarButtonItem())
                        expect(controller.presentedViewController is UIAlertController).to(beTrue())
                    }
                }
            }
            
            describe("textFieldShouldReturn") {
                
                var textField: MockUITextField!
                
                beforeEach {
                    textField = MockUITextField()
                }
                
                context("when the emailTextField is sent as an argument") {
                    
                    beforeEach {
                        controller.passwordTextField = textField
                        _ = controller.textFieldShouldReturn(controller.emailTextField)
                    }
                    
                    it("makes the passwordTextField the first responder") {
                        expect(textField.didBecomeFirstResponder).to(equal(1))
                    }

                }
                
                context("when the passwordTextField is sent as an argument") {
                    
                    beforeEach {
                        controller.passwordConfirmationTextField = textField
                        _ = controller.textFieldShouldReturn(controller.passwordTextField)
                    }
                    
                    it("makes the passwordConfirmationTextField the first responder") {
                        expect(textField.didBecomeFirstResponder).to(equal(1))
                    }
                }
                
                context("when the passwordConfirmationTextField is sent as an argument") {
                    
                    beforeEach {
                        controller.birthdateTextField = textField
                        _ = controller.textFieldShouldReturn(controller.passwordConfirmationTextField)
                    }
                    
                    it("makes the birthdateTextField the first responder") {
                        expect(textField.didBecomeFirstResponder).to(equal(1))
                    }
                }
                
            }
            
            describe("textFieldDidChange") {
                
                beforeEach {
                    controller.emailTextField.text = "woo@gmail.com"
                    controller.passwordTextField.text = "password123"
                    controller.passwordConfirmationTextField.text = "123password"
                    controller.textFieldDidChange(controller.emailTextField)
                }
                
                it("updates the view model") {
                    expect(controller.viewModel.email).to(equal(controller.emailTextField.text))
                    expect(controller.viewModel.password).to(equal(controller.passwordTextField.text))
                    expect(controller.viewModel.passwordConfirmation).to(equal(controller.passwordConfirmationTextField.text))
                }
                
            }
            
            describe("birthdateChanged") {
                var formatter: DateFormatter!
                var datePicker: UIDatePicker!
                
                beforeEach {
                    controller.viewModel = AccountRegistrationViewModel.create()
                    datePicker = UIDatePicker()
                    datePicker.datePickerMode = .date
                    formatter = DateFormatter()
                    formatter.dateStyle = .medium
                    controller.birthdateChanged(datePicker: datePicker)
                }
                
                it("updates the text field") {
                    let expectedDate = formatter.string(from: datePicker.date)
                    expect(controller.birthdateTextField.text).to(equal(expectedDate))
                }
                
                it("updates the view model") {
                    expect(controller.viewModel.birthdate).to(equal(datePicker.date))
                }
            }
            
        }
        
    }
    
}

class MockRegisterAccountTableViewControllerDelegate: RegisterAccountTableViewControllerDelegate {
    
    var didCreateAccount = 0
    
    func registerAccountTableViewControllerDidCreateAccount(controller: RegisterAccountTableViewController) {
        didCreateAccount += 1
    }
}
