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
    let viewControllers: [UIViewController] = [HomeViewController(), TagsPageViewController(), PhotoLibraryViewController(), TimelineViewController(), FindFriendsViewController()]
    for vc in viewControllers {
      vc.view.backgroundColor = .white
      let nav = DUNavigationController()
      nav.viewControllers = [vc]

      addChildViewController(nav)

      //nav.navigationBar.alpha = 0.2
      //nav.navigationBar.shadowImage = UIImage()
      //nav.navigationBar.isTranslucent = true
      //nav.navigationBar.alpha = 0.5
//      
//      nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
//      nav.navigationBar.shadowImage = UIImage()
//      nav.navigationBar.isTranslucent = true
//      nav.navigationBar.barTintColor = UIColor.black
//      nav.navigationBar.tintColor = .black

    }
  }
}
