//
//  PhotoCollectionViewCell.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/28/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
