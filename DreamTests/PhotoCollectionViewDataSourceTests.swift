//
//  PhotoCollectionViewDataSourceTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 7/6/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class PhotoCollectionViewDataSourceTests: XCTestCase {
    
    var dataSource: PhotoCollectionViewDataSource!
    var delegate: MockPhotoCollectionViewDataSourceDelegate!
    var collectionView: UICollectionView!
    
    override func setUp() {
        super.setUp()
        
        let layout = UICollectionViewFlowLayout()
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        let imageNetworkManager = MockImageNetworkManager()
        imageNetworkManager.image = UIImage()
        let cellConfigurer = PhotoCollectionViewCellConfigurer(imageNetworkManager: imageNetworkManager)
        dataSource = PhotoCollectionViewDataSource(photos: [Photo.create()], collectionView: collectionView, collectionViewFlowLayout: layout, cellConfigurer: cellConfigurer)
        delegate = MockPhotoCollectionViewDataSourceDelegate()
        dataSource.delegate = delegate
    }
    
    func test_scrollViewDidEndDecelerating_informsTheDelegate() {
        dataSource.scrollViewDidEndDecelerating(collectionView)
        let actual = delegate.index
        let expected = 0
        XCTAssertEqual(actual, expected)
    }
    
}
