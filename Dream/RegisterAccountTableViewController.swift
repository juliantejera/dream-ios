//
//  RegisterAccountTableViewController.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 1/17/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

protocol RegisterAccountTableViewControllerDelegate: class {
    func registerAccountTableViewControllerDidCreateAccount(controller: RegisterAccountTableViewController)
}

class RegisterAccountTableViewController: UITableViewController, UITextFieldDelegate {

    var viewModel = AccountRegistrationViewModel(email: "", password: "", passwordConfirmation: "", birthdate: Date())
    var manager = AuthenticationNetworkManager(client: DreamNetworkClient())
    weak var delegate: RegisterAccountTableViewControllerDelegate?
    
    
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem! 
    
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            configure(textField: emailTextField)
            emailTextField.keyboardType = .emailAddress
            emailTextField.text = viewModel.email
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            configure(textField: passwordTextField)
            passwordTextField.isSecureTextEntry = true
            passwordTextField.text = viewModel.password
        }
    }
    
    @IBOutlet weak var passwordConfirmationTextField: UITextField! {
        didSet {
            configure(textField: passwordConfirmationTextField)
            passwordConfirmationTextField.isSecureTextEntry = true
            passwordConfirmationTextField.text = viewModel.passwordConfirmation
        }
    }
    
    @IBOutlet weak var birthdateTextField: UITextField! {
        didSet {
            birthdateTextField.delegate = self
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            datePicker.addTarget(self, action: #selector(birthdateChanged(datePicker:)), for: .valueChanged)
            birthdateTextField.inputView = datePicker
        }
    }
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = self.createActivityIndicatorView()
        self.view.addSubview(activityIndicatorView)
        return activityIndicatorView
    }()

    
    private func configure(textField: UITextField) {
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.returnKeyType = .next
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.keyboardDismissMode = .onDrag
    }
    
    @IBAction func registerAccount(_ sender: UIBarButtonItem) {
        guard !activityIndicatorView.isAnimating else {
            return
        }
        
        let validator = AccountRegistrationViewModelValidator(viewModel: viewModel)
        
        guard validator.isValid else {
            self.presentAlertController(title: "Validation errors", errors: validator.errors)
            return
        }
        
        activityIndicatorView.startAnimating()
        manager.register(user: viewModel) { (result) in
            switch result {
            case .success(_):
                self.delegate?.registerAccountTableViewControllerDidCreateAccount(controller: self)
            case .failure(let errors):
                self.presentAlertController(title: "🙈", errors: errors)
            }
            
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordConfirmationTextField.becomeFirstResponder()
        case passwordConfirmationTextField:
            birthdateTextField.becomeFirstResponder()
        default:
            break
        }
        
        return true
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        self.viewModel.email = emailTextField.text ?? ""
        self.viewModel.password = passwordTextField.text ?? ""
        self.viewModel.passwordConfirmation = passwordConfirmationTextField.text ?? ""
    }
    
    func birthdateChanged(datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        self.birthdateTextField.text = formatter.string(from: datePicker.date)
        self.viewModel.birthdate = datePicker.date
    }
}

