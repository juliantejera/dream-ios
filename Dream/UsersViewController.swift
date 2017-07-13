//
//  UsersViewController.swift
//  Dream
//
//  Created by Julian Tejera-Frias on 6/13/17.
//  Copyright © 2017 Julian Tejera. All rights reserved.
//

import UIKit
import CoreLocation

class UsersViewController: UIViewController {
    
    struct Segues {
        static let userProfile = "UserProfileViewControllerSegue"
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView?.alwaysBounceVertical = true
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(fetchUsers), for: .valueChanged)
            collectionView?.refreshControl = refreshControl
        }
    }
    
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    var users = [User]()
    var userNetworkManager = UserNetworkManager(client: DreamNetworkClient())
    var cellConfigurer = UserCollectionViewCellConfigurer()
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        return ActivityIndicatorViewFactory.create(superview: self.view)
    }()
    
    var locationObserver: LocationObserver?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationObserver = LocationObserver()
        locationObserver?.delegate = self
        locationObserver?.startObserving(manager: CLLocationManager())
        fetchUsers()
    }
    
    func fetchUsers() {
        guard !activityIndicatorView.isAnimating || !collectionView.refreshControl!.isRefreshing else {
            return
        }
        
        if !collectionView.refreshControl!.isRefreshing {
            activityIndicatorView.startAnimating()
        }
        
        userNetworkManager.findAll(limit: 50, radius: 5000) { (result) in
            switch result {
            case .success(let users):
                self.users = users
                self.collectionView.reloadData()
            case .failure(let errors):
                self.presentAlertController(title: "🙈", errors: errors)
            }
            
            self.activityIndicatorView.stopAnimating()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
            self.collectionViewFlowLayout.invalidateLayout()
        }, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserProfileViewController,
           let indexPath = sender as? IndexPath, segue.identifier == Segues.userProfile {
            destination.user = users[indexPath.item]
        }
    }
}

extension UsersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UserCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let user = users[indexPath.row]
        cellConfigurer.configure(cell: cell, user: user)
        return cell
    }
    
}

extension UsersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.userProfile, sender: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = UIDevice.current.orientation.isPortrait ? 3.0 : 5.0
        let marginsAndInsets: CGFloat = collectionViewFlowLayout.sectionInset.left + collectionViewFlowLayout.sectionInset.right + collectionViewFlowLayout.minimumInteritemSpacing * (itemsPerRow - 1)
        let width: CGFloat = (collectionView.frame.width - marginsAndInsets) / itemsPerRow
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
}

extension UsersViewController: LocationObserverDelegate {
    
    func locationObserver(_ observer: LocationObserver, didFailWithError error: Error) {
        let controller = LocationPermissionAlertControllerFactory().create()
        present(controller, animated: true, completion: nil)
    }
    
    func locationObserver(_ observer: LocationObserver, didUpdateLocation location: CLLocation) {
    }
}
