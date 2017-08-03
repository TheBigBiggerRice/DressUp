//
//  CustomTabBar.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/30/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

protocol CustomTabBarDelegate: AnyObject{
  func customTabBar(_ tabBar: CustomTabBar, didTapButtonAtIndex index: Int)
  
}

class CustomTabBar: UIView {
  
  weak var delegate: CustomTabBarDelegate?
  
  var topBarViewCenterX: NSLayoutConstraint = NSLayoutConstraint()
  
  let topViewBorder = CALayer()
  let topButtonBorder = CALayer()
  
  //blur view
  fileprivate let blurView: UIVisualEffectView = {
    let view = UIVisualEffectView()
    view.translatesAutoresizingMaskIntoConstraints = false
    let effect = UIBlurEffect(style: UIBlurEffectStyle.light)
    view.effect = effect
    return view
  }()
  
  //top bar view
  fileprivate let topBarView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.onyxBlack
    return view
  }()
  
  //home button and image
  fileprivate let homeButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  fileprivate let homeImageView: UIImageView = {
    let view = UIImageView(image: #imageLiteral(resourceName: "TabBarHome"))
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFit
    return view
  }()
  
  //camera button and image
  fileprivate let cameraButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  fileprivate let cameraImageView: UIImageView = {
    let view = UIImageView(image: #imageLiteral(resourceName: "TabBarCamera"))
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFit
    return view
  }()
  
  //library button and image
  fileprivate let libraryButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  fileprivate let libraryImageView: UIImageView = {
    let view = UIImageView(image: #imageLiteral(resourceName: "TabBarLibrary"))
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFit
    return view
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
    super.init(frame:frame)
    initialize()
  }
  
  deinit {
    homeButton.removeTarget(self, action: nil, for: .allEvents)
    cameraButton.removeTarget(self, action: nil, for: .allEvents)
    libraryButton.removeTarget(self, action: nil, for: .allEvents)
    
  }
  
  private func initialize() {
    
    topViewBorder.borderColor = UIColor.gray.cgColor
    topViewBorder.borderWidth = 0.5
    topViewBorder.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.5)
  
    self.layer.addSublayer(topViewBorder)
    
    addSubview(blurView)
    addSubview(topBarView)
    
    addSubview(homeButton)
    addSubview(homeImageView)
    
    addSubview(cameraButton)
    addSubview(cameraImageView)
    
    addSubview(libraryButton)
    addSubview(libraryImageView)
    
    homeButton.addTarget(self, action: #selector(CustomTabBar.didTapButton(sender:)), for: .touchUpInside)
    cameraButton.addTarget(self, action: #selector(CustomTabBar.didTapButton(sender:)), for: .touchUpInside)
    libraryButton.addTarget(self, action: #selector(CustomTabBar.didTapButton(sender:)), for: .touchUpInside)
    
    //blur view
    addConstraint(NSLayoutConstraint(item: blurView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: blurView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: blurView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: blurView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0))
    
    //top bar view constraints
    addConstraint(NSLayoutConstraint(item: topBarView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: topBarView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 3.0))
    addConstraint(NSLayoutConstraint(item: topBarView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width/6))
    topBarViewCenterX = NSLayoutConstraint(item: topBarView, attribute: .centerX, relatedBy: .equal, toItem: homeButton, attribute: .centerX, multiplier: 1.0, constant: 0)
    addConstraint(topBarViewCenterX)
    
    //home button
    addConstraint(NSLayoutConstraint(item: homeButton, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: homeButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: homeButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: homeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width/3))
    
    //home image view
    addConstraint(NSLayoutConstraint(item: homeImageView, attribute: .centerX, relatedBy: .equal, toItem: homeButton, attribute: .centerX, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: homeImageView, attribute: .centerY, relatedBy: .equal, toItem: homeButton, attribute: .centerY, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: homeImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 35))
    addConstraint(NSLayoutConstraint(item: homeImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 35))
    
    //camera button
    addConstraint(NSLayoutConstraint(item: cameraButton, attribute: .left, relatedBy: .equal, toItem: homeButton, attribute: .right, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: cameraButton, attribute: .top, relatedBy: .equal, toItem: homeButton, attribute: .top, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: cameraButton, attribute: .bottom, relatedBy: .equal, toItem: homeButton, attribute: .bottom, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: cameraButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width/3))
    
    //camera image view
    addConstraint(NSLayoutConstraint(item: cameraImageView, attribute: .centerX, relatedBy: .equal, toItem: cameraButton, attribute: .centerX, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: cameraImageView, attribute: .centerY, relatedBy: .equal, toItem: cameraButton, attribute: .centerY, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: cameraImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 35))
    addConstraint(NSLayoutConstraint(item: cameraImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 35))
    
    //library button
    addConstraint(NSLayoutConstraint(item: libraryButton, attribute: .left, relatedBy: .equal, toItem: cameraButton, attribute: .right, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: libraryButton, attribute: .top, relatedBy: .equal, toItem: cameraButton, attribute: .top, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: libraryButton, attribute: .bottom, relatedBy: .equal, toItem: cameraButton, attribute: .bottom, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: libraryButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width/3))
    
    //library image view
    addConstraint(NSLayoutConstraint(item: libraryImageView, attribute: .centerX, relatedBy: .equal, toItem: libraryButton, attribute: .centerX, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: libraryImageView, attribute: .centerY, relatedBy: .equal, toItem: libraryButton, attribute: .centerY, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: libraryImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 35))
    addConstraint(NSLayoutConstraint(item: libraryImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 35))
  }
  
  func didTapButton(sender: UIButton) {
    switch sender {
    case homeButton:
      delegate?.customTabBar(self, didTapButtonAtIndex: 0)
      
      homeButton.layer.addSublayer(topButtonBorder)
      
      UIView.animate(
        withDuration: 0.3,
        delay: 0.0,
        options: .curveEaseOut,
        animations: {
          self.homeImageView.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.0)
        },
        completion: { finish in
      UIView.animate(
        withDuration: 0.3,
        delay: 0.0,
        options: .curveEaseOut,
        animations: {
          self.homeImageView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        },
        completion: nil)})
      
      topBarViewCenterX.constant = 0
      
      UIView.animate(
        withDuration: 0.3,
        delay: 0.0,
        options: .curveEaseOut,
        animations: {
          self.layoutIfNeeded()
        },
        completion: nil)
      
    case cameraButton:
      delegate?.customTabBar(self, didTapButtonAtIndex: 1)
      
      cameraButton.layer.addSublayer(topButtonBorder)
      
      UIView.animate(
        withDuration: 0.3,
        delay: 0.0,
        options: .curveEaseOut,
        animations: {
          self.cameraImageView.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.0)
        },
        completion: { finish in
      UIView.animate(
        withDuration: 0.3,
        delay: 0.0,
        options: .curveEaseOut,
        animations: {
          self.cameraImageView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        },
        completion: nil)})
      
      topBarViewCenterX.constant = UIScreen.main.bounds.width/3
      UIView.animate(
        withDuration: 0.3,
        delay: 0.0,
        options: .curveEaseOut,
        animations: {
          self.layoutIfNeeded()
        },
        completion: nil)
      
    case libraryButton:
      delegate?.customTabBar(self, didTapButtonAtIndex: 2)
      
      libraryButton.layer.addSublayer(topButtonBorder)
      
      UIView.animate(
        withDuration: 0.3, 
        delay: 0.0, 
        options: .curveEaseOut, 
        animations: {
          self.libraryImageView.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.0)
        },
        completion: { finish in
      UIView.animate(
        withDuration: 0.3,
        delay: 0.0,
        options: .curveEaseOut,
        animations: {
          self.libraryImageView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        },
        completion: nil)})
      
      topBarViewCenterX.constant = UIScreen.main.bounds.width/1.5
      UIView.animate(
        withDuration: 0.3,
        delay: 0.0,
        options: .curveEaseOut,
        animations: {
          self.layoutIfNeeded()
        },
        completion: nil)
    default: return
    }
  }
  
}
