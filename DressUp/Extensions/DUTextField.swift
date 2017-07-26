//
//  DUTextField.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/26/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

final class DUTextField: UITextField {
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: 10, dy: 0)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: 10, dy: 0)
  }
}

