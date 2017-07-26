//
//  FilterViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/25/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit

final class FilterViewController: UIViewController {
  
  //choose which filters to enable
  fileprivate let occasionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Occasion"
    label.textColor = .white
    label.backgroundColor = .blue
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let apparelLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Apparel"
    label.textColor = .white
    label.backgroundColor = .red
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let colorLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Colors"
    label.textColor = .white
    label.backgroundColor = .brown
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
  
  //text fields
  fileprivate let occasionText: DUTextField = {
    let textField = DUTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "What is the occasion?"
    textField.alpha = 0
    return textField
  }()
  
  fileprivate let apparelText: DUTextField = {
    let textField = DUTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "What is the apparel?"
    textField.alpha = 0
    return textField
  }()
  
  fileprivate let colorText: DUTextField = {
    let textField = DUTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "What is the color?"
    textField.alpha = 0
    return textField
  }()
  
  //confirm
  fileprivate let confirmButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Confirm", for: .normal)
    button.backgroundColor = .orange
    return button
  }()
  
  var occasionTextHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
  var apparelTextHeightConstraints: NSLayoutConstraint = NSLayoutConstraint()
  var colorTextHeightConstraints: NSLayoutConstraint = NSLayoutConstraint()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialize()
    
    self.navigationItem.title = "Filter"
    self.view.backgroundColor = .white
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped(sender:)))
    self.navigationItem.rightBarButtonItem?.tintColor = .white
    
    occasionText.delegate = self
    apparelText.delegate = self
    colorText.delegate = self
  }
  
  //cancel button
  func cancelButtonTapped(sender: UIBarButtonItem) {
    print("cancel tapped")
    dismiss(animated: true, completion: nil)
  }
  
  //occasion switch
  func switchOccasionValueDidChange(sender: UISwitch) {
    print("switch occasion tapped")
    if switchOccasion.isOn == true {
      occasionTextHeightConstraint.constant = 50
      occasionText.alpha = 1
      UIView.animate(
        withDuration: 0.2,
        delay: 0,
        options: .curveEaseIn,
        animations: { [weak self] _ in
          self?.view.layoutIfNeeded()
        }
      )
      
    } else {
      occasionTextHeightConstraint.constant = 0
      occasionText.alpha = 0
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
  func switchApparelValueDidChange(sender: UISwitch) {
    print("switch apparel tapped")
    if switchApparel.isOn == true {
      apparelTextHeightConstraints.constant = 50
      apparelText.alpha = 1
      UIView.animate(
        withDuration: 0.2,
        delay: 0,
        options: .curveEaseIn,
        animations: { [weak self] _ in
          self?.view.layoutIfNeeded()
        }
      )
    } else {
      apparelTextHeightConstraints.constant = 0
      apparelText.alpha = 0
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
  func switchColorValueDidChange(sender: UISwitch) {
    print("switch color tapped")
    if switchColor.isOn == true {
      colorTextHeightConstraints.constant = 50
      colorText.alpha = 1
      UIView.animate(
        withDuration: 0.2,
        delay: 0,
        options: .curveEaseIn,
        animations: { [weak self] _ in
          self?.view.layoutIfNeeded()
        }
      )
    } else {
      colorTextHeightConstraints.constant = 0
      colorText.alpha = 0
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
  
  private func initialize() {
    //occasion filter
    view.addSubview(occasionLabel)
    view.addSubview(occasionText)
    view.addSubview(switchOccasion)
    
    //apparel filter
    view.addSubview(apparelLabel)
    view.addSubview(apparelText)
    view.addSubview(switchApparel)
    
    //color filter
    view.addSubview(colorLabel)
    view.addSubview(colorText)
    view.addSubview(switchColor)
    
    //confirm button
    view.addSubview(confirmButton)
    
    //screen width
    let screenWidth = UIScreen.main.bounds.size.width
    
    //occasion label
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 64))
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth))
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    
    //occasion text field
    view.addConstraint(NSLayoutConstraint(item: occasionText, attribute: .top, relatedBy: .equal, toItem: occasionLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: occasionText, attribute: .left, relatedBy: .equal, toItem: occasionLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: occasionText, attribute: .right, relatedBy: .equal, toItem: occasionLabel, attribute: .right, multiplier: 1.0, constant: 0))
    occasionTextHeightConstraint = NSLayoutConstraint(item: occasionText, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
    view.addConstraint(occasionTextHeightConstraint)
    
    //switch occasion
    view.addConstraint(NSLayoutConstraint(item: switchOccasion, attribute: .top, relatedBy: .equal, toItem: occasionLabel, attribute: .top, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: switchOccasion, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10))
    
    
    //apparel label
    view.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .top, relatedBy: .equal, toItem: occasionText, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .left, relatedBy: .equal, toItem: occasionText, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth))
    view.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    
    //apparel text field
    view.addConstraint(NSLayoutConstraint(item: apparelText, attribute: .top, relatedBy: .equal, toItem: apparelLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: apparelText, attribute: .left, relatedBy: .equal, toItem: apparelLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: apparelText, attribute: .right, relatedBy: .equal, toItem: apparelLabel, attribute: .right, multiplier: 1.0, constant: 0))
    apparelTextHeightConstraints = NSLayoutConstraint(item: apparelText, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
    view.addConstraint(apparelTextHeightConstraints)
    
    //switch apparel
    view.addConstraint(NSLayoutConstraint(item: switchApparel, attribute: .top, relatedBy: .equal, toItem: apparelLabel, attribute: .top, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: switchApparel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10))
    
    //color label
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .top, relatedBy: .equal, toItem: apparelText, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .left, relatedBy: .equal, toItem: apparelText, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    
    //color text field
    view.addConstraint(NSLayoutConstraint(item: colorText, attribute: .top, relatedBy: .equal, toItem: colorLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: colorText, attribute: .left, relatedBy: .equal, toItem: colorLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: colorText, attribute: .right, relatedBy: .equal, toItem: colorLabel, attribute: .right, multiplier: 1.0, constant: 0))
    colorTextHeightConstraints = NSLayoutConstraint(item: colorText, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
    view.addConstraint(colorTextHeightConstraints)
    
    //switch color
    view.addConstraint(NSLayoutConstraint(item: switchColor, attribute: .top, relatedBy: .equal, toItem: colorLabel, attribute: .top, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: switchColor, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10))
    
    view.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .top, relatedBy: .equal, toItem: colorLabel, attribute: .bottom, multiplier: 1.0, constant: 100))
    view.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200))
    view.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    view.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))

    
  }
  
  
}

extension FilterViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
}

















