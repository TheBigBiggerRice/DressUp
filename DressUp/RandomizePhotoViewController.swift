//
//  RandomizePhotoViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 8/5/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit
import Kingfisher


final class RandomizePhotoViewController: DUViewController {
  
  var topPhotos = [Photos]()
  var pantsPhotos = [Photos]()
  var footwearPhotos = [Photos]()
  
  let photoHeight = (UIScreen.main.bounds.height - 64)/3
  
  fileprivate let topImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = 112
    view.clipsToBounds = true
    
    return view
  }()
  
  fileprivate let pantsImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = 112
    view.clipsToBounds = true
    
    return view
  }()
  
  fileprivate let footwearImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = 112
    view.clipsToBounds = true
    
    return view
  }()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialize()
    
    self.navigationItem.title = "Outfit of the day"
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
    
    self.navigationItem.rightBarButtonItem?.tintColor = .white
    
    navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "GothamRounded-Light", size: 17)!], for: .normal)
    
    view.backgroundColor = UIColor.lighterBlack
    
    randomize()
    
  }
  


  //shake to shuffle
  override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
    randomize()
  }
  
  

  private func initialize() {
    
    view.backgroundColor = .white
    
    view.addSubview(topImageView)
    view.addSubview(pantsImageView)
    view.addSubview(footwearImageView)
    
    //top image view
    view.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: photoHeight))
    view.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .height, relatedBy: .equal, toItem: topImageView, attribute: .width, multiplier: 1.0, constant: 0))
    
    //pants image view
    view.addConstraint(NSLayoutConstraint(item: pantsImageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: pantsImageView, attribute: .top, relatedBy: .equal, toItem: topImageView, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: pantsImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: photoHeight))
    view.addConstraint(NSLayoutConstraint(item: pantsImageView, attribute: .height, relatedBy: .equal, toItem: pantsImageView, attribute: .width, multiplier: 1.0, constant: 0))
    
    //footwear image view
    view.addConstraint(NSLayoutConstraint(item: footwearImageView, attribute: .top, relatedBy: .equal, toItem: pantsImageView, attribute: .bottom, multiplier: 1.0, constant: 0))
    
    view.addConstraint(NSLayoutConstraint(item: footwearImageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
    
    view.addConstraint(NSLayoutConstraint(item: footwearImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: photoHeight))
    
    view.addConstraint(NSLayoutConstraint(item: footwearImageView, attribute: .height, relatedBy: .equal, toItem: footwearImageView, attribute: .width, multiplier: 1.0, constant: 0))
  }
  
  
  func cancelButtonTapped() {
    dismiss(animated: true, completion: nil)
  }
  
  
  
  func randomize() {
    if topPhotos.count > 0 {
      let topRandomIndex = Int(arc4random_uniform(UInt32(topPhotos.count)))
      let topImageURL = URL(string: topPhotos[topRandomIndex].imageURL)
      topImageView.kf.setImage(with: topImageURL)
      topImageView.transform = CGAffineTransform(scaleX: 0.3, y: 2)
      
      UIView.animate(
        withDuration: 1,
        delay: 0,
        usingSpringWithDamping: 0.3,
        initialSpringVelocity: 0,
        options: .curveEaseOut,
        animations: {
        self.topImageView.transform = .identity
          
      }) { (success) in
        
      }
    
    }
    
    if pantsPhotos.count > 0 {
      let pantsRandomIndex = Int(arc4random_uniform(UInt32(pantsPhotos.count)))
      let pantsImageURL = URL(string: pantsPhotos[pantsRandomIndex].imageURL)
      pantsImageView.kf.setImage(with: pantsImageURL)
      
      pantsImageView.transform = CGAffineTransform(scaleX: 0.3, y: 2)
      
      UIView.animate(
        withDuration: 1,
        delay: 0,
        usingSpringWithDamping: 0.3,
        initialSpringVelocity: 0,
        options: .curveEaseOut,
        animations: {
          self.pantsImageView.transform = .identity
          
      }) { (success) in
        
      }
      
    }
    
    if footwearPhotos.count > 0 {
      let footwearRandomIndex = Int(arc4random_uniform(UInt32(footwearPhotos.count)))
      let footwearImageURL = URL(string: footwearPhotos[footwearRandomIndex ].imageURL)
      footwearImageView.kf.setImage(with: footwearImageURL)
      
      footwearImageView.transform = CGAffineTransform(scaleX: 0.3, y: 2)
      
      UIView.animate(
        withDuration: 1,
        delay: 0,
        usingSpringWithDamping: 0.3,
        initialSpringVelocity: 0,
        options: .curveEaseOut,
        animations: {
          self.footwearImageView.transform = .identity
          
      }) { (success) in
        
      }
      
    }

  }
  
  
  
}
