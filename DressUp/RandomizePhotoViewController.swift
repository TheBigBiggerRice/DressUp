//
//  RandomizePhotoViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 8/5/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit




final class RandomizePhotoViewController: DUViewController {
  
  fileprivate let topImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.backgroundColor = .black
    view.clipsToBounds = true
    
    return view
  }()
  
  fileprivate let pantsImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    
    return view
  }()
  
  fileprivate let footwearImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    
    return view
  }()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialize()
  }
  
  
  private func initialize() {
    
    view.backgroundColor = .white
    
    view.addSubview(topImageView)
    //view.addSubview(pantsImageView)
    //view.addSubview(footwearImageView)
    
    //top image view
    view.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250))
    view.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250))
    
    //pants image view
//    view.addConstraint(NSLayoutConstraint(item: pantsImageView, attribute: .top, relatedBy: .equal, toItem: , attribute: <#T##NSLayoutAttribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)
//    
  }
  
  
}
