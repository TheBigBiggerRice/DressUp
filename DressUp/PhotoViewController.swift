//
//  ExpandedPhotoViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/20/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

final class PhotoViewController: UIViewController {
  
  var urls: URL?
  var newPhotoURLs: [String] = []
  var imageIndex = 0
  var numImages = 0
  
  //set image view
  let photoImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFit
    view.backgroundColor = .white
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
      self.urls = URL(string: newPhotoURLs[imageIndex])
      self.photoImageView.kf.setImage(with: self.urls)
    case UISwipeGestureRecognizerDirection.left:
      imageIndex += 1
      if imageIndex > (numImages - 1) {
        imageIndex = 0
      }
      self.urls = URL(string: newPhotoURLs[imageIndex])
      self.photoImageView.kf.setImage(with: self.urls)
    default:
      break
    }
  }
  
  private func initialize() {
    view.addSubview(photoImageView)
    
    view.addConstraint(NSLayoutConstraint(item: photoImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 64))
    view.addConstraint(NSLayoutConstraint(item: photoImageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: photoImageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: photoImageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
  }
}
