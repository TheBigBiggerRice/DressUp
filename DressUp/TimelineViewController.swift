//
//  TimelineViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/13/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let timelineTabBar = UITabBarItem(title: "Timeline", image: #imageLiteral(resourceName: "user"), selectedImage: nil)
    tabBarItem = timelineTabBar
    
    self.navigationItem.title = "Timeline"
    
    
  }
}
