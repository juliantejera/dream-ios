//
//  AppDelegate.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 1/14/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var authenticationController: AuthenticationController
    
    private var initialViewController: UIViewController? {
        return authenticationController.extract() == nil ? UIStoryboard.auth.instantiateInitialViewController() : UIStoryboard.home.instantiateInitialViewController()
    }
    
    override convenience init() {
        self.init(authenticationController: AuthenticationController())
    }
    
    init(authenticationController: AuthenticationController) {
        self.authenticationController = authenticationController
        super.init()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window?.rootViewController = initialViewController
        return true
    }

}

