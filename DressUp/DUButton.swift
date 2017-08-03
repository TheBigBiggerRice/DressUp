//
//  DUButton.swift
//  DressUp
//
//  Created by Chenyang Zhang on 8/3/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

final class DUButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    titleLabel?.font = UIFont(name: "GothamRounded-Light", size: 17)
  
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
