//
//  PhotoCollectionViewCellConfigurer.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/28/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

struct PhotoCollectionViewCellConfigurer {
    
    private let imageNetworkManager: ImageNetworkManagerProtocol
    
    init(imageNetworkManager: ImageNetworkManagerProtocol = ImageNetworkManager()) {
        self.imageNetworkManager = imageNetworkManager
    }
    
    func configure(cell: PhotoCollectionViewCell, photo: Photo) {
        imageNetworkManager.request(url: photo.url) { (image) in
            cell.imageView.image = image
        }
    }
}
