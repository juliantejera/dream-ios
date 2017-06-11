//
//  MockSignInTableViewControllerDelegate.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/10/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

@testable import Dream

class MockSignInTableViewControllerDelegate: SignInTableViewControllerDelegate {
    
    var didSignIn = 0
    
    func signInTableViewControllerDidSignIn(_ controller: SignInTableViewController) {
        didSignIn += 1
    }
}
