//
//  TagsPageViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/14/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//
import UIKit
import Clarifai

final class CameraViewController: DUViewController {
  
  var apparelTags = [String]()
  var colorTags = [String]()
  var allApparelLabels = [UILabel]()
  var colorLabels = [UILabel]()
  
  var occasionButtonIsSelected = false
  
  //for category labels
  var categoryButtonIndex = 0
  
  let occasionButtonText = ["Romantic", "Casual", "Night Out", "Sports", "School", "Work", "Business", "Formal"]
  
  let occasionButtonIndex = [0,1,2,3,4,5,6,7]
  
  var occasionButtons = [UIButton]()
  
  var occasionTags = [String]()
  
  fileprivate let blurView: UIVisualEffectView = {
    let view = UIVisualEffectView()
    view.translatesAutoresizingMaskIntoConstraints = false
    let effect = UIBlurEffect(style: UIBlurEffectStyle.light)
    view.effect = effect
    return view
  }()
  
  fileprivate let imageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFit
    return view
  }()
  
  fileprivate let backgroundImageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    return view
  }()
  
  //category label
  fileprivate let categoryLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Category"
    return label
  }()
  
  //don't need scroll view for this, there is enough space, probably, I think
  
  //top, pants, footwear buttons
  fileprivate let topButton: DUButton = {
    let button = DUButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitleColor(.white, for: .normal)
    button.setTitle("Top", for: .normal)
    button.layer.cornerRadius = 12.5
    button.layer.backgroundColor = UIColor.lighterBlack.cgColor
    return button
  }()
  
  fileprivate let pantsButton: DUButton = {
    let button = DUButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitleColor(.white, for: .normal)
    button.setTitle("Pants", for: .normal)
    button.layer.cornerRadius = 12.5
    button.layer.backgroundColor = UIColor.lighterBlack.cgColor
    return button
  }()
  
  fileprivate let footwearButton: DUButton = {
    let button = DUButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitleColor(.white, for: .normal)
    button.setTitle("Footwear", for: .normal)
    button.layer.cornerRadius = 12.5
    button.layer.backgroundColor = UIColor.lighterBlack.cgColor
    return button
  }()
  
  fileprivate let occasionScrollView: UIScrollView = {
    let view = UIScrollView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.showsHorizontalScrollIndicator = false
    return view
  }()

  //occasion label and tags
  fileprivate let occasionLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Occasion"
    return label
  }()
  
  fileprivate let apparelScrollView: UIScrollView = {
    let view = UIScrollView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.showsHorizontalScrollIndicator = false

    return view
  }()
  
  fileprivate let apparelLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Apparel"
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let colorScrollView: UIScrollView = {
    let view = UIScrollView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.showsHorizontalScrollIndicator = false

    return view
  }()
  
  fileprivate let colorLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Color"
    label.lineBreakMode = .byWordWrapping
    
    return label
  }()
  
  fileprivate let saveButton: DUButton = {
    let button = DUButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    
    button.setTitle("Save", for: .normal)
    button.setTitleColor(.black, for: .normal)
    
    button.layer.cornerRadius = 25
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.black.cgColor
    
    button.alpha = 0
    
    return button
  }()
  
  //choose image button on top of the photo
  fileprivate let chooseImageButton: DUButton = {
    let button = DUButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(#imageLiteral(resourceName: "chooseImageButton"), for: .normal)
    return button
  }()
  
  fileprivate let takePhotoImageButton: DUButton = {
    let button = DUButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(#imageLiteral(resourceName: "takePhotoImageButton"), for: .normal)
    return button
  }()
  
  var saveButtonHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
  var app: ClarifaiApp?
  let picker = UIImagePickerController()
  var pendingImage: UIImage?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    app = ClarifaiApp(apiKey: "eeace7a446b74adda719b9b8cd62b7a1")
    initialize()
    self.navigationItem.title = "Camera"
    //self.navigationController?.navigationBar.tintColor = .white
    //self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "GothamRounded-Bold", size: 17)!]
  
    for family: String in UIFont.familyNames
    {
      print("\(family)")
      for names: String in UIFont.fontNames(forFamilyName: family)
      {
        print("== \(names)")
      }
    }
    
  }
  
  deinit {
    takePhotoImageButton.removeTarget(self, action: nil, for: .allEvents)
    chooseImageButton.removeTarget(self, action: nil, for: .allEvents)
    
    topButton.removeTarget(self, action: nil, for: .allEvents)
    pantsButton.removeTarget(self, action: nil, for: .allEvents)
    footwearButton.removeTarget(self, action: nil, for: .allEvents)
    
    saveButton.removeTarget(self, action: nil, for: .allEvents)
  }
  
  private func initialize() {
    
    
    view.addSubview(backgroundImageView)
    view.insertSubview(blurView, aboveSubview: backgroundImageView)
    view.insertSubview(imageView, aboveSubview: blurView)
    view.insertSubview(chooseImageButton, aboveSubview: imageView)
    view.insertSubview(takePhotoImageButton, aboveSubview: imageView)
    
    //for categories
    view.addSubview(categoryLabel)
    view.addSubview(topButton)
    view.addSubview(pantsButton)
    view.addSubview(footwearButton)
    
    //for occasions
    view.addSubview(occasionLabel)
    view.addSubview(occasionScrollView)
    
    //for apparel(auto generated)
    view.addSubview(apparelLabel)
    view.addSubview(apparelScrollView)
    
    //for color(auto generated)
    view.addSubview(colorLabel)
    view.addSubview(colorScrollView)
    
    //view.addSubview(occasionTextField)
    //view.addSubview(positionTextField)
    
    view.addSubview(saveButton)
    
    backgroundImageView.layer.borderColor = UIColor.black.cgColor
    
    takePhotoImageButton.addTarget(self, action: #selector(CameraViewController.takePhotoImageButtonTapped), for: .touchUpInside)
    chooseImageButton.addTarget(self, action: #selector(CameraViewController.chooseImageButtonTapped), for: .touchUpInside)
    
    topButton.addTarget(self, action: #selector(CameraViewController.topButtonTapped), for: .touchUpInside)
    pantsButton.addTarget(self, action: #selector(CameraViewController.pantsButtonTapped), for: .touchUpInside)
    footwearButton.addTarget(self, action: #selector(CameraViewController.footwearButtonTapped), for: .touchUpInside)
    
    saveButton.addTarget(self, action: #selector(CameraViewController.saveButtonTapped), for: .touchUpInside)
    
    
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    //background imageview
    view.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .height, relatedBy: .equal, toItem: backgroundImageView, attribute: .width, multiplier: 1.0, constant: 0))
    
    //blur view
    view.addConstraint(NSLayoutConstraint(item: blurView, attribute: .top, relatedBy: .equal, toItem: backgroundImageView, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: blurView, attribute: .left, relatedBy: .equal, toItem: backgroundImageView, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: blurView, attribute: .right, relatedBy: .equal, toItem: backgroundImageView, attribute: .right, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: blurView, attribute: .bottom, relatedBy: .equal, toItem: backgroundImageView, attribute: .bottom, multiplier: 1.0, constant: 0))
    
    //imageview
    view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: backgroundImageView, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: backgroundImageView, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: backgroundImageView, attribute: .right, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: backgroundImageView, attribute: .bottom, multiplier: 1.0, constant: 0))
    
    //take photo image button on top of image
    view.addConstraint(NSLayoutConstraint(item: takePhotoImageButton, attribute: .top, relatedBy: .equal, toItem: backgroundImageView, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: takePhotoImageButton, attribute: .left, relatedBy: .equal, toItem: backgroundImageView, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: takePhotoImageButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth/2))
    view.addConstraint(NSLayoutConstraint(item: takePhotoImageButton, attribute: .bottom, relatedBy: .equal, toItem: backgroundImageView, attribute: .bottom, multiplier: 1.0, constant: 0))
    
    //choose image button on top of image
    view.addConstraint(NSLayoutConstraint(item: chooseImageButton, attribute: .top, relatedBy: .equal, toItem: backgroundImageView, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: chooseImageButton, attribute: .left, relatedBy: .equal, toItem: takePhotoImageButton, attribute: .right, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: chooseImageButton, attribute: .right, relatedBy: .equal, toItem: backgroundImageView, attribute: .right, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: chooseImageButton, attribute: .bottom, relatedBy: .equal, toItem: backgroundImageView, attribute: .bottom, multiplier: 1.0, constant: 0))
    
    
    //category label
    view.addConstraint(NSLayoutConstraint(item: categoryLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: categoryLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: categoryLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: categoryLabel.intrinsicContentSize.width + 20))
    view.addConstraint(NSLayoutConstraint(item: categoryLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
    
    //top button
    view.addConstraint(NSLayoutConstraint(item: topButton, attribute: .top, relatedBy: .equal, toItem: categoryLabel, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: topButton, attribute: .left, relatedBy: .equal, toItem: categoryLabel, attribute: .right, multiplier: 1.0, constant: 5))
    view.addConstraint(NSLayoutConstraint(item: topButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: topButton.intrinsicContentSize.width + 20))
    view.addConstraint(NSLayoutConstraint(item: topButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
    
    //pants button
    view.addConstraint(NSLayoutConstraint(item: pantsButton, attribute: .top, relatedBy: .equal, toItem: topButton, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: pantsButton, attribute: .left, relatedBy: .equal, toItem: topButton, attribute: .right, multiplier: 1.0, constant: 5))
    view.addConstraint(NSLayoutConstraint(item: pantsButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: pantsButton.intrinsicContentSize.width + 20))
    view.addConstraint(NSLayoutConstraint(item: pantsButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
    
    //footwear button
    view.addConstraint(NSLayoutConstraint(item: footwearButton, attribute: .top, relatedBy: .equal, toItem: pantsButton, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: footwearButton, attribute: .left, relatedBy: .equal, toItem: pantsButton, attribute: .right, multiplier: 1.0, constant: 5))
    view.addConstraint(NSLayoutConstraint(item: footwearButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: footwearButton.intrinsicContentSize.width + 20))
    view.addConstraint(NSLayoutConstraint(item: footwearButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
    
    //occasion label
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .top, relatedBy: .equal, toItem: categoryLabel, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .left, relatedBy: .equal, toItem: categoryLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: categoryLabel.intrinsicContentSize.width + 20))
    view.addConstraint(NSLayoutConstraint(item: occasionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
    
    //occasion scroll view
    view.addConstraint(NSLayoutConstraint(item: occasionScrollView, attribute: .left, relatedBy: .equal, toItem: occasionLabel, attribute: .right, multiplier: 1.0, constant: 5))
    view.addConstraint(NSLayoutConstraint(item: occasionScrollView, attribute: .top, relatedBy: .equal, toItem: occasionLabel, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: occasionScrollView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10))
    view.addConstraint(NSLayoutConstraint(item: occasionScrollView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
    
    //set the constraints for the buttons
    
    for button in occasionButtons {
      button.removeFromSuperview()
    }
    occasionButtons.removeAll()
    
    for occasion in occasionButtonText {
      let button = createOccasionbutton()
      button.setTitle(occasion, for: .normal)
      occasionButtons.append(button)
    }
    
    var previousOccasionButton: UIButton?
    
    for (index, button) in occasionButtons.enumerated() {
      
      button.tag = index
      button.addTarget(self, action: #selector(CameraViewController.occasionButtonTapped(sender:)), for: .touchUpInside)
      
      if nil == previousOccasionButton {
        
        previousOccasionButton = button
        
        occasionScrollView.addSubview(button)
        
        occasionScrollView.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: occasionScrollView, attribute: .top, multiplier: 1.0, constant: 0))
        occasionScrollView.addConstraint(NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: occasionScrollView, attribute: .left, multiplier: 1.0, constant: 0))
        occasionScrollView.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: button.intrinsicContentSize.width + 20))
        occasionScrollView.addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
      } else {
        occasionScrollView.addSubview(button)
        
        occasionScrollView.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: previousOccasionButton, attribute: .top, multiplier: 1.0, constant: 0))
        occasionScrollView.addConstraint(NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: previousOccasionButton, attribute: .right, multiplier: 1.0, constant: 5))
        occasionScrollView.addConstraint(NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: button.intrinsicContentSize.width + 20))
        occasionScrollView.addConstraint(NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: previousOccasionButton, attribute: .bottom , multiplier: 1.0, constant: 0))
        
        previousOccasionButton = button
        
      }
    }
    occasionScrollView.addConstraint(NSLayoutConstraint(item: previousOccasionButton!, attribute: .right, relatedBy: .equal, toItem: occasionScrollView, attribute: .right, multiplier: 1.0, constant: 0))
    
    //previousOccasionButton = nil
    
    //apparel label
    view.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .top, relatedBy: .equal, toItem: occasionLabel, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .left, relatedBy: .equal, toItem: occasionLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: categoryLabel.intrinsicContentSize.width + 20))
    view.addConstraint(NSLayoutConstraint(item: apparelLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
    
    //apparel scroll view
    view.addConstraint(NSLayoutConstraint(item: apparelScrollView, attribute: .left, relatedBy: .equal, toItem: apparelLabel, attribute: .right, multiplier: 1.0, constant: 5))
    view.addConstraint(NSLayoutConstraint(item: apparelScrollView, attribute: .top, relatedBy: .equal, toItem: apparelLabel, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: apparelScrollView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10))
    view.addConstraint(NSLayoutConstraint(item: apparelScrollView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
    //view.addConstraint(NSLayoutConstraint(item: apparelScrollView, attribute: .centerY, relatedBy: .equal, toItem: apparelLabel, attribute: .centerY, multiplier: 1.0, constant: 0))
    
    //color label
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .top, relatedBy: .equal, toItem: apparelLabel, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .left, relatedBy: .equal, toItem: apparelLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: categoryLabel.intrinsicContentSize.width + 20))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
    
    //color scroll view
    view.addConstraint(NSLayoutConstraint(item: colorScrollView, attribute: .left, relatedBy: .equal, toItem: colorLabel, attribute: .right, multiplier: 1.0, constant: 5))
    view.addConstraint(NSLayoutConstraint(item: colorScrollView, attribute: .top, relatedBy: .equal, toItem: colorLabel, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: colorScrollView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10))
    view.addConstraint(NSLayoutConstraint(item: colorScrollView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
    //view.addConstraint(NSLayoutConstraint(item: colorScrollView, attribute: .centerY, relatedBy: .equal, toItem: colorLabel, attribute: .centerY, multiplier: 1.0, constant: 0))
    
    //save button
    view.addConstraint(NSLayoutConstraint(item: saveButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: saveButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: saveButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -50))
    saveButtonHeightConstraint = NSLayoutConstraint(item: saveButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
    view.addConstraint(saveButtonHeightConstraint)
  }
  
  private dynamic func takePhotoImageButtonTapped() {
    picker.allowsEditing = false
    picker.sourceType = UIImagePickerControllerSourceType.camera
    picker.delegate = self
    present(picker, animated: true, completion: nil)
  }
  
  private dynamic func chooseImageButtonTapped() {
    picker.allowsEditing = false
    picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
    picker.delegate = self
    present(picker, animated: true, completion: nil)
  }
  
  private dynamic func topButtonTapped() {
    categoryButtonIndex = 0
    topButton.layer.backgroundColor = UIColor.onyxBlack.cgColor
    pantsButton.layer.backgroundColor = UIColor.lighterBlack.cgColor
    footwearButton.layer.backgroundColor = UIColor.lighterBlack.cgColor
    
  }
  
  private dynamic func pantsButtonTapped() {
    categoryButtonIndex = 1
    pantsButton.layer.backgroundColor = UIColor.onyxBlack.cgColor
    topButton.layer.backgroundColor = UIColor.lighterBlack.cgColor
    footwearButton.layer.backgroundColor = UIColor.lighterBlack.cgColor
  }
  
  private dynamic func footwearButtonTapped() {
    categoryButtonIndex = 2
    footwearButton.layer.backgroundColor = UIColor.onyxBlack.cgColor
    topButton.layer.backgroundColor = UIColor.lighterBlack.cgColor
    pantsButton.layer.backgroundColor = UIColor.lighterBlack.cgColor
  }
  private dynamic func occasionButtonTapped(sender: UIButton) {
    for index in occasionButtonIndex {
      if sender.isSelected {
        if sender.tag == index {
          sender.layer.backgroundColor = UIColor.lighterBlack.cgColor
          occasionTags = occasionTags.filter{$0 != sender.titleLabel?.text }
          sender.isSelected = false
        }
      } else {
        if sender.tag == index {
          sender.layer.backgroundColor = UIColor.onyxBlack.cgColor
          occasionTags.append((sender.titleLabel?.text)!)
          sender.isSelected = true
        }
      }
    }
  }
  private dynamic func saveButtonTapped() {
  
    var positionTags = ""
    if categoryButtonIndex == 0 {
      positionTags = "Top"
      
    }
    else if categoryButtonIndex == 1 {
      positionTags = "Pants"
      
    }
    else if categoryButtonIndex == 2 {
      positionTags = "Footwear"
      
    }
    ///let positionTags = positionTextField.text ?? ""
    takePhotoImageButton.setImage(#imageLiteral(resourceName: "takePhotoImageButton"), for: .normal)
    chooseImageButton.setImage(#imageLiteral(resourceName: "chooseImageButton"), for: .normal)
    imageView.image = nil
    backgroundImageView.image = nil
    if let image = pendingImage {
      PhotoService.create(for: image, imageApparel: apparelTags, imageColor: colorTags, imageOccasion: occasionTags, imagePosition: positionTags)
      saveButtonHeightConstraint.constant = 0
      UIView.animate(
        withDuration: 0.4,
        delay: 0,
        options: .curveEaseIn,
        animations: { [weak self] _ in
          self?.saveButton.alpha = 0
          self?.view.layoutIfNeeded()
        }
      )
    }
    
  }
  
  fileprivate func displaySaveButton() {
    //saveButtonHeightConstraint.constant = 40
    //saveButton.alpha = 1
    UIView.animate(
      withDuration: 0.4,
      delay: 0,
      options: .curveEaseIn,
      animations: { [weak self] _ in
        self?.saveButton.alpha = 1
        self?.saveButtonHeightConstraint.constant = 40
        self?.view.layoutIfNeeded()
      }
    )
    takePhotoImageButton.setImage(nil, for: .normal)
    chooseImageButton.setImage(nil, for: .normal)
    
  }
  
  //generate uilabels for categories and colors
  func createLabel() -> DULabel {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    
    label.layer.cornerRadius = 12.5
    label.textColor = .white
    
    label.layer.backgroundColor = UIColor.onyxBlack.cgColor
    
    return label
  }
  
  func createOccasionbutton() -> DUButton {
    
    let button = DUButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 12.5
    button.layer.backgroundColor = UIColor.lighterBlack.cgColor
    return button
    
  }
  
}



extension CameraViewController: UIImagePickerControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    dismiss(animated: true, completion: nil)
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      
      imageView.image = image
      backgroundImageView.image = image
      
      recognizeImage(image: image, modelID: Constants.ModelIDs.categoryID, modelName: Constants.ModelNames.categoryName)
      recognizeImage(image: image, modelID: Constants.ModelIDs.colorID, modelName: Constants.ModelNames.colorName)
      
      takePhotoImageButton.isEnabled = false
      chooseImageButton.isEnabled = false
      saveButton.isEnabled = false
      
      pendingImage = image
      
      chooseImageButton.alpha = 0
      takePhotoImageButton.alpha = 0
      
    }
  }
  
  func recognizeImage(image: UIImage, modelID: String, modelName: String) {
    
    if app != nil {
      app?.getModelByID(modelID, completion: { (model, error) in
        let caiImage = ClarifaiImage(image: image)!
        model?.predict(on: [caiImage], completion: { (outputs, error) in
          guard let caiOutputs = outputs
            else { return }
          if let caiOutput = caiOutputs.first {
            DispatchQueue.main.async {
              
              if modelName == Constants.ModelNames.categoryName {
                self.apparelTags.removeAll()
                
                for concept in caiOutput.concepts {
                  self.apparelTags.append(concept.conceptName)
                }
                
                for label in self.allApparelLabels {
                  
                  label.removeFromSuperview()
                }
                
                self.allApparelLabels.removeAll()
                
                for apparel in self.apparelTags {
                  let label = self.createLabel()
                  label.text = apparel
                  self.allApparelLabels.append(label)
                }
                
                var previousLabel: UILabel?
                
                for label in self.allApparelLabels {
                  if nil == previousLabel {
                    
                    previousLabel = label
                    
                    self.apparelScrollView.addSubview(label)
                    
                    self.apparelScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self.apparelScrollView, attribute: .top, multiplier: 1.0, constant: 0))
                    self.apparelScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: self.apparelScrollView, attribute: .left, multiplier: 1.0, constant: 0))
                    self.apparelScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: label.intrinsicContentSize.width + 20))
                    self.apparelScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
                    
                  } else {
                    self.apparelScrollView.addSubview(label)
                    
                    self.apparelScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: previousLabel, attribute: .top, multiplier: 1.0, constant: 0))
                    self.apparelScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: previousLabel, attribute: .right, multiplier: 1.0, constant: 5))
                    self.apparelScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: label.intrinsicContentSize.width + 20))
                    self.apparelScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: previousLabel, attribute: .bottom , multiplier: 1.0, constant: 0))
                    
                    previousLabel = label
                  }
                }
                self.apparelScrollView.addConstraint(NSLayoutConstraint(item: previousLabel!, attribute: .right, relatedBy: .equal, toItem: self.apparelScrollView, attribute: .right, multiplier: 1.0, constant: 0))
                
              }
              
              if modelName == Constants.ModelNames.colorName {
                self.colorTags.removeAll()
                for concept in caiOutput.colors {
                  self.colorTags.append(concept.conceptName)
                }
                for label in self.colorLabels {
                  label.removeFromSuperview()
                }
                
                self.colorLabels.removeAll()
                
                for color in self.colorTags {
                  let label = self.createLabel()
                  label.text = color
                  self.colorLabels.append(label)
                }
                var previousLabel: UILabel?
                
                for label in self.colorLabels {
                  if nil == previousLabel {
                    previousLabel = label
                    self.colorScrollView.addSubview(label)
                    self.colorScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self.colorScrollView, attribute: .top, multiplier: 1.0, constant: 0))
                    self.colorScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: self.colorScrollView, attribute: .left, multiplier: 1.0, constant: 0))
                    self.colorScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: label.intrinsicContentSize.width + 20))
                    self.colorScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
                  } else {
                    self.colorScrollView.addSubview(label)
                    self.colorScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: previousLabel, attribute: .top, multiplier: 1.0, constant: 0))
                    self.colorScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: previousLabel, attribute: .right, multiplier: 1.0, constant: 5))
                    self.colorScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: label.intrinsicContentSize.width + 20))
                    self.colorScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: previousLabel, attribute: .bottom , multiplier: 1.0, constant: 0))
                    
                    previousLabel = label
                  }
                }
                self.colorScrollView.addConstraint(NSLayoutConstraint(item: previousLabel!, attribute: .right, relatedBy: .equal, toItem: self.colorScrollView, attribute: .right, multiplier: 1.0, constant: 0))
                
                
              }
            }
          }
          DispatchQueue.main.async {
            
            self.takePhotoImageButton.isEnabled = true
            self.chooseImageButton.isEnabled = true
            self.saveButton.isEnabled = true
            
            self.chooseImageButton.alpha = 1
            self.takePhotoImageButton.alpha = 1
            
            self.displaySaveButton()
          }
        })
      })
    }
  }
}

extension CameraViewController: UINavigationControllerDelegate {
  
}

extension CameraViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

