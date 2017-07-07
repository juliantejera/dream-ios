//
//  UserCollectionViewCellConfigurerTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/21/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class UserCollectionViewCellConfigurerTests: XCTestCase {
    
    var cell: UserCollectionViewCell!
    var imageView: UIImageView!
    var distanceLabel: UILabel!
    var configurer: UserCollectionViewCellConfigurer!
    var imageNetworkManager: MockImageNetworkManager!
    var defaultImage: UIImage!
    var user: User!
    
    override func setUp() {
        super.setUp()
        cell = UserCollectionViewCell(frame: .zero)
        imageView = UIImageView(frame: .zero)
        distanceLabel = UILabel(frame: .zero)
        cell.imageView = imageView
        cell.distanceLabel = distanceLabel
        imageNetworkManager = MockImageNetworkManager()
        imageNetworkManager.image = UIImage.settings
        defaultImage = UIImage.silhouette
        configurer = UserCollectionViewCellConfigurer(imageNetworkManager: imageNetworkManager, defaultImage: defaultImage)
        user = User.create()
    }
    
    func test_configure_updatesTheDistanceLabel() {
        configurer.configure(cell: cell, user: user)
        let actual = cell.distanceLabel.text
        let expected = LengthFormatter().string(fromValue: user.distance, unit: .mile)
        XCTAssertEqual(actual, expected)
    }
    
    func test_configure_whenTheImageNetworkManagerSucceeds_itUpdatesTheImage() {
        configurer.configure(cell: cell, user: user)
        let actual = cell.imageView.image
        let expected = imageNetworkManager.image
        XCTAssertEqual(actual, expected)
    }
    
    func test_configure_whenTheImageNetworkManagerFails_itUsesTheDefaultImage() {
        imageNetworkManager.image = nil
        configurer.configure(cell: cell, user: user)
        let actual = cell.imageView.image
        let expected = defaultImage
        XCTAssertEqual(actual, expected)
    }
}
