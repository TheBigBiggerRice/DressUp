//
//  HomeController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/27/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

//NEW STUFF
import UIKit
import Firebase
import FirebaseDatabase

protocol HomeControllerDelegate: AnyObject {
  func homeControllerShouldReloadData(_ controller: HomeController)
}

final class HomeController: NSObject {
  
  weak var delegate: HomeControllerDelegate?
  
  var user: User!
  //
  var photoCollection = [Photos]() {
    didSet {
      delegate?.homeControllerShouldReloadData(self)
    }
  }
  var profileHandle: DatabaseHandle = 0
  var profileRef: DatabaseReference?
  
  override init() {
    super.init()
  
    //firebase stuff
    user = user ?? User.current
    profileHandle = UserService.observeProfile(for: user) { [unowned self] (ref, user, photos) in
      self.profileRef = ref
      self.user = user
      self.photoCollection = photos.sorted(by: {$0.creationDate > $1.creationDate})
    }
  }
  
}

extension HomeController: UITableViewDelegate {
  
  
  //
  fileprivate func collectionCellViewModel(forRow row: Int) -> HomeTableViewCellViewModel {
    var viewModels: [FilteredPhotoCollectionCellViewModel] = []
    for photo in photoCollection {
      let viewModel = FilteredPhotoCollectionCellViewModel(withPhoto: photo)
      viewModels.append(viewModel)
    }
    return viewModels
  }
  //NEW STUFF
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath)
    cell.backgroundColor = .clear
    (cell as? HomeTableViewCell)?.cellViewModel = collectionCellViewModel(forRow: indexPath.row) // you need to get data back first before making this thing
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









