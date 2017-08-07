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

class LibraryViewController: DUViewController {
  
  //firebase stuff
  var user: User!

  var photoCollection = [Photos]()
  
  var forceTouchIndexPath: IndexPath?
  
  var photoCollectionSorted = [Photos]()
  
  var profileHandle: DatabaseHandle = 0
  var profileRef: DatabaseReference?
  let flowLayout = UICollectionViewFlowLayout()
  var collectionView: UICollectionView!
  
  //for select and delete photo
  var selectButtonOn = false
  var selectedPhotos = [String]()
  var selectedRows: [Int] = []
  
  lazy var longPress: UILongPressGestureRecognizer = {
    let temp = UILongPressGestureRecognizer.init(target: self, action: #selector(LibraryViewController.showPeek))
    
    return temp
  }()
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
  
    navigationItem.title = "Library"
    
    
    //select button
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(LibraryViewController.selectButtonTapped(sender:)))
    navigationItem.rightBarButtonItem?.tintColor = .white
    navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "GothamRounded-Light", size: 17)!], for: .normal)

    //deletebutton
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(LibraryViewController.deleteButtonTapped(sender:)))
    navigationItem.leftBarButtonItem?.tintColor = .clear
    navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "GothamRounded-Light", size: 17)!], for: .normal)

    
    collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
    collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: "PhotoCollectionCell")
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .white
    collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 115, right: 0)

    collectionView.addToAndConstrain(insideSuper: view)
    
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
  //iphone might not have 3D touch
  func check3DTouch() {
    
    if self.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
      self.registerForPreviewing(with: self, sourceView: self.collectionView)
      self.longPress.isEnabled = false
    }
    else {
      self.longPress.isEnabled = true
    }
  }
  
  func showPeek() {
    self.longPress.isEnabled = false
    
    let previewView = ForceTouchViewController()
    
    let presenter = self.grabTopViewController()
    
    presenter.show(previewView, sender: self)
  }
  
  func grabTopViewController() -> UIViewController {
    
    var top = UIApplication.shared.keyWindow?.rootViewController
    while((top?.presentedViewController) != nil) {
      top = top?.presentedViewController
    }
    return top!
  }
  
  func cancelButtonTapped(sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  private dynamic func selectButtonTapped(sender: UIBarButtonItem) {
    selectButtonOn = true
    collectionView.allowsMultipleSelection = true
    
    self.navigationItem.rightBarButtonItem?.tintColor = .clear
    self.navigationItem.leftBarButtonItem?.tintColor = .white
    //print("select photos")
  }
  
  private dynamic func deleteButtonTapped(sender: UIBarButtonItem) {
    //print(selectedPhotos)
    for imageUID in selectedPhotos {
      PhotoService.delete(deletePhoto: imageUID)
    }
    
    navigationItem.rightBarButtonItem?.tintColor = .white
    navigationItem.leftBarButtonItem?.tintColor = .clear
    
    selectButtonOn = false
    selectedPhotos.removeAll()
    
    user = user ?? User.current
    profileHandle = UserService.observeProfile(for: user) { [unowned self] (ref, user, photos) in
      self.profileRef = ref
      self.user = user
      self.collectionView.performBatchUpdates( { _ in
        var itemsToDelete: [IndexPath] = []
        self.photoCollection = photos.sorted(by: {$0.creationDate > $1.creationDate})
        for row in self.selectedRows {
          itemsToDelete.append(IndexPath(row: row, section: 0))
        }
        self.collectionView.deleteItems(at: itemsToDelete)
      }, completion: { finished in
        self.selectedRows.removeAll()
      }
      )
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    UserService.photos(for: user) { (Photos) in
      self.photoCollection = Photos.sorted(by: {$0.creationDate > $1.creationDate})
      self.photoCollectionSorted = self.photoCollection
      self.collectionView.reloadData()
    }
  }
  
  deinit {
    profileRef?.removeObserver(withHandle: profileHandle)
  }
  
}

extension LibraryViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if selectButtonOn == false {
      
      let indexPaths = self.collectionView.indexPathsForSelectedItems
      let indexPath = indexPaths![0]
      let photo = photoCollection[indexPath.row]
      
      let vc = PhotoViewController()
      
      let imageURL = URL(string: photo.imageURL)
      vc.photoImageView.kf.setImage(with: imageURL)
      vc.backgroundImageView.kf.setImage(with: imageURL)
      
      vc.categoryAlphaLabel.text = "Category: \(photo.imagePosition)"
      vc.occasionAlphaLabel.text = "Occasion: \(photo.imageOccasion.joined(separator: ", "))"
      vc.apparelAlphaLabel.text = "Apparel: \(photo.imageApparel.joined(separator: ", "))"
      vc.colorAlphaLabel.text = "Color: \(photo.imageColor.joined(separator: ", "))"
      
      
      
      let nc = UINavigationController(rootViewController: vc)
      
      let photoURLs: [String]  = photoCollection.map {$0.imageURL}
      let photoCategories: [String] = photoCollection.map {$0.imagePosition}
      let photoOccasions: [[String]] = photoCollection.map {$0.imageOccasion}
      let photoApparels: [[String]] = photoCollection.map {$0.imageApparel}
      let photoColors: [[String]] = photoCollection.map {$0.imageColor}
      let photoUIDs: [String] = photoCollection.map {$0.imageUID}

      vc.currentURL = imageURL
      
      vc.photoURLs = photoURLs
      vc.photoCategories = photoCategories
      vc.photoOccasions = photoOccasions
      vc.photoApparels = photoApparels
      vc.photoColors = photoColors
      vc.photoUIDs = photoUIDs
      
      vc.numImages = self.photoCollection.count
    
      vc.imageUID = photo.imageUID
      present(nc, animated: true, completion: nil)
      
    }
      
    else{
      
      //print("select item")
      let indexPaths = self.collectionView.indexPathsForSelectedItems
      
      for indexPath in indexPaths! {
        let photo = photoCollection[indexPath.row]
        if !selectedPhotos.contains(photo.imageUID) {
          selectedPhotos.append(photo.imageUID)
        }
        
      }
      (collectionView.cellForItem(at: indexPath) as? PhotoCollectionCell)?.fadeInAlphaView()
      selectedRows.append(indexPath.row)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    if selectButtonOn == true {
      //Deselect code here
      //print("deselect item")
      let photo = photoCollection[indexPath.row]
      if selectedPhotos.contains(photo.imageUID) {
        selectedPhotos.remove(at: selectedPhotos.index(of: photo.imageUID)!)
      }
      (collectionView.cellForItem(at: indexPath) as? PhotoCollectionCell)?.fadeOutAlphaView()
      selectedRows = selectedRows.filter { $0 != indexPath.row }
    }
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
    cell.reloadAlpha()
    
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

extension LibraryViewController: UIViewControllerPreviewingDelegate {
  
  func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
    
    guard let indexPath = collectionView.indexPathForItem(at: location) else { return nil }
    
    guard let cell = collectionView.cellForItem(at: indexPath) else { return nil }
    
    forceTouchIndexPath = indexPath
    
    let vc = ForceTouchViewController()
    
    let photo = photoCollection[indexPath.row]
    
    let imageURL = URL(string: photo.imageURL)
    
    vc.imageView.kf.setImage(with: imageURL)
    
    vc.preferredContentSize = CGSize(width: 0.0, height: 300.0)
    
    previewingContext.sourceRect = cell.frame
    
    return vc
  }

  func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
    
  
    let photo = photoCollection[(forceTouchIndexPath?.row)!]
    
    let vc = PhotoViewController()
    
    let imageURL = URL(string: photo.imageURL)
    
    vc.photoImageView.kf.setImage(with: imageURL)
    
    vc.backgroundImageView.kf.setImage(with: imageURL)
    
    vc.categoryAlphaLabel.text = "Category: \(photo.imagePosition)"
    vc.occasionAlphaLabel.text = "Occasion: \(photo.imageOccasion.joined(separator: ", "))"
    vc.apparelAlphaLabel.text = "Apparel: \(photo.imageApparel.joined(separator: ", "))"
    vc.colorAlphaLabel.text = "Color: \(photo.imageColor.joined(separator: ", "))"

    
    
    let nc = UINavigationController(rootViewController: vc)
    
    let photoURLs: [String]  = photoCollection.map {$0.imageURL}
    let photoCategories: [String] = photoCollection.map {$0.imagePosition}
    let photoOccasions: [[String]] = photoCollection.map {$0.imageOccasion}
    let photoApparels: [[String]] = photoCollection.map {$0.imageApparel}
    let photoColors: [[String]] = photoCollection.map {$0.imageColor}
    let photoUIDs: [String] = photoCollection.map {$0.imageUID}
    
    vc.currentURL = imageURL

    vc.photoURLs = photoURLs
    vc.photoCategories = photoCategories
    vc.photoOccasions = photoOccasions
    vc.photoApparels = photoApparels
    vc.photoColors = photoColors
    vc.photoUIDs = photoUIDs

    vc.numImages = self.photoCollection.count
    
    vc.imageUID = photo.imageUID

    show(nc, sender: self)
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    self.check3DTouch()
  }
}






