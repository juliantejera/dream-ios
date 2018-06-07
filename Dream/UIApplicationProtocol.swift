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
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?)
}

extension UIApplication: UIApplicationProtocol {}
