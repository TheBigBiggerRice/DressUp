//
//  HomeViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/13/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

private let screenWidth = UIScreen.main.bounds.size.width

//HomeViewController 
final class HomeViewController: UIViewController {
  
  fileprivate var homeController: HomeController = HomeController()
  
  
  fileprivate var homeTableView: UITableView = UITableView()
  
  fileprivate let currentFiltersLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Current filters:"
    label.backgroundColor = .green
    label.textColor = .white
    label.lineBreakMode =  .byWordWrapping
    return label
  }()
  
  fileprivate let occasionLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Occasion:"
    label.textColor = .white
    label.backgroundColor = .blue
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let apparelLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Apparel:"
    label.textColor = .white
    label.backgroundColor = .purple
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let colorLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Color:"
    label.textColor = .white
    label.backgroundColor = .black
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  private func initialize() {
    
    view.addSubview(currentFiltersLabel)
    view.addSubview(occasionLabel)
    view.addSubview(apparelLabel)
    view.addSubview(colorLabel)
    
    //current filters label
    view.addConstraint(NSLayoutConstraint(item: currentFiltersLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 439))
    view.addConstraint(NSLayoutConstraint(item: currentFiltersLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: currentFiltersLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth))
    view.addConstraint(NSLayoutConstraint(item: currentFiltersLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    
    //occasion label
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .top, relatedBy: .equal, toItem: currentFiltersLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .left, relatedBy: .equal, toItem: currentFiltersLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth))
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    
    //apparel label
    view.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .top, relatedBy: .equal, toItem: occasionLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .left, relatedBy: .equal, toItem: occasionLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth))
    view.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    
    //color label
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .top, relatedBy: .equal, toItem: apparelLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .left, relatedBy: .equal, toItem: apparelLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    initialize()
    homeController.delegate = self
    let homeTabBar = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), selectedImage: nil)
    tabBarItem = homeTabBar
    
    self.navigationItem.title = "Home"
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonTapped(sender:)))
    self.navigationItem.rightBarButtonItem?.tintColor = .white
    
    homeTableView.frame = CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: 375)
    homeTableView.delegate = self
    homeTableView.dataSource = self
    homeTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
    homeTableView.backgroundColor = .white
    //homeTableView.tableFooterView
    
    self.view.addSubview(homeTableView)
  }
  
  func filterButtonTapped(sender: UIBarButtonItem) {
    let vc = FilterViewController()
    vc.delegate = self
    let nc = UINavigationController(rootViewController: vc)
    present(nc, animated: true, completion: nil)
  }
  
}

extension HomeViewController: UITableViewDelegate {
  
}

extension HomeViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return homeController.tableView(tableView, numberOfRowsInSection: section)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return homeController.tableView(tableView, heightForRowAt: indexPath)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return homeController.tableView(tableView, cellForRowAt: indexPath)
  }
  
}

extension HomeViewController: FilterViewControllerDelegete {
  
  func passData(passOccasionText: String, passApparelText: String, passColorText: String) {
    occasionLabel.text = "Occasion: \(passOccasionText)"
    apparelLabel.text = "Apparel: \(passApparelText)"
    colorLabel.text = "Color: \(passColorText)"
    
  }
}

extension HomeViewController: HomeControllerDelegate {
  
  func homeControllerShouldReloadData(_ controller: HomeController) {
    homeTableView.reloadData()
  }
  
}
