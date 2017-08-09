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
  
  var topPhotoCollection = [Photos]()
  var pantsPhotoCollection = [Photos]()
  var footwearPhotoCollection = [Photos]()
  
  var filteredTopPhotoCollection = [Photos]()
  var filteredPantsPhotoCollection = [Photos]()
  var filteredFootwearPhotoCollection = [Photos]()

  //inputs by the user
  var occasion = [String]()
  var apparel = [String]()
  var color = [String]()
  
  
  //the occasion, apparel, and color tags of all the photos within the photo library
  var aggregateOccasionTags = [String]()
  var aggregateApparelTags = [String]()
  var aggregateColorTags = [String]()
  
  
  
  override init() {
    super.init()
  }
  
  func redownload() {
    
    topPhotoCollection.removeAll()
    pantsPhotoCollection.removeAll()
    footwearPhotoCollection.removeAll()
   
    aggregateOccasionTags.removeAll()
    aggregateApparelTags.removeAll()
    aggregateColorTags.removeAll()
    
    user = user ?? User.current
    profileHandle = UserService.observeProfile(for: user) { [unowned self] (ref, user, photos) in
      self.profileRef = ref
      self.user = user
      self.photoCollection = photos.sorted(by: {$0.creationDate > $1.creationDate})
      
      for photo in self.photoCollection {
        if !photo.imageOccasion.contains("Any") {
          self.aggregateOccasionTags += photo.imageOccasion
        }
        if !photo.imageApparel.contains("Any") {
          self.aggregateApparelTags += photo.imageApparel
        }
        if !photo.imageColor.contains("Any") {
          self.aggregateColorTags += photo.imageColor
        }
        
        if photo.imagePosition == "Top" {
          self.topPhotoCollection.append(photo)
        }
        if photo.imagePosition == "Pants" {
          self.pantsPhotoCollection.append(photo)
        }
        if photo.imagePosition == "Footwear" {
          self.footwearPhotoCollection.append(photo)
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
    
    
    if 0 == row {
      
      
      filteredTopPhotoCollection = topPhotoCollection.filter { photo in
        
        let setPhotoOccasion = Set(photo.imageOccasion)
        let setPhotoApparel = Set(photo.imageApparel)
        let setPhotoColor = Set(photo.imageColor)
        
        if setOccasion.intersection(setPhotoOccasion).count > 0 || setApparel.intersection(setPhotoApparel).count > 0 || setColor.intersection(setPhotoColor).count > 0 || (setOccasion.contains("") == true && setApparel.contains("") == true && setColor.contains("") == true) || (setOccasion.isEmpty == true && setApparel.isEmpty == true && setColor.isEmpty == true) || !setOccasion.contains("") && photo.imageOccasion.contains("Any") || !setApparel.contains("") && photo.imageApparel.contains("Any") || !setColor.contains("") && photo.imageColor.contains("Any") { return true }
        else { return false }
      }
      return filteredTopPhotoCollection.map { FilteredPhotoCollectionCellViewModel(withPhoto: $0) }
    }
    else if 1 == row {
      
      
      
      filteredPantsPhotoCollection = pantsPhotoCollection.filter { photo in
        
        let setPhotoOccasion = Set(photo.imageOccasion)
        let setPhotoApparel = Set(photo.imageApparel)
        let setPhotoColor = Set(photo.imageColor)
        
        if setOccasion.intersection(setPhotoOccasion).count > 0 || setApparel.intersection(setPhotoApparel).count > 0 || setColor.intersection(setPhotoColor).count > 0 || (setOccasion.contains("") == true && setApparel.contains("") == true && setColor.contains("") == true) || (setOccasion.isEmpty == true && setApparel.isEmpty == true && setColor.isEmpty == true) || !setOccasion.contains("") && photo.imageOccasion.contains("Any") || !setApparel.contains("") && photo.imageApparel.contains("Any") || !setColor.contains("") && photo.imageColor.contains("Any") { return true }
        else { return false }
      }
      
      return filteredPantsPhotoCollection.map { FilteredPhotoCollectionCellViewModel(withPhoto: $0) }
    }
    else if 2 == row {
      

      filteredFootwearPhotoCollection = footwearPhotoCollection.filter { photo in
        
        let setPhotoOccasion = Set(photo.imageOccasion)
        let setPhotoApparel = Set(photo.imageApparel)
        let setPhotoColor = Set(photo.imageColor)
        
        if setOccasion.intersection(setPhotoOccasion).count > 0 || setApparel.intersection(setPhotoApparel).count > 0 || setColor.intersection(setPhotoColor).count > 0 || (setOccasion.contains("") == true && setApparel.contains("") == true && setColor.contains("") == true) || (setOccasion.isEmpty == true && setApparel.isEmpty == true && setColor.isEmpty == true) || !setOccasion.contains("") && photo.imageOccasion.contains("Any") || !setApparel.contains("") && photo.imageApparel.contains("Any") || !setColor.contains("") && photo.imageColor.contains("Any") { return true }
        else { return false }
      }
      return filteredFootwearPhotoCollection.map { FilteredPhotoCollectionCellViewModel(withPhoto: $0) }
    }
    else {
      return []
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath)
    cell.backgroundColor = .clear
    let cvm = collectionCellViewModel(forRow: indexPath.row)
    
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


