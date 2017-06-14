//
//  MockUINavigationController.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/12/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

class MockUINavigationController: UINavigationController {
    
    var didPopViewController: Int = 0
    
    override func popViewController(animated: Bool) -> UIViewController? {
        didPopViewController += 1
        return nil
    }

}

