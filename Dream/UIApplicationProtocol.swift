//
//  UIApplicationProtocol.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/14/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

protocol UIApplicationProtocol {
    var keyWindow: UIWindow? { get }
}

extension UIApplication: UIApplicationProtocol {}
