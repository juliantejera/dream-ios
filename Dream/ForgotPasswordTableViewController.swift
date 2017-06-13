//
//  ForgotPasswordTableViewController.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/11/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

class ForgotPasswordTableViewController: UITableViewController {

    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.keyboardType = .emailAddress
            emailTextField.autocorrectionType = .no
            emailTextField.returnKeyType = .send
            emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = self.createActivityIndicatorView()
        self.view.addSubview(activityIndicatorView)
        return activityIndicatorView
    }()
    
    var email: String = ""
    var manager = AuthenticationNetworkManager(client: DreamNetworkClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.text = email
    }
    
    @IBAction func sendForgotPasswordRequest(_ sender: UIBarButtonItem) {
        guard !activityIndicatorView.isAnimating else {
            return
        }
        let validator = EmailValidator(email: email)
        guard validator.isValid else {
            self.presentAlertController(title: "Validation errors", errors: validator.errors)
            return
        }
        
        activityIndicatorView.startAnimating()
        
        manager.forgotPassword(email: email) { (result) in
            switch result {
            case .success(let message):
                self.present(self.forgotPasswordAlertController(message: message), animated: true, completion: nil)
            case .failure(let errors):
                self.presentAlertController(title: "🙈", errors: errors)
            }
            
            self.activityIndicatorView.stopAnimating()
        }
        
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        email = emailTextField.text ?? ""
    }

    private func forgotPasswordAlertController(message: String) -> UIAlertController {
        let alertController = UIAlertController(title: "Email sent 📧", message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        return alertController
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "We will send you an email with further instructions to reset your password"
    }

}
