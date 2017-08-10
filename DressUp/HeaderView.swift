//
//  HeaderView.swift
//  DressUp
//
//  Created by Chenyang Zhang on 8/9/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
  
  let headerLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: "GothamRounded-Light", size: 17)
    return label
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
    self.backgroundColor = .white
    
    self.addSubview(headerLabel)
    
    self.addConstraint(NSLayoutConstraint(item: headerLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0))
    self.addConstraint(NSLayoutConstraint(item: headerLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0))
    self.addConstraint(NSLayoutConstraint(item: headerLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
    self.addConstraint(NSLayoutConstraint(item: headerLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))

  }

}
