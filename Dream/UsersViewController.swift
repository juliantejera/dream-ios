//
//  UsersViewController.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/13/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UserCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = UIDevice.current.orientation.isPortrait ? 3.0 : 5.0
        let marginsAndInsets: CGFloat = collectionViewFlowLayout.sectionInset.left + collectionViewFlowLayout.sectionInset.right + collectionViewFlowLayout.minimumInteritemSpacing * (itemsPerRow - 1)
        let width: CGFloat = (collectionView.frame.width - marginsAndInsets) / itemsPerRow
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
            self.collectionViewFlowLayout.invalidateLayout()
        }, completion: nil)
    }
}
