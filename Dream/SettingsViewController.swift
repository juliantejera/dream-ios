//
//  SettingsViewController.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/14/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var signOutAlertViewControllerFactory = SignOutAlertControllerFactory()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingsItemTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        if let settingsItem = SettingsItem(rawValue: indexPath.row) {
            cell.textLabel?.text = settingsItem.title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let settingsItem = SettingsItem(rawValue: indexPath.row) else {
            return
        }
        
        switch settingsItem {
        case .signOut:
            present(signOutAlertViewControllerFactory.create(), animated: true, completion: nil)
        }
    }

}
