//
//  UserCollectionViewCellConfigurer.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/19/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

struct UserCollectionViewCellConfigurer {
    
    private let imageNetworkManager: ImageNetworkManagerProtocol
    private let lengthFormatter: LengthFormatter
    private let defaultImage: UIImage?
    
    init(imageNetworkManager: ImageNetworkManagerProtocol = ImageNetworkManager(),
         defaultImage: UIImage? = UIImage(named: "silhouette")) {
        self.imageNetworkManager = imageNetworkManager
        self.defaultImage = defaultImage
        self.lengthFormatter = LengthFormatter()
    }

    func configure(cell: UserCollectionViewCell, user: User) {
        if let url = user.photos.first?.url {
            configure(imageView: cell.imageView, url: url)
        }
        cell.distanceLabel.text = lengthFormatter.string(fromValue: user.distance, unit: .mile)
    }
    
    private func configure(imageView: UIImageView, url: URL) {
        imageNetworkManager.request(url: url) { (image) in
            imageView.image = image ?? self.defaultImage
        }
    }
}
