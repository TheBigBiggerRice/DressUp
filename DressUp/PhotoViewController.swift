//
//  ExpandedPhotoViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/20/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

final class PhotoViewController: DUViewController {
  
  var urls: URL?
  var newPhotoURLs: [String] = []
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
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    initialize()
    
    self.navigationItem.title = "Photo"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped(sender:)))
    self.navigationItem.rightBarButtonItem?.tintColor = .white
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteButtonTapped(sender:)))
    self.navigationItem.leftBarButtonItem?.tintColor = .white
    
    //swiping between photos
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
    swipeLeft.direction = .left
    self.view.addGestureRecognizer(swipeLeft)
    
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
    swipeRight.direction = .right
    self.view.addGestureRecognizer(swipeRight)
    
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
    for url in newPhotoURLs {
      if URL(string: url) == self.urls {
        imageIndex = newPhotoURLs.index(of: url)!
      }
    }
    switch gesture.direction {
    case UISwipeGestureRecognizerDirection.right:
      imageIndex -= 1
      if imageIndex < 0 {
        imageIndex = numImages - 1
      }
      urls = URL(string: newPhotoURLs[imageIndex])
      photoImageView.kf.setImage(with: urls)
      backgroundImageView.kf.setImage(with: urls)
    case UISwipeGestureRecognizerDirection.left:
      imageIndex += 1
      if imageIndex > (numImages - 1) {
        imageIndex = 0
      }
      urls = URL(string: newPhotoURLs[imageIndex])
      photoImageView.kf.setImage(with: urls)
      backgroundImageView.kf.setImage(with: urls)
    default:
      break
    }
  }
  
  private func initialize() {
    
    //background image view
    backgroundImageView.addToAndConstrain(insideSuper: view)
    
    //blur image view
    blurView.addToAndConstrain(insideSuper: view)
    
    //image view
    photoImageView.addToAndConstrain(insideSuper: view)
    
    view.insertSubview(blurView, aboveSubview: backgroundImageView)
    view.insertSubview(photoImageView, aboveSubview: blurView)
  }
}


















