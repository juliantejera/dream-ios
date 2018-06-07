//
//  MockUIApplicationProtocol.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/15/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit
@testable import Dream

class MockUIApplication: UIApplicationProtocol {
    var keyWindow: UIWindow?
    
    init() {
        keyWindow = UIWindow()
    }
    
    var canOpenUrl = true
    func canOpenURL(_ url: URL) -> Bool {
        return canOpenUrl
    }
    
    var openUrlCallCount = 0    
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?) {
        openUrlCallCount += 1
    }
}
