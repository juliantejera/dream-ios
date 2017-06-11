//
//  SignInTableViewController.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 5/31/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

class SignInTableViewController: UITableViewController {
    
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet {
            emailTextField.keyboardType = .emailAddress
        }
    }
    
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    var viewModel = SignInViewModel(email: "", password: "")
    var manager = AuthenticationNetworkManager(client: DreamNetworkClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.keyboardDismissMode = .onDrag
    }
    
    @IBAction func signIn() {
        viewModel.email = emailTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        
        let validator = SignInViewModelValidator(viewModel: viewModel)
        if validator.isValid {
            manager.signIn(user: viewModel) { (result) in
                switch result {
                case .success(let response):
                    print(response)
                case .failure(let errors):
                    self.presentAlertController(title: "🙈", errors: errors)
                }
            }
        } else {
            self.presentAlertController(title: "Validation errors", errors: validator.errors)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return SignInTableViewControllerSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SignInTableViewControllerSections(rawValue: section)!.numberOfRows
    }
    

}
