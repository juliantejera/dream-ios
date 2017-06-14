//
//  AuthStoryboardFactory.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/13/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

struct AuthStoryboardFactory {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard.auth
    }
    
    static var registerAccountTableViewController: RegisterAccountTableViewController {
        return storyboard.instantiateViewController(withIdentifier: "RegisterAccountTableViewController") as! RegisterAccountTableViewController
    }
    
    static var homeAuthTableViewController: HomeAuthTableViewController {
        return storyboard.instantiateViewController(withIdentifier: "HomeAuthTableViewController") as! HomeAuthTableViewController
    }
    
    static var signInTableViewController: SignInTableViewController {
        return storyboard.instantiateViewController(withIdentifier: "SignInTableViewController") as! SignInTableViewController
    }
    
    static var forgotPasswordTableViewController: ForgotPasswordTableViewController {
        return storyboard.instantiateViewController(withIdentifier: "ForgotPasswordTableViewController") as!ForgotPasswordTableViewController
    }
}
