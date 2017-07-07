//
//  UserProfileViewController.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/27/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var user: User!
    var photoCollectionViewCellConfigurer = PhotoCollectionViewCellConfigurer(imageNetworkManager: ImageNetworkManager())
    var photoCollectionViewDataSource: PhotoCollectionViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionViewDataSource = PhotoCollectionViewDataSource(photos: user.photos, collectionView: collectionView, collectionViewFlowLayout: collectionViewFlowLayout, cellConfigurer: photoCollectionViewCellConfigurer)
        photoCollectionViewDataSource?.delegate = self
        pageControl.numberOfPages = user.photos.count
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
            self.collectionViewFlowLayout.invalidateLayout()
        }, completion: nil)
    }
   
}

extension UserProfileViewController: PhotoCollectionViewDataSourceDelegate {
    
    func photoCollectionViewDataSource(dataSource: PhotoCollectionViewDataSource, scrolledToPhotoAtIndex index: Int) {
        pageControl.currentPage = index
    }
    
}
