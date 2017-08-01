//
//  DUTabBarController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/30/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit


final class DUTabBarController: UINavigationController {
  
  fileprivate let homeVC = HomeViewController()
  fileprivate let cameraVC = CameraViewController()
  fileprivate let libraryVC = LibraryViewController()
  
  private let tabBar: CustomTabBar = {
    let tab = CustomTabBar()
    tab.translatesAutoresizingMaskIntoConstraints = false
    return tab
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialize()
    tabBar.delegate = self
    
    
    let viewControllers: [UIViewController] = [homeVC, cameraVC, libraryVC]
    
    for vc in viewControllers {
      vc.view.backgroundColor = .white
      
      let nav = DUNavigationController()
      
      nav.viewControllers = [vc]
      
      addChildViewController(nav)
  
    }
    setViewControllers([homeVC], animated: false)
    
  }
  private func initialize() {
    
    view.addSubview(tabBar)
    
    view.addConstraint(NSLayoutConstraint(item: tabBar, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: tabBar, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: tabBar, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: tabBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    
  }

  
}

extension DUTabBarController: CustomTabBarDelegate {
  func customTabBar(_ tabBar: CustomTabBar, didTapButtonAtIndex index: Int) {
    if index == 0 {
      setViewControllers([homeVC], animated: false)
      
    }
    else if index == 1 {
      setViewControllers([cameraVC], animated: false)
    }
    else if index == 2 {
      setViewControllers([libraryVC], animated: false)
    }
  }
}
