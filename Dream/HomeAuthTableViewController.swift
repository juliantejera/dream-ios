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
        static let homeTabBarController = "HomeTabBarControllerSegue"
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

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
        self.performSegue(withIdentifier: Segues.homeTabBarController, sender: nil)
    }
}
