//
//  HomeTableViewCell.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/26/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Kingfisher




final class HomeTableViewCell: UITableViewCell {
  
  
  var cellViewModel: HomeTableViewCellViewModel? {
    didSet {
      guard cellViewModel != nil else {
        return
      }
//      homeCollectionView.tag = tagCount
//      tagCount += 1
      homeCollectionView.reloadData()
    }
    
  }
  
  var tagCarrier: Int = 0
  
  var user: User!
  var photoCollection = [Photos]()
  var profileHandle: DatabaseHandle = 0
  var profileRef: DatabaseReference?
  
  //initialize a collection view within the table view cell
  fileprivate let homeCollectionView: UICollectionView = {
    
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 125, height: 125)
    layout.scrollDirection = .horizontal
    layout.minimumInteritemSpacing = 1.5
    layout.minimumLineSpacing = 1.5
    
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.translatesAutoresizingMaskIntoConstraints = false
    collection.showsHorizontalScrollIndicator = false
    collection.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    return collection
    
  }()
  
  // MARK: - Lifetime
  
  init(frame: CGRect) {
    super.init(style: .default, reuseIdentifier: nil)
    initialize()
  }
  
  required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    initialize()
  }
  
  init() {
    super.init(style: .default, reuseIdentifier: nil)
    initialize()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  deinit { // remove button targets and notification center listening in deinits for views, cells, etc
  }
  
  private func initialize() {

    //initialize home collection view 
    
    homeCollectionView.register(FilteredPhotoCollectionCell.self, forCellWithReuseIdentifier: FilteredPhotoCollectionCell.description())
    homeCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")

    homeCollectionView.delegate = self
    homeCollectionView.dataSource = self
    
    homeCollectionView.backgroundColor = .white
//    homeCollectionView.tag = tagCarrier
//    tagCount += 1
//    print(tagCount)
    
    homeCollectionView.addToAndConstrain(insideSuper: self)

  }
}

extension HomeTableViewCell: UICollectionViewDelegate {
  
}

//add section headers for each collection view. 3 in total.
extension HomeTableViewCell: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cellViewModel?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilteredPhotoCollectionCell.description(), for: indexPath)
    
    if let viewModel = cellViewModel?[indexPath.row] {
      (cell as? FilteredPhotoCollectionCell)?.viewModel = viewModel
      (cell as? FilteredPhotoCollectionCell)?.tag = tagCarrier
//      tagCount += 1
    } else {
      (cell as? FilteredPhotoCollectionCell)?.viewModel = nil
    }
    
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    switch kind {
    
    case UICollectionElementKindSectionHeader:
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
      
      switch tagCarrier {
      case 0:
        headerView.headerLabel.text = "Top"
      case 1:
        headerView.headerLabel.text = "Pants"
      case 2:
        headerView.headerLabel.text = "Footwear"
      default:
        headerView.headerLabel.text = "Error"
        
      }
      return headerView
      
    default:
      assert(false, "Unexpected element kind")
      return UICollectionReusableView()
    }
    
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: 100, height: 50)
  }
  
}
