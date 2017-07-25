//
//  PhotoCollectionCell.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/17/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

class PhotoCollectionCell: UICollectionViewCell {
  
  let thumbImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFit
    return view
  }()
  
  // MARK: - Lifetime
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  init() { // You need these things here for every custom view
    super.init(frame: .zero)
    initialize()
  }
  
  override init(frame: CGRect) {
    super.init(frame:frame)
    initialize()
  }
  
  // MARK: - Private
  
  private func initialize() {
    contentView.addSubview(thumbImageView)
    
    contentView.addConstraint(NSLayoutConstraint(item: thumbImageView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 0))
    contentView.addConstraint(NSLayoutConstraint(item: thumbImageView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: 0))
    contentView.addConstraint(NSLayoutConstraint(item: thumbImageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0))
    contentView.addConstraint(NSLayoutConstraint(item: thumbImageView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0))

    
  }
}




