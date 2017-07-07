//
//  MockPhotoCollectionViewDataSourceDelegate.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 7/6/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import Foundation
@testable import Dream

class MockPhotoCollectionViewDataSourceDelegate: PhotoCollectionViewDataSourceDelegate {
    
    var index: Int?
    
    func photoCollectionViewDataSource(dataSource: PhotoCollectionViewDataSource, scrolledToPhotoAtIndex index: Int) {
        self.index = index
    }
}
