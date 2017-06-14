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
        return storyboard.instantiateViewController()
    }
    
    static var homeAuthTableViewController: HomeAuthTableViewController {
        return storyboard.instantiateViewController()
    }
    
    static var signInTableViewController: SignInTableViewController {
        return storyboard.instantiateViewController()
    }
    
    static var forgotPasswordTableViewController: ForgotPasswordTableViewController {
        return storyboard.instantiateViewController()
    }
}
