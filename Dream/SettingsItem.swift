//
//  SettingsItem.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/14/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

enum SettingsItem: Int {
    
    case signOut
    
    var title: String {
        switch self {
        case .signOut:
            return "Sign out"
        }
    }
    
    static let count = 1

}
