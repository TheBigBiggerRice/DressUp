//
//  CustomView.swift
//  DressUp
//
//  Created by Chenyang Zhang on 8/10/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

@IBDesignable class CustomView : UIButton {
  @IBInspectable var borderColor: UIColor = .clear {
    didSet {
      layer.borderColor = borderColor.cgColor
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      layer.cornerRadius = cornerRadius
    }
  }
}
