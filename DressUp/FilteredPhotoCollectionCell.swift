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
        filteredImageView.image = nil
        return
      }
      let imageURL = URL(string: vm.imageURL)
      filteredImageView.kf.setImage(with: imageURL)
      
    }
  }
  
  let filteredImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    view.layer.cornerRadius = 10
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
    
    contentView.addSubview(filteredImageView)
  
    contentView.addConstraint(NSLayoutConstraint(item: filteredImageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 5))
    contentView.addConstraint(NSLayoutConstraint(item: filteredImageView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 5))
    contentView.addConstraint(NSLayoutConstraint(item: filteredImageView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: -5))
    contentView.addConstraint(NSLayoutConstraint(item: filteredImageView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -5))

  }
  
}

