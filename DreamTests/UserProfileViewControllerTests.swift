//
//  UserProfileViewControllerTests.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/29/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import XCTest
@testable import Dream

class UserProfileViewControllerTests: XCTestCase {
    
    var navigationController: UINavigationController!
    var controller: UserProfileViewController!
    var imageNetworkManager: MockImageNetworkManager!

    override func setUp() {
        super.setUp()
        controller = createUserProfileViewController()
        controller.user = User.create()
        imageNetworkManager = MockImageNetworkManager()
        imageNetworkManager.image = UIImage()
        controller.photoCollectionViewCellConfigurer = PhotoCollectionViewCellConfigurer(imageNetworkManager: imageNetworkManager)
        controller.loadView()
        navigationController = UINavigationController(rootViewController: controller)
        controller.viewDidLoad()
    }
    
    private func createUserProfileViewController() -> UserProfileViewController {
        return UIStoryboard.users.instantiateViewController()
    }

    func test_viewDidLoad_configuresThePageControl() {
        controller.viewDidLoad()
        let actual = controller.pageControl.numberOfPages
        let expected = controller.user.photos.count
        XCTAssertEqual(actual, expected)
    }
    
    func test_cellForItemAtIndexPath_configuresTheCell() throws {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = try JTAssertNotNilAndUnwrap(controller.photoCollectionViewDataSource?.collectionView(controller.collectionView, cellForItemAt: indexPath) as? PhotoCollectionViewCell)
        XCTAssertEqual(cell.imageView.image, imageNetworkManager.image)
    }
    
    func test_prefersStatusBarHidden_isTrue() {
        XCTAssert(controller.prefersStatusBarHidden)
    }
    
    func test_viewWillAppear_makesTheNavigationBarTransparent() {
        controller.viewWillAppear(false)
        XCTAssertNotNil(navigationController.navigationBar.backgroundImage(for: .default))
        XCTAssertNotNil(navigationController.navigationBar.shadowImage)
    }
    
    func test_viewWillDisappear_restoresTheNavigationBar() {
        controller.viewWillDisappear(false)
        XCTAssertNil(navigationController.navigationBar.backgroundImage(for: .default))
        XCTAssertNil(navigationController.navigationBar.shadowImage)
    }
}
