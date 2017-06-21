//
//  UserCollectionViewCell.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/17/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = UIImage(named: "silhouette")
    }
}
