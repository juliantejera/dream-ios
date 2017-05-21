//
//  MockUITextField.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 5/20/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

class MockUITextField: UITextField {
    
    var didBecomeFirstResponder = 0
    
    override func becomeFirstResponder() -> Bool {
        didBecomeFirstResponder += 1
        return true
    }
}
