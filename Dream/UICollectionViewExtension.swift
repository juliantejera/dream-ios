//
//  UICollectionViewExtension.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/17/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier \(identifier)")
        }
        
        return cell
    }
    
}
