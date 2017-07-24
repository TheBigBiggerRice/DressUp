//
//  MainTabBarController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/14/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//
import UIKit


class MainTabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let viewControllers: [UIViewController] = [HomeViewController(), CameraViewController(), LibraryViewController(), TimelineViewController(), FindFriendsViewController()]
    for vc in viewControllers {
      vc.view.backgroundColor = .white
      let nav = DUNavigationController()
      nav.viewControllers = [vc]
      
      addChildViewController(nav)
      
      
      
    }
  }
}
