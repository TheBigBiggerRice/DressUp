//
//  Storyboard+Utility.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/13/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import Foundation
import UIKit



extension UIStoryboard {
  enum DUType: String {
    case main
    case login
    
    
    var fileName: String {
      return rawValue.capitalized
    }
  }
  convenience init(type: DUType, bundle: Bundle? = nil) {
    self.init(name: type.fileName, bundle: bundle)
  }
  
  
  static func initialViewController(for type: DUType) -> UIViewController {
    let storyboard = UIStoryboard(type: type)
    guard let initialViewController = storyboard.instantiateInitialViewController() else {
      fatalError("Could not instantiate initial view controller for \(type.fileName) storyboard")
    }
    return initialViewController
  }
}
