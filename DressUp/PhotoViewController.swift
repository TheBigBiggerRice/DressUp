//
//  ExpandedPhotoViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/20/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

final class PhotoViewController: DUViewController {
  
  var currentURL: URL?
  
  var photoURLs: [String] = []
  var photoCategories: [String] = []
  var photoOccasions: [[String]] = [[]]
  var photoApparels: [[String]] = [[]]
  var photoColors: [[String]] = [[]]
  
  var imageIndex = 0
  var numImages = 0
  var imageUID: String = ""
  
  
  fileprivate let blurView: UIVisualEffectView = {
    let view = UIVisualEffectView()
    view.translatesAutoresizingMaskIntoConstraints = false
    let effect = UIBlurEffect(style: UIBlurEffectStyle.light)
    view.effect = effect
    return view
  }()
  
  let backgroundImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    return view
  }()
  
  //set image view
  let photoImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFit
    
    return view
  }()
  
  fileprivate let alphaView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.alpha = 0
    view.backgroundColor = .black
    view.isUserInteractionEnabled = false
    return view
  }()
  
  //four labels to show tags when long pressed
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
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    initialize()
    
    self.navigationItem.title = "Photo"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped(sender:)))
    self.navigationItem.rightBarButtonItem?.tintColor = .white
    navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "GothamRounded-Light", size: 17)!], for: .normal)

    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteButtonTapped(sender:)))
    self.navigationItem.leftBarButtonItem?.tintColor = .white
    navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "GothamRounded-Light", size: 17)!], for: .normal)
    
    //swiping between photos
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
    swipeLeft.direction = .left
    self.view.addGestureRecognizer(swipeLeft)
    
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
    swipeRight.direction = .right
    self.view.addGestureRecognizer(swipeRight)
    
    let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(imageViewLongPress))
    longGesture.minimumPressDuration = 0.5
    self.view.addGestureRecognizer(longGesture)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
    self.view.addGestureRecognizer(tapGesture)
    
    
  }
  
  func cancelButtonTapped(sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  //delete button tapped
  func deleteButtonTapped(sender: UIBarButtonItem) {
    PhotoService.delete(deletePhoto: imageUID)
    dismiss(animated: true, completion: nil)
    
  }
  
  //handle swipe right and left
  func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
    for url in photoURLs {
      if URL(string: url) == self.currentURL {
        imageIndex = photoURLs.index(of: url)!
      }
    }
    switch gesture.direction {
    case UISwipeGestureRecognizerDirection.right:
      imageIndex -= 1
      if imageIndex < 0 {
        imageIndex = numImages - 1
      }
      currentURL = URL(string: photoURLs[imageIndex])
      photoImageView.kf.setImage(with: currentURL)
      backgroundImageView.kf.setImage(with: currentURL)
      
      categoryAlphaLabel.text = "Category: \(photoCategories[imageIndex])"
      occasionAlphaLabel.text = "Occasion: \(photoOccasions[imageIndex].joined(separator: ", "))"
      apparelAlphaLabel.text = "Apparel: \(photoApparels[imageIndex].joined(separator: ", "))"
      colorAlphaLabel.text = "Color: \(photoColors[imageIndex].joined(separator: ", "))"


    case UISwipeGestureRecognizerDirection.left:
      imageIndex += 1
      if imageIndex > (numImages - 1) {
        imageIndex = 0
      }
      currentURL = URL(string: photoURLs[imageIndex])
      photoImageView.kf.setImage(with: currentURL)
      backgroundImageView.kf.setImage(with: currentURL)
      categoryAlphaLabel.text = "Category: \(photoCategories[imageIndex])"
      occasionAlphaLabel.text = "Occasion: \(photoOccasions[imageIndex].joined(separator: ", "))"
      apparelAlphaLabel.text = "Apparel: \(photoApparels[imageIndex].joined(separator: ", "))"
      colorAlphaLabel.text = "Color: \(photoColors[imageIndex].joined(separator: ", "))"

    default:
      break
    }
  }
  
  func imageViewLongPress(sender: UILongPressGestureRecognizer) {
    fadeInAlphaView()
  }
  
  func imageViewTapped(sender: UITapGestureRecognizer) {
    fadeOutAlphaView()
  }
  
  private func initialize() {
  
    view.insertSubview(blurView, aboveSubview: backgroundImageView)
    view.insertSubview(photoImageView, aboveSubview: blurView)
    view.insertSubview(alphaView, aboveSubview: photoImageView)

    
    //background image view
    backgroundImageView.addToAndConstrain(insideSuper: view)
    
    //blur image view
    blurView.addToAndConstrain(insideSuper: view)
    
    //image view
    photoImageView.addToAndConstrain(insideSuper: view)
    
    //alpha view
    alphaView.addToAndConstrain(insideSuper: view)
    
    view.insertSubview(categoryAlphaLabel, aboveSubview: alphaView)
    view.insertSubview(occasionAlphaLabel, aboveSubview: alphaView)
    view.insertSubview(apparelAlphaLabel, aboveSubview: alphaView)
    view.insertSubview(colorAlphaLabel, aboveSubview: alphaView)

    
    
    //category alpha label
    view.addConstraint(NSLayoutConstraint(item: categoryAlphaLabel, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: -100))
    view.addConstraint(NSLayoutConstraint(item: categoryAlphaLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: categoryAlphaLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
    //view.addConstraint(NSLayoutConstraint(item: categoryAlphaLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
    
    
    //occasion alpha label
    view.addConstraint(NSLayoutConstraint(item: occasionAlphaLabel, attribute: .top, relatedBy: .equal, toItem: categoryAlphaLabel, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: occasionAlphaLabel, attribute: .left, relatedBy: .equal, toItem: categoryAlphaLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: occasionAlphaLabel, attribute: .right, relatedBy: .equal, toItem: categoryAlphaLabel, attribute: .right, multiplier: 1.0, constant: 0))
    //view.addConstraint(NSLayoutConstraint(item: occasionAlphaLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
    
    //apparel alpha label
    view.addConstraint(NSLayoutConstraint(item: apparelAlphaLabel, attribute: .top, relatedBy: .equal, toItem: occasionAlphaLabel, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: apparelAlphaLabel, attribute: .left, relatedBy: .equal, toItem: occasionAlphaLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: apparelAlphaLabel, attribute: .right, relatedBy: .equal, toItem: occasionAlphaLabel, attribute: .right, multiplier: 1.0, constant: 0))
    //view.addConstraint(NSLayoutConstraint(item: apparelAlphaLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
    
    //color alpha label
    view.addConstraint(NSLayoutConstraint(item: colorAlphaLabel, attribute: .top, relatedBy: .equal, toItem: apparelAlphaLabel, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: colorAlphaLabel, attribute: .left, relatedBy: .equal, toItem: apparelAlphaLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: colorAlphaLabel, attribute: .right, relatedBy: .equal, toItem: apparelAlphaLabel, attribute: .right, multiplier: 1.0, constant: 0))
    //view.addConstraint(NSLayoutConstraint(item: colorAlphaLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
    
    
    
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

      }
    )
  }


  
}

