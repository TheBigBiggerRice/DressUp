//
//  FilterViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/25/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegete: class {
  func filterViewControllerDidFinishFiltering(_ controller: FilterViewController, withOccasion occasion: String, andApparel apparel: String, andColor color: String)
}

final class FilterViewController: DUViewController {
  
  let screenWidth = UIScreen.main.bounds.width

  weak var delegate: FilterViewControllerDelegete?

  var nonRepeatAggregateOccasionTags = Set<String>()
  var nonRepeatAggregateApparelTags = Set<String>()
  var nonRepeatAggregateColorTags = Set<String>()
  
  var occasionButtons = [UIButton]()
  var apparelButtons = [UIButton]()
  var colorButtons = [UIButton]()
  
  var occasionButtonsNumLines = 1
  var apparelButtonNumLines = 1
  var colorButtonNumLines = 1
  
  var occasionTags = [String]()
  var apparelTags = [String]()
  var colorTags = [String]()
  
  var occasion = ""
  var apparel = ""
  var color = ""
  
//  fileprivate let backgroundView: UIImageView = {
//    let view = UIImageView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    view.contentMode = .scaleAspectFill
//    view.clipsToBounds = true
//    view.backgroundColor = UIColor.lighterBlack
//    return view
//  }()
  
  fileprivate let overviewScrollView: UIScrollView = {
    let view = UIScrollView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.isScrollEnabled = true
    view.showsVerticalScrollIndicator = false
    return view
  }()

  fileprivate let occasionLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Occasion"
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let apparelLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Apparel"
    
    
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let colorLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Colors"
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let switchOccasion: UISwitch = {
    let mySwitch = UISwitch()
    mySwitch.translatesAutoresizingMaskIntoConstraints = false
    mySwitch.isOn = false
    mySwitch.setOn(false, animated: false)
    mySwitch.addTarget(self, action: #selector(switchOccasionValueDidChange(sender:)), for: .valueChanged)
    return mySwitch
  }()
  
  fileprivate let switchApparel: UISwitch = {
    let mySwitch = UISwitch()
    mySwitch.translatesAutoresizingMaskIntoConstraints = false
    mySwitch.isOn = false
    mySwitch.setOn(false, animated: false)
    mySwitch.addTarget(self, action: #selector(switchApparelValueDidChange(sender:)), for: .valueChanged)
    return mySwitch
  }()
  
  fileprivate let switchColor: UISwitch = {
    let mySwitch = UISwitch()
    mySwitch.translatesAutoresizingMaskIntoConstraints = false
    mySwitch.isOn = false
    mySwitch.setOn(false, animated: false)
    mySwitch.addTarget(self, action: #selector(switchColorValueDidChange(sender:)), for: .valueChanged)
    return mySwitch
  }()
  
  fileprivate let occasionButtonsView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.alpha = 0
    return view
  }()
  
  fileprivate let apparelButtonsView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.alpha = 0
    return view
  }()
  
  fileprivate let colorButtonsView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.alpha = 0
    return view
  }()

  
  
  fileprivate let confirmButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Confirm", for: .normal)
    button.backgroundColor = UIColor.royalBlue
    button.layer.cornerRadius = 5
    return button
  }()
  

  var occasionButtonsViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
  var apparelButtonsViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
  var colorButtonsViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialize()

    self.navigationItem.title = "Filter"
    self.view.backgroundColor = .white
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped(sender:)))
    self.navigationItem.rightBarButtonItem?.tintColor = .white
    navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "GothamRounded-Light", size: 17)!], for: .normal)
  }
  
  //cancel button
  private dynamic func cancelButtonTapped(sender: UIBarButtonItem) {
    
    dismiss(animated: true, completion: nil)
  }
  
  //occasion switch
  private dynamic func switchOccasionValueDidChange(sender: UISwitch) {
    
    if switchOccasion.isOn == true {
      addConstraintsForOccasionButtons()
      occasionButtonsViewHeightConstraint.constant = CGFloat(occasionButtonsNumLines * 30 + 10)
      occasionButtonsNumLines = 1
      occasionButtonsView.alpha = 1
      UIView.animate(
        withDuration: 0.2,
        delay: 0,
        options: .curveEaseIn,
        animations: { [weak self] _ in
          self?.view.layoutIfNeeded()
        }
      )
      
    } else {
      occasionButtonsViewHeightConstraint.constant = 0
      occasionButtonsView.alpha = 0
      UIView.animate(
        withDuration: 0.2,
        delay: 0,
        options: .curveEaseIn,
        animations: { [weak self] _ in
          self?.view.layoutIfNeeded()
        }
      )
    }
  }
  
  //apparel switch
  private dynamic func switchApparelValueDidChange(sender: UISwitch) {
    
    if switchApparel.isOn == true {
      addConstraintsForApparelButtons()
      apparelButtonsViewHeightConstraint.constant = CGFloat(apparelButtonNumLines * 30 + 10)
      apparelButtonNumLines = 1
      apparelButtonsView.alpha = 1

      UIView.animate(
        withDuration: 0.2,
        delay: 0,
        options: .curveEaseIn,
        animations: { [weak self] _ in
          self?.view.layoutIfNeeded()
        }
      )
      
    } else {
      apparelButtonsViewHeightConstraint.constant = 0
      apparelButtonsView.alpha = 0

      UIView.animate(
        withDuration: 0.2,
        delay: 0,
        options: .curveEaseIn,
        animations: { [weak self] _ in
          self?.view.layoutIfNeeded()
        }
      )
    }
  }
  
  //color switch
  private dynamic func switchColorValueDidChange(sender: UISwitch) {
    
    if switchColor.isOn == true {
      addConstraintsForColorButtons()
      colorButtonsViewHeightConstraint.constant = CGFloat(colorButtonNumLines * 30 + 10)
      colorButtonNumLines = 1
      colorButtonsView.alpha = 1

      UIView.animate(
        withDuration: 0.2,
        delay: 0,
        options: .curveEaseIn,
        animations: { [weak self] _ in
          self?.view.layoutIfNeeded()
        }
      )
    } else {
      colorButtonsViewHeightConstraint.constant = 0
      colorButtonsView.alpha = 0

      UIView.animate(
        withDuration: 0.2,
        delay: 0,
        options: .curveEaseIn,
        animations: { [weak self] _ in
          self?.view.layoutIfNeeded()
        }
      )
    }
  }
  
  deinit {
    confirmButton.removeTarget(self, action: nil, for: .allEvents)
  }
  
  private func initialize() {
    
    //backgroundView.addToAndConstrain(insideSuper: view)
    //view.backgroundColor = UIColor.lighterBlack
    
    view.addSubview(overviewScrollView)
    //view.insertSubview(overviewScrollView, aboveSubview: backgroundView)
    
    //occasion filter
    overviewScrollView.addSubview(occasionLabel)
    overviewScrollView.addSubview(occasionButtonsView)
    overviewScrollView.addSubview(switchOccasion)
    
    //apparel filter
    overviewScrollView.addSubview(apparelLabel)
    overviewScrollView.addSubview(apparelButtonsView)
    overviewScrollView.addSubview(switchApparel)
    
    //color filter
    overviewScrollView.addSubview(colorLabel)
    overviewScrollView.addSubview(colorButtonsView)
    overviewScrollView.addSubview(switchColor)
    
    //confirm button
    overviewScrollView.addSubview(confirmButton)
    
    confirmButton.addTarget(self, action: #selector(FilterViewController.confirmButtonTapped), for: .touchUpInside)
    
    //screen width
    let screenWidth = UIScreen.main.bounds.size.width
    
    //overview scroll view
    view.addConstraint(NSLayoutConstraint(item: overviewScrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: overviewScrollView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: overviewScrollView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: overviewScrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0))
    
    //occasion label
    overviewScrollView.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .top, relatedBy: .equal, toItem: overviewScrollView, attribute: .top, multiplier: 1.0, constant: 0))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .left, relatedBy: .equal, toItem: overviewScrollView, attribute: .left, multiplier: 1.0, constant: 0))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    
    //switch occasion
    overviewScrollView.addConstraint(NSLayoutConstraint(item: switchOccasion, attribute: .top, relatedBy: .equal, toItem: occasionLabel, attribute: .top, multiplier: 1.0, constant: 10))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: switchOccasion, attribute: .left, relatedBy: .equal, toItem: overviewScrollView, attribute: .left, multiplier: 1.0, constant: screenWidth - 60))
    
    //occasion buttons view
    overviewScrollView.addConstraint(NSLayoutConstraint(item: occasionButtonsView, attribute: .top, relatedBy: .equal, toItem: occasionLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: occasionButtonsView, attribute: .left, relatedBy: .equal, toItem: occasionLabel, attribute: .left, multiplier: 1.0, constant: 0))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: occasionButtonsView, attribute: .right, relatedBy: .equal, toItem: occasionLabel, attribute: .right, multiplier: 1.0, constant: 0))
    occasionButtonsViewHeightConstraint = NSLayoutConstraint(item: occasionButtonsView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
    overviewScrollView.addConstraint(occasionButtonsViewHeightConstraint)
    
    //apparel label
    overviewScrollView.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .top, relatedBy: .equal, toItem: occasionButtonsView, attribute: .bottom, multiplier: 1.0, constant: 0))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .left, relatedBy: .equal, toItem: occasionButtonsView, attribute: .left, multiplier: 1.0, constant: 0))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    
    //switch apparel
    overviewScrollView.addConstraint(NSLayoutConstraint(item: switchApparel, attribute: .top, relatedBy: .equal, toItem: apparelLabel, attribute: .top, multiplier: 1.0, constant: 10))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: switchApparel, attribute: .left, relatedBy: .equal, toItem: overviewScrollView, attribute: .left, multiplier: 1.0, constant: screenWidth - 60))
    
    //apparel buttons view
    overviewScrollView.addConstraint(NSLayoutConstraint(item: apparelButtonsView, attribute: .top, relatedBy: .equal, toItem: apparelLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: apparelButtonsView, attribute: .left, relatedBy: .equal, toItem: apparelLabel, attribute: .left, multiplier: 1.0, constant: 0))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: apparelButtonsView, attribute: .right, relatedBy: .equal, toItem: apparelLabel, attribute: .right, multiplier: 1.0, constant: 0))
    apparelButtonsViewHeightConstraint = NSLayoutConstraint(item: apparelButtonsView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
    overviewScrollView.addConstraint(apparelButtonsViewHeightConstraint)
    
    //color label
    overviewScrollView.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .top, relatedBy: .equal, toItem: apparelButtonsView, attribute: .bottom, multiplier: 1.0, constant: 0))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .left, relatedBy: .equal, toItem: apparelButtonsView, attribute: .left, multiplier: 1.0, constant: 0))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))

    //switch color
    overviewScrollView.addConstraint(NSLayoutConstraint(item: switchColor, attribute: .top, relatedBy: .equal, toItem: colorLabel, attribute: .top, multiplier: 1.0, constant: 10))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: switchColor, attribute: .left, relatedBy: .equal, toItem: overviewScrollView, attribute: .left, multiplier: 1.0, constant: screenWidth - 60))
    
    //color buttons view
    overviewScrollView.addConstraint(NSLayoutConstraint(item: colorButtonsView, attribute: .top, relatedBy: .equal, toItem: colorLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: colorButtonsView, attribute: .left, relatedBy: .equal, toItem: colorLabel, attribute: .left, multiplier: 1.0, constant: 0))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: colorButtonsView, attribute: .right, relatedBy: .equal, toItem: colorLabel, attribute: .right, multiplier: 1.0, constant: 0))
    colorButtonsViewHeightConstraint = NSLayoutConstraint(item: colorButtonsView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
    overviewScrollView.addConstraint(colorButtonsViewHeightConstraint)
    
    //confirm button
    overviewScrollView.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .top, relatedBy: .equal, toItem: colorButtonsView, attribute: .bottom, multiplier: 1.0, constant: 100))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .centerX, relatedBy: .equal, toItem: overviewScrollView, attribute: .centerX, multiplier: 1.0, constant: 0))
    overviewScrollView.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .bottom, relatedBy: .equal, toItem: overviewScrollView, attribute: .bottom, multiplier: 1.0, constant: -50))
    
  }
  
  func addOccasionButtons() {
    for button in occasionButtons {
      button.removeFromSuperview()
    }
    occasionButtons.removeAll()
    for occasion in nonRepeatAggregateOccasionTags {
      let button = createButton()
      button.setTitle(occasion, for: .normal)
      occasionButtons.append(button)
    }
  }
  
  func addConstraintsForOccasionButtons() {
    addOccasionButtons()
    var buttonsLength: CGFloat = 0
    
    var previousOccasionButton: UIButton?
    var firstOccasionButton: UIButton?

    for (index, button) in occasionButtons.enumerated() {
      
      button.tag = index
      button.addTarget(self, action: #selector(FilterViewController.occasionButtonTapped(sender:)), for: .touchUpInside)
      
      buttonsLength += button.intrinsicContentSize.width + 25
      
      if buttonsLength < screenWidth {
        
        if nil == firstOccasionButton {
          previousOccasionButton = button
          firstOccasionButton = button
          occasionButtonsView.addSubview(button)
          occasionButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: occasionButtonsView, attribute: .top, multiplier: 1.0, constant: 0))
          
          occasionButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: occasionButtonsView, attribute: .left, multiplier: 1.0, constant: 5))
          occasionButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: button.intrinsicContentSize.width + 20))
          occasionButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
          occasionButtonsNumLines += 1

        } else {
          occasionButtonsView.addSubview(button)
          occasionButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: previousOccasionButton, attribute: .top, multiplier: 1.0, constant: 0))
          occasionButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: previousOccasionButton, attribute: .right, multiplier: 1.0, constant: 5))
          occasionButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: button.intrinsicContentSize.width + 20))
          occasionButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: previousOccasionButton, attribute: .bottom, multiplier: 1.0, constant: 0))

          previousOccasionButton = button
        }
        
      }
      if buttonsLength > screenWidth {
        buttonsLength = button.intrinsicContentSize.width + 25
        
        occasionButtonsView.addSubview(button)
        occasionButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: firstOccasionButton, attribute: .bottom, multiplier: 1.0, constant: 5))
        occasionButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: firstOccasionButton, attribute: .left, multiplier: 1.0, constant: 0))
        occasionButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: button.intrinsicContentSize.width + 20))
        occasionButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
        occasionButtonsNumLines += 1

        previousOccasionButton = button
        firstOccasionButton = button
        
      }
    }
  }
  
  func addApparelButtons() {
    for button in apparelButtons {
      button.removeFromSuperview()
    }
    apparelButtons.removeAll()
    for apparel in nonRepeatAggregateApparelTags {
      let button = createButton()
      button.setTitle(apparel, for: .normal)
      apparelButtons.append(button)
    }
  }
  
  func addConstraintsForApparelButtons() {
    addApparelButtons()
    var buttonsLength: CGFloat = 0
    
    var previousApparelButton: UIButton?
    var firstApparelButton: UIButton?
    
    for (index, button) in apparelButtons.enumerated() {
      
      button.tag = index
      button.addTarget(self, action: #selector(FilterViewController.apparelButtonTapped(sender:)), for: .touchUpInside)

      
      buttonsLength += button.intrinsicContentSize.width + 25
      
      if buttonsLength < screenWidth {
        
        if nil == firstApparelButton {
          previousApparelButton = button
          firstApparelButton = button
          apparelButtonsView.addSubview(button)
          apparelButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: apparelButtonsView, attribute: .top, multiplier: 1.0, constant: 0))
          
          apparelButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: apparelButtonsView, attribute: .left, multiplier: 1.0, constant: 5))
          apparelButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: button.intrinsicContentSize.width + 20))
          apparelButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
          apparelButtonNumLines += 1
          
        } else {
          apparelButtonsView.addSubview(button)
          apparelButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: previousApparelButton, attribute: .top, multiplier: 1.0, constant: 0))
          apparelButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: previousApparelButton, attribute: .right, multiplier: 1.0, constant: 5))
          apparelButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: button.intrinsicContentSize.width + 20))
          apparelButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: previousApparelButton, attribute: .bottom, multiplier: 1.0, constant: 0))
          
          previousApparelButton = button
        }
        
      }
      if buttonsLength > screenWidth {
        buttonsLength = button.intrinsicContentSize.width + 25
        
        apparelButtonsView.addSubview(button)
        apparelButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: firstApparelButton, attribute: .bottom, multiplier: 1.0, constant: 5))
        apparelButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: firstApparelButton, attribute: .left, multiplier: 1.0, constant: 0))
        apparelButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: button.intrinsicContentSize.width + 20))
        apparelButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
        apparelButtonNumLines += 1
        
        previousApparelButton = button
        firstApparelButton = button
        
      }
    }
    
    
  }

  
  func addColorButtons() {
    for button in colorButtons {
      button.removeFromSuperview()
    }
    colorButtons.removeAll()
    for color in nonRepeatAggregateColorTags {
      let button = createButton()
      button.setTitle(color, for: .normal)
      colorButtons.append(button)
    }
  }
  
  func addConstraintsForColorButtons() {
    addColorButtons()
    var buttonsLength: CGFloat = 0
    
    var previousColorButton: UIButton?
    var firstColorButton: UIButton?
    
    for (index, button) in colorButtons.enumerated() {
      
      button.tag = index
      button.addTarget(self, action: #selector(FilterViewController.colorButtonTapped(sender:)), for: .touchUpInside)

      
      buttonsLength += button.intrinsicContentSize.width + 25
      
      if buttonsLength < screenWidth {
        
        if nil == firstColorButton {
          previousColorButton = button
          firstColorButton = button
          colorButtonsView.addSubview(button)
          colorButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: colorButtonsView, attribute: .top, multiplier: 1.0, constant: 0))
          
          colorButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: colorButtonsView, attribute: .left, multiplier: 1.0, constant: 5))
          colorButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: button.intrinsicContentSize.width + 20))
          colorButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
          colorButtonNumLines += 1
          
        } else {
          colorButtonsView.addSubview(button)
          colorButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: previousColorButton, attribute: .top, multiplier: 1.0, constant: 0))
          colorButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: previousColorButton, attribute: .right, multiplier: 1.0, constant: 5))
          colorButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: button.intrinsicContentSize.width + 20))
          colorButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: previousColorButton, attribute: .bottom, multiplier: 1.0, constant: 0))
          
          previousColorButton = button
        }
        
      }
      if buttonsLength > screenWidth {
        buttonsLength = button.intrinsicContentSize.width + 25
        
        colorButtonsView.addSubview(button)
        colorButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: firstColorButton, attribute: .bottom, multiplier: 1.0, constant: 5))
        colorButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: firstColorButton, attribute: .left, multiplier: 1.0, constant: 0))
        colorButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: button.intrinsicContentSize.width + 20))
        colorButtonsView.addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
        colorButtonNumLines += 1
        
        previousColorButton = button
        firstColorButton = button
        
      }
    }
    
    
  }


  func createButton() -> DUButton {
    let button = DUButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.layer.cornerRadius = 12.5
    button.layer.backgroundColor = UIColor.lighterBlue.cgColor
    return button
  }
  
  private dynamic func occasionButtonTapped(sender: UIButton) {
    for index in 0 ..< nonRepeatAggregateOccasionTags.count {
      if sender.isSelected {
        if sender.tag == index {
          sender.layer.backgroundColor = UIColor.lighterBlue.cgColor
          occasionTags = occasionTags.filter{ $0 != sender.titleLabel?.text }
          sender.isSelected = false
        }
      }
      else {
        if sender.tag == index {
          sender.layer.backgroundColor = UIColor.royalBlue.cgColor
          occasionTags = occasionTags.filter{ $0 != sender.titleLabel?.text }
          occasionTags.append((sender.titleLabel?.text)!)
          sender.isSelected = true
        }
      }
    }
  }
  private dynamic func apparelButtonTapped(sender: UIButton) {
    for index in 0 ..< nonRepeatAggregateApparelTags.count {
      if sender.isSelected {
        if sender.tag == index {
          sender.layer.backgroundColor = UIColor.lighterBlue.cgColor
          apparelTags = apparelTags.filter{ $0 != sender.titleLabel?.text }
          sender.isSelected = false
        }
      }
      else {
        if sender.tag == index {
          sender.layer.backgroundColor = UIColor.royalBlue.cgColor
          apparelTags = apparelTags.filter{ $0 != sender.titleLabel?.text }
          apparelTags.append((sender.titleLabel?.text)!)
          sender.isSelected = true
        }
      }
    }
  }
  private dynamic func colorButtonTapped(sender: UIButton) {
    for index in 0 ..< nonRepeatAggregateColorTags.count {
      if sender.isSelected {
        if sender.tag == index {
          sender.layer.backgroundColor = UIColor.lighterBlue.cgColor
          colorTags = colorTags.filter{ $0 != sender.titleLabel?.text }
          sender.isSelected = false
        }
      }
      else {
        if sender.tag == index {
          sender.layer.backgroundColor = UIColor.royalBlue.cgColor
          colorTags = colorTags.filter{ $0 != sender.titleLabel?.text }
          colorTags.append((sender.titleLabel?.text)!)
          sender.isSelected = true
        }
      }
    }
  }
  private dynamic func confirmButtonTapped() {
    
    occasion = occasionTags.joined(separator: ", ")
    apparel = apparelTags.joined(separator: ", ")
    color = colorTags.joined(separator: ", ")
    
    
    delegate?.filterViewControllerDidFinishFiltering(self, withOccasion: occasion, andApparel: apparel, andColor: color)
    
    dismiss(animated: true)

    
  }
  
}


