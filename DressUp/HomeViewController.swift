//
//  HomeViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/13/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let homeTabBar = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), selectedImage: nil)
    tabBarItem = homeTabBar
    
    self.navigationItem.title = "Home"
  }
}
