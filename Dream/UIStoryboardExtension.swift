//
//  UIStoryboardExtension.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/1/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

extension UIStoryboard {
    class var auth: UIStoryboard {
        return UIStoryboard(name: "Auth", bundle: .main)
    }
    
    class var home: UIStoryboard {
        return UIStoryboard(name: "Home", bundle: .main)
    }
    
    class var users: UIStoryboard {
        return UIStoryboard(name: "Users", bundle: .main)
    }
}
