//
//  PhotoCollectionViewCellTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/29/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class PhotoCollectionViewCellTests: XCTestCase {
    
    var cell: PhotoCollectionViewCell!
    var imageView: UIImageView!
    
    override func setUp() {
        super.setUp()
        cell = PhotoCollectionViewCell(frame: .zero)
        imageView = UIImageView(frame: .zero)
        cell.imageView = imageView
    }
    
    func test_prepareForReuse_itNilsTheImageView() {
        imageView.image = UIImage()
        cell.prepareForReuse()
        XCTAssertNil(cell.imageView.image)
    }
    
}
