//
//  SignInTableViewControllerSections.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/1/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

enum SignInTableViewControllerSections: Int {
    case credentials
    case signIn
    
    static let count: Int = 2
    
    var numberOfRows: Int {
        return 2
    }
    
}
