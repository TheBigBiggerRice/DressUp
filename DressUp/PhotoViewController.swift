//
//  ExpandedPhotoViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/20/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit
import Kingfisher

final class PhotoViewController: DUViewController {
  
  var currentURL: URL?
  
  let screenWidth = UIScreen.main.bounds.width
  let screenHeight = UIScreen.main.bounds.height - 64
  
  var photoURLs: [String] = []
  var photoCategories: [String] = []
  var photoOccasions: [[String]] = [[]]
  var photoApparels: [[String]] = [[]]
  var photoColors: [[String]] = [[]]
  var photoUIDs: [String] = []
  var photoNames: [String] = []
  
  var imageIndex = 0
  
  var imageUID: String = ""
  
  fileprivate let photoScrollView: UIScrollView = {
    let view = UIScrollView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.showsHorizontalScrollIndicator = false
    view.isScrollEnabled = true
    view.isPagingEnabled = true

    return view
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
        
  }
  
  func cancelButtonTapped(sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  //delete button tapped
  func deleteButtonTapped(sender: UIBarButtonItem) {
    PhotoService.delete(deletePhoto: imageUID)
    dismiss(animated: true, completion: nil)
    
  }
  
  private func initialize() {
  
    photoScrollView.addToAndConstrain(insideSuper: view)
    
    view.backgroundColor = .white
    var previousView: UIView?
    
    for (index,url) in photoURLs.enumerated() {
      
      
      let imageURL = URL(string: url)
      
      let customView = CustomPhotoView()
      customView.translatesAutoresizingMaskIntoConstraints = false
      
      customView.backgroundView.kf.setImage(with: imageURL)
      customView.imageView.kf.setImage(with: imageURL)
      customView.nameAlphaLabel.text = photoNames[index]
      customView.categoryAlphaLabel.text = "Category: \(photoCategories[index])"
      customView.occasionAlphaLabel.text = "Occasions: \(photoOccasions[index].joined(separator: ", "))"
      customView.apparelAlphaLabel.text = "Apparel: \(photoApparels[index].joined(separator: ", "))"
      customView.colorAlphaLabel.text = "Color: \(photoColors[index].joined(separator: ", "))"
  
      photoScrollView.addSubview(customView)

      photoScrollView.addConstraint(NSLayoutConstraint(item: customView, attribute: .top, relatedBy: .equal, toItem: photoScrollView, attribute: .top, multiplier: 1.0, constant: 0))
      photoScrollView.addConstraint(NSLayoutConstraint(item: customView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenHeight))
      photoScrollView.addConstraint(NSLayoutConstraint(item: customView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth))
      
      if previousView == nil {
        
        photoScrollView.addConstraint(NSLayoutConstraint(item: customView, attribute: .left, relatedBy: .equal, toItem: photoScrollView, attribute: .left, multiplier: 1.0, constant: 0))
        
        previousView = customView
        
      } else {
        photoScrollView.addConstraint(NSLayoutConstraint(item: customView, attribute: .left, relatedBy: .equal, toItem: previousView, attribute: .right, multiplier: 1.0, constant: 0))
        
        previousView = customView
        
      }
      
    }
    photoScrollView.addConstraint(NSLayoutConstraint(item: previousView!, attribute: .right, relatedBy: .equal, toItem: photoScrollView, attribute: .right,  multiplier: 1.0, constant: 0))
    
    view.setNeedsLayout()
    view.layoutIfNeeded()
    
    for url in photoURLs {
      if URL(string: url) == currentURL {
        imageIndex = photoURLs.index(of: url)!
        photoScrollView.contentOffset = CGPoint(x: CGFloat(imageIndex) * screenWidth, y: 0)
        
      }
    }
  }
  
}

