//
//  CustomPhotoView.swift
//  DressUp
//
//  Created by Chenyang Zhang on 8/15/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

class CustomPhotoView: UIView {
  
  let imageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFit
    //view.backgroundColor = .white
    return view
  }()
  
  let blurView: UIVisualEffectView = {
    let view = UIVisualEffectView()
    view.translatesAutoresizingMaskIntoConstraints = false
    let effect = UIBlurEffect(style: UIBlurEffectStyle.light)
    view.effect = effect
    return view
  }()
  
  let backgroundView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    //view.backgroundColor = .white
    view.clipsToBounds = true
    return view
  }()
  
  let alphaView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.alpha = 0
    view.backgroundColor = .black
    view.isUserInteractionEnabled = false
    return view
  }()
  
  let nameAlphaLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .center
    label.textColor = .white
    label.alpha = 0
    label.font = UIFont(name: "GothamRounded-Light", size: 24)
    return label
  }()
  
  let categoryAlphaLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textColor = .white
    label.alpha = 0
    return label
  }()
  
  let occasionAlphaLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textColor = .white
    label.alpha = 0
    return label
  }()
  
  let apparelAlphaLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textColor = .white
    label.alpha = 0
    return label
  }()
  
  let colorAlphaLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textColor = .white
    label.alpha = 0
    return label
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
  
  private func initialize() {
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
    addGestureRecognizer(tapGesture)
    
    imageView.addToAndConstrain(insideSuper: self)
    blurView.addToAndConstrain(insideSuper: self)
    backgroundView.addToAndConstrain(insideSuper: self)
    
    insertSubview(blurView, aboveSubview: backgroundView)
    insertSubview(imageView, aboveSubview: blurView)
    
    
    alphaView.addToAndConstrain(insideSuper: self)
    
    insertSubview(categoryAlphaLabel, aboveSubview: alphaView)
    insertSubview(occasionAlphaLabel, aboveSubview: alphaView)
    insertSubview(apparelAlphaLabel, aboveSubview: alphaView)
    insertSubview(colorAlphaLabel, aboveSubview: alphaView)
    insertSubview(nameAlphaLabel, aboveSubview: alphaView)

    
    
    //category alpha label
    addConstraint(NSLayoutConstraint(item: categoryAlphaLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -50))
    addConstraint(NSLayoutConstraint(item: categoryAlphaLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: categoryAlphaLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0))
    
    //occasion alpha label
    addConstraint(NSLayoutConstraint(item: occasionAlphaLabel, attribute: .top, relatedBy: .equal, toItem: categoryAlphaLabel, attribute: .bottom, multiplier: 1.0, constant: 10))
    addConstraint(NSLayoutConstraint(item: occasionAlphaLabel, attribute: .left, relatedBy: .equal, toItem: categoryAlphaLabel, attribute: .left, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: occasionAlphaLabel, attribute: .right, relatedBy: .equal, toItem: categoryAlphaLabel, attribute: .right, multiplier: 1.0, constant: 0))
    
    //apparel alpha label
    addConstraint(NSLayoutConstraint(item: apparelAlphaLabel, attribute: .top, relatedBy: .equal, toItem: occasionAlphaLabel, attribute: .bottom, multiplier: 1.0, constant: 10))
    addConstraint(NSLayoutConstraint(item: apparelAlphaLabel, attribute: .left, relatedBy: .equal, toItem: occasionAlphaLabel, attribute: .left, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: apparelAlphaLabel, attribute: .right, relatedBy: .equal, toItem: occasionAlphaLabel, attribute: .right, multiplier: 1.0, constant: 0))
    
    //color alpha label
    addConstraint(NSLayoutConstraint(item: colorAlphaLabel, attribute: .top, relatedBy: .equal, toItem: apparelAlphaLabel, attribute: .bottom, multiplier: 1.0, constant: 10))
    addConstraint(NSLayoutConstraint(item: colorAlphaLabel, attribute: .left, relatedBy: .equal, toItem: apparelAlphaLabel, attribute: .left, multiplier: 1.0, constant: 0))
    addConstraint(NSLayoutConstraint(item: colorAlphaLabel, attribute: .right, relatedBy: .equal, toItem: apparelAlphaLabel, attribute: .right, multiplier: 1.0, constant: 0))
    
    //name alpha label
    addConstraint(NSLayoutConstraint(item: nameAlphaLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
    
    addConstraint(NSLayoutConstraint(item: nameAlphaLabel, attribute: .bottom, relatedBy: .equal, toItem: categoryAlphaLabel, attribute: .top, multiplier: 1.0, constant: -50))
    addConstraint(NSLayoutConstraint(item: nameAlphaLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: UIScreen.main.bounds.width))
    
    
  }
  
  func imageViewTapped() {
    if alphaView.alpha == 0 {
      fadeInAlphaView()
    } else {
      fadeOutAlphaView()
    }
  }
  
    func fadeInAlphaView() {
      UIView.animate(
        withDuration: 0.3,
        animations: { [weak self] _ in
          self?.alphaView.alpha = 0.8
          self?.categoryAlphaLabel.alpha = 1
          self?.occasionAlphaLabel.alpha = 1
          self?.apparelAlphaLabel.alpha = 1
          self?.colorAlphaLabel.alpha = 1
          self?.nameAlphaLabel.alpha = 1
        }
      )
  
    }
  
    func fadeOutAlphaView() {
      UIView.animate(
        withDuration: 0.3,
        animations: { [weak self] _ in
          self?.alphaView.alpha = 0
          self?.categoryAlphaLabel.alpha = 0
          self?.occasionAlphaLabel.alpha = 0
          self?.apparelAlphaLabel.alpha = 0
          self?.colorAlphaLabel.alpha = 0
          self?.nameAlphaLabel.alpha = 0
        }
      )
      
    }

}
