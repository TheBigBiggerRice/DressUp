//
//  HomeViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/13/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit
//be able to select an occasion
//select a color
//...
//
class HomeViewController: UIViewController {
  
  
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    let homeTabBar = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), selectedImage: nil)
    tabBarItem = homeTabBar
    
    self.navigationItem.title = "Home"
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonTapped(sender:)))
    self.navigationItem.rightBarButtonItem?.tintColor = .white
  }
  
  
  func filterButtonTapped(sender: UIBarButtonItem) {
    let vc = FilterViewController()
    let nc = UINavigationController(rootViewController: vc)
    
    
    
    present(nc, animated: true, completion: nil)
  }
  
//  fileprivate let filterLabel: UILabel = {
//    let label = UILabel()
//    label.translatesAutoresizingMaskIntoConstraints = false
//    label.text = "Filters"
//  }()
}
