//
//  UserCollectionViewCellConfigurer.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/19/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

class UserCollectionViewCellConfigurer {
    
    private let imageNetworkManager: ImageNetworkManagerProtocol
    private let lengthFormatter: LengthFormatter
    private let defaultImage: UIImage?
    private var tasksInProgress: [IndexPath: URLSessionTaskProtocol]
    
    init(imageNetworkManager: ImageNetworkManagerProtocol = ImageNetworkManager(),
         defaultImage: UIImage? = UIImage.silhouette) {
        self.imageNetworkManager = imageNetworkManager
        self.defaultImage = defaultImage
        self.lengthFormatter = LengthFormatter()
        self.tasksInProgress = [IndexPath: URLSessionTaskProtocol]()
    }

    func configure(cell: UserCollectionViewCell, user: User, indexPath: IndexPath) {
        if let url = user.photos.first?.url {
            request(imageView: cell.imageView, url: url, indexPath: indexPath)
        } else {
            cell.imageView.image = defaultImage
        }
        cell.distanceLabel.text = lengthFormatter.string(fromValue: user.distance, unit: .mile)
    }
    
    func cancelImageRequest(indexPath: IndexPath) {
        tasksInProgress[indexPath]?.cancel()
    }
    
    private func request(imageView: UIImageView, url: URL, indexPath: IndexPath) {
        let task = imageNetworkManager.request(url: url) { (image) in
            imageView.image = image ?? self.defaultImage
            self.tasksInProgress[indexPath] = nil
        }
        tasksInProgress[indexPath] = task
    }
}
