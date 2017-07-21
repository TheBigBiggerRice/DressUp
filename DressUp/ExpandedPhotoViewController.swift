//
//  ExpandedPhotoViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/20/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

final class ExpandedPhotoViewController: UIViewController {
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
  }
  func cancelButtonTapped(sender: UIBarButtonItem) {

    dismiss(animated: true, completion: nil)
  }
  
  private func initialize() {
    view.addSubview(photoImageView)
    
    view.addConstraint(NSLayoutConstraint(item: photoImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 64))
    view.addConstraint(NSLayoutConstraint(item: photoImageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: photoImageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: photoImageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
  }

}

