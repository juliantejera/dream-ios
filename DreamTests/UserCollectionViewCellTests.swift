//
//  UserCollectionViewCellTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/23/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class UserCollectionViewCellTests: XCTestCase {
    
    var cell: UserCollectionViewCell!
    var imageView: UIImageView!

    override func setUp() {
        super.setUp()
        cell = UserCollectionViewCell(frame: .zero)
        imageView = UIImageView(frame: .zero)
        cell.imageView = imageView
    }
    
    func test_prepareForReuse_itNilsTheImageView() {
        imageView.image = UIImage()
        cell.prepareForReuse()
        XCTAssertNil(cell.imageView.image)
    }
    
}
