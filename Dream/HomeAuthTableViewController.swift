//
//  HomeAuthTableViewController.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 4/23/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit


class HomeAuthTableViewController: UITableViewController, RegisterAccountTableViewControllerDelegate {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // MARK: - RegisterAccountTableViewControllerDelegate
    func registerAccountTableViewControllerDidCreateAccount(controller: RegisterAccountTableViewController) {
//        _ = self.navigationController?.popViewController(animated: false)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? RegisterAccountTableViewController, segue.identifier == "RegisterAccountTableViewControllerSegue" {
            destination.delegate = self
        }
    }
}
