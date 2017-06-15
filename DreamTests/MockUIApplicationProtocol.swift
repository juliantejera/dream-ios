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
}
