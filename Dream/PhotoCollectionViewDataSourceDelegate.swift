//
//  PhotoCollectionViewDataSourceDelegate.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 7/1/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation

protocol PhotoCollectionViewDataSourceDelegate: class {
    func photoCollectionViewDataSource(dataSource: PhotoCollectionViewDataSource, scrolledToPhotoAtIndex index: Int)
}
