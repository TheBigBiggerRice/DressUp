//
//  ExpandedPhotoViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/20/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

final class ExpandedPhotoViewController: UIViewController {
  
  var imageIndex = 0
  var urls: URL?
  var numImages = 0
  var photoIndexxed: [String] = []

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
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Tags", style: .plain, target: self, action: nil)
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
  //find the index of a url for the image
  //increase/decrease the index
  //match the index with new image url
  //we now have urlString and photoIndexed, find the index of urlString within photoIndexed

  func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
    //now I have the index of the image url of the current image
    for urll in photoIndexxed {
      //print(urll)
      //this line is errorneous
      //if I do this, the image index is always going to be the same, because self.urls remains the same
      //corrected
      if URL(string: urll) == self.urls {
        imageIndex = photoIndexxed.index(of: urll)!
      }
      //depending on left or right, decrease or increase the index, and match the index to the image url
    }
    
    switch gesture.direction {
    case UISwipeGestureRecognizerDirection.right:
      print("swipe right")
      imageIndex -= 1
      //this should solve index out of range problem? APPARENTLY NOT.
      if imageIndex < 0 {
        imageIndex = numImages - 1
      }
      self.urls = URL(string: photoIndexxed[imageIndex])
      self.photoImageView.kf.setImage(with: self.urls)
    case UISwipeGestureRecognizerDirection.left:
      print("swipe left")
      imageIndex += 1
      if imageIndex > (numImages - 1) {
        imageIndex = 0
      }
      self.urls = URL(string: photoIndexxed[imageIndex])
      self.photoImageView.kf.setImage(with: self.urls)
    default:
      break
    }
  }
  //remaining bugs: does not function properlly when additional photos are added in the same run
  
  
  private func initialize() {
    view.addSubview(photoImageView)
    
    view.addConstraint(NSLayoutConstraint(item: photoImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 64))
    view.addConstraint(NSLayoutConstraint(item: photoImageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: photoImageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: photoImageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
  }
}
