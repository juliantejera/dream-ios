//
//  PhotoCollectionViewCellConfigurerTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/28/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class PhotoCollectionViewCellConfigurerTests: XCTestCase {
    
    var photo: Photo!
    var cell: PhotoCollectionViewCell!
    var imageView: UIImageView!
    var configurer: PhotoCollectionViewCellConfigurer!
    var imageNetworkManager: MockImageNetworkManager!

    override func setUp() {
        super.setUp()
        photo = Photo.create()
        cell = PhotoCollectionViewCell(frame: .zero)
        imageView = UIImageView(frame: .zero)
        cell.imageView = imageView
        imageNetworkManager = MockImageNetworkManager()
        imageNetworkManager.image = UIImage()
        configurer = PhotoCollectionViewCellConfigurer(imageNetworkManager: imageNetworkManager)
    }

    func test_configure_whenTheImageNetworkManagerCompletes_itUpdatesTheImage() {
        configurer.configure(cell: cell, photo: photo)
        let actual = cell.imageView.image
        let expected = imageNetworkManager.image
        XCTAssertEqual(actual, expected)
    }
    
}
