//
//  PhotoCollectionViewDataSource.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 7/1/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit

class PhotoCollectionViewDataSource: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private let collectionView: UICollectionView
    private let collectionViewFlowLayout: UICollectionViewFlowLayout
    private let photos: [Photo]
    private let cellConfigurer: PhotoCollectionViewCellConfigurer
    weak var delegate: PhotoCollectionViewDataSourceDelegate?
    
    init(photos: [Photo],
         collectionView: UICollectionView,
         collectionViewFlowLayout: UICollectionViewFlowLayout,
         cellConfigurer: PhotoCollectionViewCellConfigurer = PhotoCollectionViewCellConfigurer()) {
        self.photos = photos
        self.collectionView = collectionView
        self.collectionViewFlowLayout = collectionViewFlowLayout
        self.cellConfigurer = cellConfigurer
        super.init()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let photo = photos[indexPath.item]
        cellConfigurer.configure(cell: cell, photo: photo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = collectionView.frame.height
        return CGSize(width: pageWidth, height: height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(collectionView.contentOffset.x / pageWidth)
        delegate?.photoCollectionViewDataSource(dataSource: self, scrolledToPhotoAtIndex: page)
    }

    private var pageWidth: CGFloat {
        let itemsPerRow: CGFloat = 1
        let marginsAndInsets: CGFloat = collectionViewFlowLayout.sectionInset.left + collectionViewFlowLayout.sectionInset.right + collectionViewFlowLayout.minimumInteritemSpacing * (itemsPerRow - 1)
        return (collectionView.frame.width - marginsAndInsets) / itemsPerRow
    }
    
}
