//
//  FilteredPhotoCollectionCell.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/27/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit
import Kingfisher

class FilteredPhotoCollectionCell: UICollectionViewCell {
  
  var viewModel: FilteredPhotoCollectionCellViewModel? {
    didSet {
      guard let vm = viewModel else {
        return
      }
      let imageURL = URL(string: vm.imageURL)
      filteredImageView.kf.setImage(with: imageURL)
      
    }
  }
  
  let filteredImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleToFill
    return view
  }()
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  init() {
    super.init(frame: .zero)
    initialize()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }
  
  private func initialize() {
    filteredImageView.addToAndConstrain(insideSuper: contentView)
  }
  
}

