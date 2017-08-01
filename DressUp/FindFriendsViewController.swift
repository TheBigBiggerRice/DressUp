//
//  FindFriendsViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/13/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

class FindFriendsViewController: DUViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let findFriendsTabBar = UITabBarItem(title: "Friends", image: #imageLiteral(resourceName: "friends"), selectedImage: nil)
    tabBarItem = findFriendsTabBar
    
    self.navigationItem.title = "Friends"
  }
}
