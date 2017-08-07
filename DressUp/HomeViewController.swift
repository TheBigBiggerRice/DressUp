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
final class HomeViewController: DUViewController {
  
  fileprivate var homeController: HomeController = HomeController()
  
  fileprivate var homeTableView: UITableView = UITableView()
  
  fileprivate let occasionLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Occasion:"
    
    
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let apparelLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Apparel:"
    
    
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let colorLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Color:"
    
    
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let randomizeButton: DUButton = {
    let button = DUButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Randomize", for: .normal)
    button.titleLabel?.font = UIFont(name: "GothamRounded-Light", size: 17)
    button.backgroundColor = UIColor.royalBlue
    button.layer.cornerRadius = 5
    return button
  }()
  
  deinit {
    randomizeButton.removeTarget(self, action: nil, for: .allEvents)
  }
  
  private func initialize() {
    
    view.addSubview(occasionLabel)
    view.addSubview(apparelLabel)
    view.addSubview(colorLabel)
    view.addSubview(randomizeButton)
    
    randomizeButton.addTarget(self, action: #selector(randomizeButtonTapped), for: .touchUpInside)
    
    //occasion label
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 375))
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
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
    
    //randomize button
    view.addConstraint(NSLayoutConstraint(item: randomizeButton, attribute: .top, relatedBy: .equal, toItem: colorLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: randomizeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200))
    view.addConstraint(NSLayoutConstraint(item: randomizeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    view.addConstraint(NSLayoutConstraint(item: randomizeButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
    
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    view.backgroundColor = .yellow
    initialize()
    
    homeController.delegate = self

    homeTableView.isScrollEnabled = false
    
    navigationItem.title = "Home"
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonTapped(sender:)))
    
    navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "GothamRounded-Light", size: 17)!], for: .normal)
    
    homeTableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 375)
    homeTableView.delegate = self
    homeTableView.dataSource = self
    homeTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
    homeTableView.backgroundColor = .white
    
    view.addSubview(homeTableView)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    homeController.redownload()
  }
  
  
  func filterButtonTapped(sender: UIBarButtonItem) {
    let vc = FilterViewController()
    vc.delegate = self
    let nc = UINavigationController(rootViewController: vc)
    present(nc, animated: true, completion: nil)
    
  }
  
  func randomizeButtonTapped() {
    
    let vc = RandomizePhotoViewController()
    
    let nc = UINavigationController(rootViewController: vc)
    
    vc.topPhotos = homeController.filteredTopPhotoCollection
    vc.pantsPhotos = homeController.filteredPantsPhotoCollection
    vc.footwearPhotos = homeController.filteredFootwearPhotoCollection
    
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
  
  func filterViewControllerDidFinishFiltering(_ controller: FilterViewController, withOccasion occasion: String, andApparel apparel: String, andColor color: String) {
    
    homeController.occasion = occasion.components(separatedBy: ", ")
    homeController.apparel = apparel.components(separatedBy: ", ")
    homeController.color = color.components(separatedBy: ", ")
    
    occasionLabel.text = "Occasion: \(occasion)"
    apparelLabel.text = "Apparel: \(apparel)"
    colorLabel.text = "Color: \(color)"
    
    homeTableView.reloadData()
  }
  
}

extension HomeViewController: HomeControllerDelegate {
  
  func homeControllerShouldReloadData(_ controller: HomeController) {
    homeTableView.reloadData()
  }
  
}
