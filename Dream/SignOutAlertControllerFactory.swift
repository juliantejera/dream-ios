//
//  SignOutAlertControllerFactory.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/15/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

struct SignOutAlertControllerFactory {
    
    private let authenticationController: AuthenticationController
    private let application: UIApplicationProtocol
    
    init(authenticationController: AuthenticationController = AuthenticationController(),
         application: UIApplicationProtocol = UIApplication.shared) {
        self.authenticationController = authenticationController
        self.application = application
    }
    
    func create() -> UIAlertController {
        let title = "Hey cutie 😉"
        let message = "Are you sure you want to sign out? 🤔"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(optOutAction)
        alertController.addAction(signOutAction)
        return alertController
    }
    
    private var signOutAction: UIAlertAction {
        let title = "Sign out"
        return UIAlertAction(title: title, style: .destructive, handler: { (action) in
            self.signOut()
        })
    }
    
    private var optOutAction: UIAlertAction {
        let title = "No"
        return UIAlertAction(title: title, style: .default, handler: nil)
    }
    
    func signOut() {
        guard let window = application.keyWindow else {
            return
        }
        
        authenticationController.removeToken()
        let options: UIViewAnimationOptions = [.curveEaseInOut, .transitionCrossDissolve]
        UIView.transition(with: window, duration: 0.3, options: options, animations: {
            window.rootViewController = UIStoryboard.auth.instantiateInitialViewController()
        }, completion: nil)
    }

}
