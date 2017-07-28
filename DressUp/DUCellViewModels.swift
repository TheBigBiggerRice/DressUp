//
//  DUCellViewModels.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/27/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import Foundation

typealias HomeTableViewCellViewModel = [FilteredPhotoCollectionCellViewModel]

protocol FilteredPhotoCollectionCellPresentable: AnyObject {
  var imageURL: String { get }
}

final class FilteredPhotoCollectionCellViewModel: FilteredPhotoCollectionCellPresentable {
  private let photo: Photos
  
  var imageURL: String {
    return photo.imageURL
  }
  var imageApparel: [String] {
    return photo.imageApparel
  }
  var imageColor: [String] {
    return photo.imageColor
  }
  
  init(withPhoto photo: Photos) {
    self.photo = photo
  }
  
}
