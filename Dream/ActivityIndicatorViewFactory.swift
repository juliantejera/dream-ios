//
//  ActivityIndicatorViewFactory.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/13/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

struct ActivityIndicatorViewFactory {
    
    static func create(superview: UIView) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false 
        superview.addSubview(activityIndicatorView)
        superview.addConstraints(center(view: activityIndicatorView, in: superview))
        return activityIndicatorView
    }
    
    private static func center(view: UIView, in superview: UIView) -> [NSLayoutConstraint] {
        let centerX = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1, constant: 0)
        return [centerX, centerY]
    }
    
}
