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
  
  let photoHeight = (UIScreen.main.bounds.height - 104)/3
  fileprivate let backgroundView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    view.backgroundColor = UIColor.lighterBlack
    return view
  }()
  
  fileprivate let topImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = (UIScreen.main.bounds.height - 104)/6
    view.layer.borderColor = UIColor.white.cgColor
    view.clipsToBounds = true
    
    view.isUserInteractionEnabled = true
    
    return view
  }()
  
  fileprivate let pantsImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = (UIScreen.main.bounds.height - 104)/6
    view.layer.borderColor = UIColor.white.cgColor
    view.clipsToBounds = true
    view.isUserInteractionEnabled = true
    
    
    return view
  }()
  
  fileprivate let footwearImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = (UIScreen.main.bounds.height - 104)/6
    view.layer.borderColor = UIColor.white.cgColor
    view.clipsToBounds = true
    view.isUserInteractionEnabled = true
    return view
  }()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialize()
    
    navigationItem.title = "Outfit of the day"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
    
    navigationItem.rightBarButtonItem?.tintColor = .white
    
    navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "GothamRounded-Light", size: 17)!], for: .normal)
    
    let tapTopImageGesture = UITapGestureRecognizer(target: self, action: #selector(topImageViewTapped))
    topImageView.addGestureRecognizer(tapTopImageGesture)
    
    let tapPantsImageGesture = UITapGestureRecognizer(target: self, action: #selector(pantsImageViewTapped))
    pantsImageView.addGestureRecognizer(tapPantsImageGesture)
    
    let tapFootwearGesture = UITapGestureRecognizer(target: self, action: #selector(footwearImageViewTapped))
    footwearImageView.addGestureRecognizer(tapFootwearGesture)
  
    randomizeTopImage()
    randomizePantsImage()
    randomizeFootwearImage()
    
  }

  //shake to shuffle
  override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
    randomizeTopImage()
    randomizePantsImage()
    randomizeFootwearImage()
  }
  
  //tap on one of the image views, and the photo within that image view changes to another random one
  
  private func initialize() {
    
    backgroundView.addToAndConstrain(insideSuper: view)
    
    view.insertSubview(topImageView, aboveSubview: backgroundView)
    view.insertSubview(pantsImageView, aboveSubview: backgroundView)
    view.insertSubview(footwearImageView, aboveSubview: backgroundView)
    
    //top image view
    view.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: photoHeight))
    view.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .height, relatedBy: .equal, toItem: topImageView, attribute: .width, multiplier: 1.0, constant: 0))
    
    //pants image view
    view.addConstraint(NSLayoutConstraint(item: pantsImageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: pantsImageView, attribute: .top, relatedBy: .equal, toItem: topImageView, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: pantsImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: photoHeight))
    view.addConstraint(NSLayoutConstraint(item: pantsImageView, attribute: .height, relatedBy: .equal, toItem: pantsImageView, attribute: .width, multiplier: 1.0, constant: 0))
    
    //footwear image view
    view.addConstraint(NSLayoutConstraint(item: footwearImageView, attribute: .top, relatedBy: .equal, toItem: pantsImageView, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: footwearImageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: footwearImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: photoHeight))
    view.addConstraint(NSLayoutConstraint(item: footwearImageView, attribute: .height, relatedBy: .equal, toItem: footwearImageView, attribute: .width, multiplier: 1.0, constant: 0))
  }
  
  
  func cancelButtonTapped() {
    dismiss(animated: true, completion: nil)
  }
  
  func topImageViewTapped(sender: UITapGestureRecognizer) {
    randomizeTopImage()
  }
  
  func pantsImageViewTapped(sender: UITapGestureRecognizer) {
    randomizePantsImage()
  }
  
  func footwearImageViewTapped(sender: UITapGestureRecognizer) {
    randomizeFootwearImage()
  }
  
  
  
  func randomizeTopImage() {
    if topPhotos.count > 0 {
      let topRandomIndex = Int(arc4random_uniform(UInt32(topPhotos.count)))
      let topImageURL = URL(string: topPhotos[topRandomIndex].imageURL)
      topImageView.kf.setImage(with: topImageURL)
      topImageView.transform = CGAffineTransform(scaleX: 0.5, y: 1.5)
      
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
  }
  func randomizePantsImage() {
    if pantsPhotos.count > 0 {
      let pantsRandomIndex = Int(arc4random_uniform(UInt32(pantsPhotos.count)))
      let pantsImageURL = URL(string: pantsPhotos[pantsRandomIndex].imageURL)
      pantsImageView.kf.setImage(with: pantsImageURL)
      
      pantsImageView.transform = CGAffineTransform(scaleX: 0.5, y: 1.5)
      
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
  }
  func randomizeFootwearImage() {
    if footwearPhotos.count > 0 {
      let footwearRandomIndex = Int(arc4random_uniform(UInt32(footwearPhotos.count)))
      let footwearImageURL = URL(string: footwearPhotos[footwearRandomIndex ].imageURL)
      footwearImageView.kf.setImage(with: footwearImageURL)
      
      footwearImageView.transform = CGAffineTransform(scaleX: 0.5, y: 1.5)
      
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




