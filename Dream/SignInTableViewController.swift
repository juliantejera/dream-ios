//
//  SignInTableViewController.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 5/31/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

protocol SignInTableViewControllerDelegate: class {
    func signInTableViewControllerDidSignIn(_ controller: SignInTableViewController)
}

class SignInTableViewController: UITableViewController {
    
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.keyboardType = .emailAddress
            emailTextField.returnKeyType = .next
            configure(textField: emailTextField)
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
            passwordTextField.returnKeyType = .send
            configure(textField: passwordTextField)
        }
    }
    
    var viewModel = SignInViewModel(email: "", password: "")
    var manager = AuthenticationNetworkManager(client: DreamNetworkClient())
    weak var delegate: SignInTableViewControllerDelegate?
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.center = self.tableView.center
        self.view.addSubview(activityIndicatorView)
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.keyboardDismissMode = .onDrag
    }
    
    @IBAction func signIn() {
        guard !activityIndicatorView.isAnimating else {
            return
        }
        
        let validator = SignInViewModelValidator(viewModel: viewModel)
        
        guard validator.isValid else {
            self.presentAlertController(title: "Validation errors", errors: validator.errors)
            return
        }
        
        activityIndicatorView.startAnimating()
        manager.signIn(user: viewModel) { (result) in
            switch result {
            case .success(_):
                self.delegate?.signInTableViewControllerDidSignIn(self)
            case .failure(let errors):
                self.presentAlertController(title: "🙈", errors: errors)
            }
            
            self.activityIndicatorView.stopAnimating()
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

extension SignInTableViewController: UITextFieldDelegate {
    
    fileprivate func configure(textField: UITextField) {
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        viewModel.email = emailTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            signIn()
        default:
            break
        }
        
        return true
    }
    
}
