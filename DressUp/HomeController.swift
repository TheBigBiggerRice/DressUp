//
//  HomeController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/27/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//


import UIKit
import Firebase
import FirebaseDatabase

protocol HomeControllerDelegate: AnyObject {
  func homeControllerShouldReloadData(_ controller: HomeController)
}

final class HomeController: NSObject {
  
  weak var delegate: HomeControllerDelegate?
  
  var user: User!
  
  var photoCollection = [Photos]() {
    didSet {
      delegate?.homeControllerShouldReloadData(self)
    }
  }
  var profileHandle: DatabaseHandle = 0
  var profileRef: DatabaseReference?
  
  //processed photo collection based on table view cell rows
  var topPhotoCollection = [Photos]()
  var bottomPhotoCollection = [Photos]()
  var shoesPhotoCollection = [Photos]()
  
  //inputs by the user
  var occasion = [String]()
  var apparel = [String]()
  var color = [String]()
  
  override init() {
    super.init()
  }
  
  func redownload() {
    
    topPhotoCollection.removeAll()
    bottomPhotoCollection.removeAll()
    shoesPhotoCollection.removeAll()
    
    user = user ?? User.current
    profileHandle = UserService.observeProfile(for: user) { [unowned self] (ref, user, photos) in
      self.profileRef = ref
      self.user = user
      self.photoCollection = photos.sorted(by: {$0.creationDate > $1.creationDate})
      
      for photo in self.photoCollection {
        
        if photo.imagePosition == "Top" {
          self.topPhotoCollection.append(photo)
        }
        if photo.imagePosition == "Bottom" {
          self.bottomPhotoCollection.append(photo)
        }
        if photo.imagePosition == "Shoes" {
          self.shoesPhotoCollection.append(photo)
        }
      }
    }
  }
  
}

extension HomeController: UITableViewDelegate {
  
  fileprivate func collectionCellViewModel(forRow row: Int) -> HomeTableViewCellViewModel {
    
    let setOccasion = Set(self.occasion)
    let setApparel = Set(self.apparel)
    let setColor = Set(self.color)
    
    //filtering the photos based on input
    if 0 == row {
      
      var filteredTopPhotoCollection = [Photos]()
      
      filteredTopPhotoCollection = topPhotoCollection.filter { photo in
        
        let setPhotoOccasion = Set(photo.imageOccasion)
        let setPhotoApparel = Set(photo.imageApparel)
        let setPhotoColor = Set(photo.imageColor)
        
        if setOccasion.intersection(setPhotoOccasion).count > 0 || setApparel.intersection(setPhotoApparel).count > 0 || setColor.intersection(setPhotoColor).count > 0 || (setOccasion.count == 0 && setApparel.count == 0 && setColor.count == 0) { return true }
        else { return false }
      }
      return filteredTopPhotoCollection.map { FilteredPhotoCollectionCellViewModel(withPhoto: $0) }
    }
    else if 1 == row {
      
      var filteredBottomPhotoCollection = [Photos]()
      
      filteredBottomPhotoCollection = bottomPhotoCollection.filter { photo in
        
        let setPhotoOccasion = Set(photo.imageOccasion)
        let setPhotoApparel = Set(photo.imageApparel)
        let setPhotoColor = Set(photo.imageColor)
        
        if setOccasion.intersection(setPhotoOccasion).count > 0 || setApparel.intersection(setPhotoApparel).count > 0 || setColor.intersection(setPhotoColor).count > 0 || (setOccasion.count == 0 && setApparel.count == 0 && setColor.count == 0) { return true }
        else { return false }
      }
      
      return filteredBottomPhotoCollection.map { FilteredPhotoCollectionCellViewModel(withPhoto: $0) }
    }
    else if 2 == row {
      
      var filteredShoesPhotoCollection = [Photos]()
      
      filteredShoesPhotoCollection = shoesPhotoCollection.filter { photo in
        
        let setPhotoOccasion = Set(photo.imageOccasion)
        let setPhotoApparel = Set(photo.imageApparel)
        let setPhotoColor = Set(photo.imageColor)
        
        if setOccasion.intersection(setPhotoOccasion).count > 0 || setApparel.intersection(setPhotoApparel).count > 0 || setColor.intersection(setPhotoColor).count > 0 || (setOccasion.count == 0 && setApparel.count == 0 && setColor.count == 0) { return true }
        else { return false }
      }
      return filteredShoesPhotoCollection.map { FilteredPhotoCollectionCellViewModel(withPhoto: $0) }
    }
    else {
      return []
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath)
    cell.backgroundColor = .clear
    let cvm = collectionCellViewModel(forRow: indexPath.row)
    print(cvm.count)
    (cell as? HomeTableViewCell)?.cellViewModel = cvm
    return cell
  }
  
}

extension HomeController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 125
  }
  
}


