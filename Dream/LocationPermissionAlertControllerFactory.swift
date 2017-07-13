//
//  LocationPermissionAlertController.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 7/7/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

struct LocationPermissionAlertControllerFactory {
    
    private let application: UIApplicationProtocol
    
    init(application: UIApplicationProtocol = UIApplication.shared) {
        self.application = application
    }
    
    func create() -> UIAlertController {
        let title = "Listen up!"
        let message = "If we don't have access to your location, you might miss out on all the hotties around you 😉"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(enableAction)
        alertController.addAction(keepDisabledAction)
        return alertController
    }
    
    private var enableAction: UIAlertAction {
        let title = "Enable Location"
        return UIAlertAction(title: title, style: .default, handler: { (action) in
            self.openAppSettings()
        })
    }
    
    private var keepDisabledAction: UIAlertAction {
        let title = "Keep Disabled"
        return UIAlertAction(title: title, style: .default, handler: nil)
    }
    
    func openAppSettings() {
        guard let url = URL(string: UIApplicationOpenSettingsURLString), application.canOpenURL(url) else {
            return
        }
        application.open(url, options: [:], completionHandler: nil)
    }
}
