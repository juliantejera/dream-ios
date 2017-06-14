//
//  HomeAuthTableViewController.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/23/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit


class HomeAuthTableViewController: UITableViewController {
    
    struct Segues {
        static let homeViewController = "HomeViewControllerSegue"
        static let registerAccountTableViewController = "RegisterAccountTableViewControllerSegue"
        static let signInTableViewController = "SignInTableViewControllerSegue"
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 120.0
            imageView.layer.masksToBounds = true
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.borderWidth = 3.0
        }
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RegisterAccountTableViewController {
            destination.delegate = self
        } else if let destination = segue.destination as? SignInTableViewController {
            destination.delegate = self
        }
    }
}


extension HomeAuthTableViewController: RegisterAccountTableViewControllerDelegate {
    
    func registerAccountTableViewControllerDidCreateAccount(controller: RegisterAccountTableViewController) {
        _ = self.navigationController?.popViewController(animated: false)
    }
    
}

extension HomeAuthTableViewController: SignInTableViewControllerDelegate {
    
    func signInTableViewControllerDidSignIn(_ controller: SignInTableViewController) {
        self.performSegue(withIdentifier: Segues.homeViewController, sender: nil)
    }
}
