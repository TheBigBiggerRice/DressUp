//
//  ForceTouchViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/29/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit



class ForceTouchViewController: DUViewController {
  
  let imageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    return view
  }()
  
  fileprivate let positionLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Position"
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let occasionLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Occasion"
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let apparelLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Apparel"
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let colorLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Color"
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialize()
    

  }
  
  private func initialize() {
    
    view.addSubview(imageView)
    
    view.addSubview(occasionLabel)
    view.addSubview(apparelLabel)
    view.addSubview(colorLabel)

    positionLabel.addToAndConstrain(insideSuper: view)
    
    imageView.addToAndConstrain(insideSuper: view)
    
  }
}




















