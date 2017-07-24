//
//  PhotoLibraryViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/14/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//
import UIKit
import FirebaseDatabase
import Kingfisher

class LibraryViewController: UIViewController {
  
  var user: User!
  var photoCollection = [Photos]()
  var profileHandle: DatabaseHandle = 0
  var profileRef: DatabaseReference?
  let flowLayout = UICollectionViewFlowLayout()
  var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    let photoLibraryTabBar = UITabBarItem(title: "Library", image: #imageLiteral(resourceName: "pictures"), selectedImage: nil)
    tabBarItem = photoLibraryTabBar
    
    self.navigationItem.title = "Library"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(selectButtonTapped(sender:)))
    self.navigationItem.rightBarButtonItem?.tintColor = .white
    
    collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
    collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: "PhotoCollectionCell")
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .white
    
    self.view.addSubview(collectionView)
    
    user = user ?? User.current
    profileHandle = UserService.observeProfile(for: user) { [unowned self] (ref, user, photos) in
      self.profileRef = ref
      self.user = user
      self.photoCollection = photos.sorted(by: {$0.creationDate > $1.creationDate})
      
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  func selectButtonTapped(sender: UIBarButtonItem) {
    print("select photos")
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    UserService.photos(for: user) { (Photos) in
      self.photoCollection = Photos.sorted(by: {$0.creationDate > $1.creationDate})
      
      self.collectionView.reloadData()
    }
  }
  
  deinit {
    profileRef?.removeObserver(withHandle: profileHandle)
  }
}

extension LibraryViewController: UICollectionViewDelegate {
  
  //tapping on a cell and displaying the image
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let vc = PhotoViewController()
    let indexPaths = self.collectionView.indexPathsForSelectedItems
    let indexPath = indexPaths![0]
    let photo = photoCollection[indexPath.row]
    let imageURL = URL(string: photo.imageURL)
    
    vc.photoImageView.kf.setImage(with: imageURL)
    
    let nc = UINavigationController(rootViewController: vc)
    let photoURLs: [String]  = photoCollection.map {$0.imageURL}
    
    vc.urls = imageURL
    vc.newPhotoURLs = photoURLs
    vc.numImages = self.photoCollection.count
    self.present(nc, animated: true, completion: nil)
  }
}

extension LibraryViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photoCollection.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath) as! PhotoCollectionCell
    let photo = photoCollection[indexPath.row]
    let imageURL = URL(string: photo.imageURL)
    cell.thumbImageView.kf.setImage(with: imageURL)
    return cell
  }
}

extension LibraryViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let columns: CGFloat = 3
    let spacing: CGFloat = 1.5
    let totalHorizontalSpacing = (columns - 1) * spacing
    let itemWidth = (collectionView.bounds.width - totalHorizontalSpacing) / columns
    let itemSize = CGSize(width: itemWidth, height: itemWidth)
    return itemSize
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 1.5
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1.5
  }
}

























