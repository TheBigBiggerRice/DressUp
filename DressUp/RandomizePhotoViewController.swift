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
  var accessoryPhotos = [Photos]()
  var carryOnPhotos = [Photos]()
  
  let photoHeight = (UIScreen.main.bounds.height - 104)/3
  
  let photoWidth = (UIScreen.main.bounds.width - 30)/2
  
  let photoDistance = (UIScreen.main.bounds.height - 64 - ((UIScreen.main.bounds.width - 30)/2) * 3)/4
  
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
    view.layer.cornerRadius = (UIScreen.main.bounds.width - 30)/4
    view.clipsToBounds = true
    view.isUserInteractionEnabled = true
    return view
  }()
  
  fileprivate let pantsImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = (UIScreen.main.bounds.width - 30)/4
    view.clipsToBounds = true
    view.isUserInteractionEnabled = true
    return view
  }()
  
  fileprivate let footwearImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = (UIScreen.main.bounds.width - 30)/4
    view.clipsToBounds = true
    view.isUserInteractionEnabled = true
    return view
  }()
  
  fileprivate let accessoryImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = (UIScreen.main.bounds.width - 30)/4
    view.clipsToBounds = true
    view.isUserInteractionEnabled = true
    return view
  }()
  
  fileprivate let carryOnImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = (UIScreen.main.bounds.width - 30)/4
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
    
    let tapAccessoryGesture = UITapGestureRecognizer(target: self, action: #selector(accessoryImageViewTapped))
    accessoryImageView.addGestureRecognizer(tapAccessoryGesture)
    
    let tapCarryOnGesture = UITapGestureRecognizer(target: self, action: #selector(carryOnImageViewTapped))
    carryOnImageView.addGestureRecognizer(tapCarryOnGesture)
  
    randomizeTopImage()
    randomizePantsImage()
    randomizeFootwearImage()
    randomizeAccessoryImage()
    randomizeCarryOnImage()
    
  }

  override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
    randomizeTopImage()
    randomizePantsImage()
    randomizeFootwearImage()
    randomizeAccessoryImage()
    randomizeCarryOnImage()

  }
  
  private func initialize() {
  
    backgroundView.addToAndConstrain(insideSuper: view)
    
    view.insertSubview(topImageView, aboveSubview: backgroundView)
    view.insertSubview(pantsImageView, aboveSubview: backgroundView)
    view.insertSubview(footwearImageView, aboveSubview: backgroundView)
    view.insertSubview(accessoryImageView, aboveSubview: backgroundView)
    view.insertSubview(carryOnImageView, aboveSubview: backgroundView)
    
    //top image view
    view.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: photoDistance))
    view.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: photoWidth))
    view.addConstraint(NSLayoutConstraint(item: topImageView, attribute: .height, relatedBy: .equal, toItem: topImageView, attribute: .width, multiplier: 1.0, constant: 0))
    
    //pants image view
    view.addConstraint(NSLayoutConstraint(item: pantsImageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: pantsImageView, attribute: .top, relatedBy: .equal, toItem: topImageView, attribute: .bottom, multiplier: 1.0, constant: photoDistance))
    view.addConstraint(NSLayoutConstraint(item: pantsImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: photoWidth))
    view.addConstraint(NSLayoutConstraint(item: pantsImageView, attribute: .height, relatedBy: .equal, toItem: pantsImageView, attribute: .width, multiplier: 1.0, constant: 0))
    
    //footwear image view
    view.addConstraint(NSLayoutConstraint(item: footwearImageView, attribute: .top, relatedBy: .equal, toItem: pantsImageView, attribute: .bottom, multiplier: 1.0, constant: photoDistance))
    view.addConstraint(NSLayoutConstraint(item: footwearImageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: footwearImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: photoWidth))
    view.addConstraint(NSLayoutConstraint(item: footwearImageView, attribute: .height, relatedBy: .equal, toItem: footwearImageView, attribute: .width, multiplier: 1.0, constant: 0))
    
    //accessory image view
    view.addConstraint(NSLayoutConstraint(item: accessoryImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: photoDistance))
    view.addConstraint(NSLayoutConstraint(item: accessoryImageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10))
    view.addConstraint(NSLayoutConstraint(item: accessoryImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: photoWidth))
    view.addConstraint(NSLayoutConstraint(item: accessoryImageView, attribute: .height, relatedBy: .equal, toItem: accessoryImageView, attribute: .width, multiplier: 1.0, constant: 0))
    
    //carry on image view
    view.addConstraint(NSLayoutConstraint(item: carryOnImageView, attribute: .top, relatedBy: .equal, toItem: accessoryImageView, attribute: .bottom, multiplier: 1.0, constant: photoDistance))
    view.addConstraint(NSLayoutConstraint(item: carryOnImageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10))
    view.addConstraint(NSLayoutConstraint(item: carryOnImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: photoWidth))
    view.addConstraint(NSLayoutConstraint(item: carryOnImageView, attribute: .height, relatedBy: .equal, toItem: carryOnImageView, attribute: .width, multiplier: 1.0, constant: 0))
    
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
  func accessoryImageViewTapped(sender: UITapGestureRecognizer) {
    randomizeAccessoryImage()
  }
  func carryOnImageViewTapped(sender: UITapGestureRecognizer) {
    randomizeCarryOnImage()
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
  
  func randomizeAccessoryImage() {
    
    if accessoryPhotos.count > 0 {
      let accessoryRandomIndex = Int(arc4random_uniform(UInt32(accessoryPhotos.count)))
      let accessoryImageURL = URL(string: accessoryPhotos[accessoryRandomIndex].imageURL)
      accessoryImageView.kf.setImage(with: accessoryImageURL)
      
      accessoryImageView.transform = CGAffineTransform(scaleX: 0.5, y: 1.5)
  
      UIView.animate(
        withDuration: 1,
        delay: 0,
        usingSpringWithDamping: 0.3,
        initialSpringVelocity: 0,
        options: .curveEaseOut,
        animations: {
          self.accessoryImageView.transform = .identity
          
      }) { (success) in
        
      }
    }
  }
  
  func randomizeCarryOnImage() {
    
    if carryOnPhotos.count > 0 {
      let carryOnRandomIndex = Int(arc4random_uniform(UInt32(carryOnPhotos.count)))
      let carryOnImageURL = URL(string: carryOnPhotos[carryOnRandomIndex].imageURL)
      carryOnImageView.kf.setImage(with: carryOnImageURL)
      
      carryOnImageView.transform = CGAffineTransform(scaleX: 0.5, y: 1.5)
      
      UIView.animate(
        withDuration: 1,
        delay: 0,
        usingSpringWithDamping: 0.3,
        initialSpringVelocity: 0,
        options: .curveEaseOut,
        animations: {
          self.carryOnImageView.transform = .identity
          
      }) { (success) in
        
      }
    }
  }
  
}




