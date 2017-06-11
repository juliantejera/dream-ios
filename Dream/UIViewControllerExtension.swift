//
//  UIViewControllerExtension.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/10/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func createActivityIndicatorView() -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.center = self.view.center
        return activityIndicatorView
    }
    
    func presentAlertController(title: String, errors: [String]) {
        let message = errors.joined(separator: "\n")
        self.present(createAlertController(title: title, message: message), animated: true, completion: nil)
    }
    
    func createAlertController(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        return alertController
    }
    
}
