//
//  FilterViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/25/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit


//HomeViewController is the delegate of FilterViewController
protocol FilterViewControllerDelegete: class {
  func passData(passOccasionText: String, passApparelText: String, passColorText: String)
}

final class FilterViewController: UIViewController {
  
  //store the text inputs of the text fields
  var occasionText: String = ""
  var apparelText: String = ""
  var colorText: String = ""
  weak var delegate: FilterViewControllerDelegete?
  

  //choose which filters to enable
  fileprivate let occasionLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Occasion"
    label.textColor = .white
    label.backgroundColor = .blue
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let apparelLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Apparel"
    label.textColor = .white
    label.backgroundColor = .red
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let colorLabel: DULabel = {
    let label = DULabel()
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
  fileprivate let occasionTextField: DUTextField = {
    let textField = DUTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "What is the occasion?"
    textField.alpha = 0
    return textField
  }()
  
  fileprivate let apparelTextField: DUTextField = {
    let textField = DUTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "What is the apparel?"
    textField.alpha = 0
    return textField
  }()
  
  fileprivate let colorTextField: DUTextField = {
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
  
  var occasionTextFieldHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
  var apparelTextFieldHeightConstraints: NSLayoutConstraint = NSLayoutConstraint()
  var colorTextFieldHeightConstraints: NSLayoutConstraint = NSLayoutConstraint()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialize()
    
    self.navigationItem.title = "Filter"
    self.view.backgroundColor = .white
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped(sender:)))
    self.navigationItem.rightBarButtonItem?.tintColor = .white
    
    occasionTextField.delegate = self
    apparelTextField.delegate = self
    colorTextField.delegate = self
  }
  
  //cancel button
  private dynamic func cancelButtonTapped(sender: UIBarButtonItem) {
    print("cancel tapped")
    dismiss(animated: true, completion: nil)
  }
  
  //occasion switch
  private dynamic func switchOccasionValueDidChange(sender: UISwitch) {
    print("switch occasion tapped")
    if switchOccasion.isOn == true {
      occasionTextFieldHeightConstraint.constant = 50
      occasionTextField.alpha = 1
      UIView.animate(
        withDuration: 0.2,
        delay: 0,
        options: .curveEaseIn,
        animations: { [weak self] _ in
          self?.view.layoutIfNeeded()
        }
      )
      
    } else {
      occasionTextFieldHeightConstraint.constant = 0
      occasionTextField.alpha = 0
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
    print("switch apparel tapped")
    if switchApparel.isOn == true {
      apparelTextFieldHeightConstraints.constant = 50
      apparelTextField.alpha = 1
      UIView.animate(
        withDuration: 0.2,
        delay: 0,
        options: .curveEaseIn,
        animations: { [weak self] _ in
          self?.view.layoutIfNeeded()
        }
      )
    } else {
      apparelTextFieldHeightConstraints.constant = 0
      apparelTextField.alpha = 0
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
    print("switch color tapped")
    if switchColor.isOn == true {
      colorTextFieldHeightConstraints.constant = 50
      colorTextField.alpha = 1
      UIView.animate(
        withDuration: 0.2,
        delay: 0,
        options: .curveEaseIn,
        animations: { [weak self] _ in
          self?.view.layoutIfNeeded()
        }
      )
    } else {
      colorTextFieldHeightConstraints.constant = 0
      colorTextField.alpha = 0
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
    
    //occasion filter
    view.addSubview(occasionLabel)
    view.addSubview(occasionTextField)
    view.addSubview(switchOccasion)
    
    //apparel filter
    view.addSubview(apparelLabel)
    view.addSubview(apparelTextField)
    view.addSubview(switchApparel)
    
    //color filter
    view.addSubview(colorLabel)
    view.addSubview(colorTextField)
    view.addSubview(switchColor)
    
    //confirm button
    view.addSubview(confirmButton)
    
    
    confirmButton.addTarget(self, action: #selector(FilterViewController.confirmButtonTapped), for: .touchUpInside)
    
    //screen width
    let screenWidth = UIScreen.main.bounds.size.width
    
    //occasion label
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 64))
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth))
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    
    //occasion text field
    view.addConstraint(NSLayoutConstraint(item: occasionTextField, attribute: .top, relatedBy: .equal, toItem: occasionLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: occasionTextField, attribute: .left, relatedBy: .equal, toItem: occasionLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: occasionTextField, attribute: .right, relatedBy: .equal, toItem: occasionLabel, attribute: .right, multiplier: 1.0, constant: 0))
    occasionTextFieldHeightConstraint = NSLayoutConstraint(item: occasionTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
    view.addConstraint(occasionTextFieldHeightConstraint)
    
    //switch occasion
    view.addConstraint(NSLayoutConstraint(item: switchOccasion, attribute: .top, relatedBy: .equal, toItem: occasionLabel, attribute: .top, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: switchOccasion, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10))
    
    
    //apparel label
    view.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .top, relatedBy: .equal, toItem: occasionTextField, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .left, relatedBy: .equal, toItem: occasionTextField, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth))
    view.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    
    //apparel text field
    view.addConstraint(NSLayoutConstraint(item: apparelTextField, attribute: .top, relatedBy: .equal, toItem: apparelLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: apparelTextField, attribute: .left, relatedBy: .equal, toItem: apparelLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: apparelTextField, attribute: .right, relatedBy: .equal, toItem: apparelLabel, attribute: .right, multiplier: 1.0, constant: 0))
    apparelTextFieldHeightConstraints = NSLayoutConstraint(item: apparelTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
    view.addConstraint(apparelTextFieldHeightConstraints)
    
    //switch apparel
    view.addConstraint(NSLayoutConstraint(item: switchApparel, attribute: .top, relatedBy: .equal, toItem: apparelLabel, attribute: .top, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: switchApparel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10))
    
    //color label
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .top, relatedBy: .equal, toItem: apparelTextField, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .left, relatedBy: .equal, toItem: apparelTextField, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    
    //color text field
    view.addConstraint(NSLayoutConstraint(item: colorTextField, attribute: .top, relatedBy: .equal, toItem: colorLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: colorTextField, attribute: .left, relatedBy: .equal, toItem: colorLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: colorTextField, attribute: .right, relatedBy: .equal, toItem: colorLabel, attribute: .right, multiplier: 1.0, constant: 0))
    colorTextFieldHeightConstraints = NSLayoutConstraint(item: colorTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
    view.addConstraint(colorTextFieldHeightConstraints)
    
    //switch color
    view.addConstraint(NSLayoutConstraint(item: switchColor, attribute: .top, relatedBy: .equal, toItem: colorLabel, attribute: .top, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: switchColor, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10))
    
    view.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .top, relatedBy: .equal, toItem: colorTextField, attribute: .bottom, multiplier: 1.0, constant: 100))
    view.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200))
    view.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    view.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
  }
  
  private dynamic func confirmButtonTapped() {
    occasionText = occasionTextField.text ?? ""
    apparelText = apparelTextField.text ?? ""
    colorText = colorTextField.text ?? ""
    
    delegate?.passData(passOccasionText: occasionText, passApparelText: apparelText, passColorText: colorText)
    
    dismiss(animated: true, completion: nil)
  }
  
}

extension FilterViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
}

















