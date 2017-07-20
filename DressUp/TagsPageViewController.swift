//
//  TagsPageViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/14/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//
import UIKit
import Clarifai

final class TagsPageViewController: UIViewController  {
  
  fileprivate let imageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFit
    return view
  }()
  
  fileprivate let categoriesLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Categories: "
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let colorLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Colors: "
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let brandLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Brands: "
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let saveButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .blue
    button.titleLabel?.textColor = .black
    button.setTitle("Save", for: .normal)
    return button
  }()
  
  fileprivate let takePhotoButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Take Photo", for: .normal)
    button.titleLabel?.textColor = .black
    button.backgroundColor = .brown
    return button
  }()
  
  fileprivate let chooseButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Choose From Library", for: .normal)
    button.backgroundColor = .orange
    return button
  }()

  var saveButtonHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
  
  var app:ClarifaiApp?
  let picker = UIImagePickerController()
  
  var pendingImage: UIImage?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    app = ClarifaiApp(apiKey: "eeace7a446b74adda719b9b8cd62b7a1")
    initialize()

    let tagsPageTabBar = UITabBarItem(title: "Camera", image: #imageLiteral(resourceName: "camera"), selectedImage: nil)
    tabBarItem = tagsPageTabBar
    
    self.navigationItem.title = "Camera"
    

  }
  
  deinit {
    takePhotoButton.removeTarget(self, action: nil, for: .allEvents)
    chooseButton.removeTarget(self, action: nil, for: .allEvents)
    saveButton.removeTarget(self, action: nil, for: .allEvents)
  }
  
  private func initialize() {
    view.addSubview(imageView)
    view.addSubview(categoriesLabel)
    view.addSubview(colorLabel)
    view.addSubview(brandLabel)
    view.addSubview(saveButton)
    view.addSubview(takePhotoButton)
    view.addSubview(chooseButton)
    
    takePhotoButton.addTarget(self, action: #selector(TagsPageViewController.takePhotoButtonTapped), for: .touchUpInside)
    chooseButton.addTarget(self, action: #selector(TagsPageViewController.chooseButtonTapped), for: .touchUpInside)
    saveButton.addTarget(self, action: #selector(TagsPageViewController.saveButtonTapped), for: .touchUpInside)
  
    let screenWidth = UIScreen.main.bounds.size.width
    
    // imageview
    view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1.0, constant: 0))
    
    // categories label
    view.addConstraint(NSLayoutConstraint(item: categoriesLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: categoriesLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 10))

    // color label
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .top, relatedBy: .equal, toItem: categoriesLabel, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .left, relatedBy: .equal, toItem: categoriesLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .right, relatedBy: .equal, toItem: categoriesLabel, attribute: .right, multiplier: 1.0, constant: 0))
    
    //brand label
    view.addConstraint(NSLayoutConstraint(item: brandLabel, attribute: .top, relatedBy: .equal, toItem: colorLabel, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: brandLabel, attribute: .left, relatedBy: .equal, toItem: colorLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: brandLabel, attribute: .right, relatedBy: .equal, toItem: colorLabel, attribute: .right, multiplier: 1.0, constant: 0))
    
    // save button
    view.addConstraint(NSLayoutConstraint(item: saveButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: saveButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: saveButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -45))
    saveButtonHeightConstraint = NSLayoutConstraint(item: saveButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0)
    view.addConstraint(saveButtonHeightConstraint)
    
    // take photo
    view.addConstraint(NSLayoutConstraint(item: takePhotoButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: takePhotoButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth / 2))
    view.addConstraint(NSLayoutConstraint(item: takePhotoButton, attribute: .bottom, relatedBy: .equal, toItem: saveButton, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: takePhotoButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
    
    // choose photo
    view.addConstraint(NSLayoutConstraint(item: chooseButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth / 2))
    view.addConstraint(NSLayoutConstraint(item: chooseButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: chooseButton, attribute: .bottom, relatedBy: .equal, toItem: saveButton, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: chooseButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))
  }
  
  private dynamic func takePhotoButtonTapped() {
    picker.allowsEditing = false
    picker.sourceType = UIImagePickerControllerSourceType.camera
    picker.delegate = self
    present(picker, animated: true, completion: nil)
  }
  
  private dynamic func chooseButtonTapped() {
    picker.allowsEditing = false
    picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
    picker.delegate = self
    present(picker, animated: true, completion: nil)
  }
  
  private dynamic func saveButtonTapped() {
    if let image = pendingImage {
      PhotoService.create(for: image)
      saveButtonHeightConstraint.constant = 0
      UIView.animate(
        withDuration: 0.5,
        delay: 0,
        options: .curveEaseIn,
        animations: { [weak self] _ in
          self?.view.layoutIfNeeded()
        }
      )
    }
  }
  
  fileprivate func displaySaveButton() {
    saveButtonHeightConstraint.constant = 50
  }
}

extension TagsPageViewController: UIImagePickerControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    dismiss(animated: true, completion: nil)
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      imageView.image = image
      recognizeImage(image: image, modelID: Constants.ModelIDs.categoryID, modelName: Constants.ModelNames.categoryName)
      recognizeImage(image: image, modelID: Constants.ModelIDs.colorID, modelName: Constants.ModelNames.colorName)
      recognizeImage(image: image, modelID: Constants.ModelIDs.brandID, modelName: Constants.ModelNames.brandName)

      takePhotoButton.isEnabled = false
      chooseButton.isEnabled = false
      pendingImage = image
      displaySaveButton()
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
            let tags = NSMutableArray()
            if modelName == Constants.ModelNames.categoryName {
              for concept in caiOutput.concepts {
                tags.add(concept.conceptName)
                if tags.count == 4 {
                  break
                }
              }
            }
            if modelName == Constants.ModelNames.colorName {
              for concept in caiOutput.colors {
                tags.add(concept.conceptName)
              }
            }
            if modelName == Constants.ModelNames.brandName {
              for concept in caiOutput.concepts {
                tags.add(concept.conceptName)
              }
            }
            DispatchQueue.main.async {
              if modelName == Constants.ModelNames.categoryName {
                self.categoriesLabel.text = String(format: modelName, tags.componentsJoined(by: ", "))
              }
              if modelName == Constants.ModelNames.colorName {
                self.colorLabel.text = String(format: modelName, tags.componentsJoined(by: ", "))
              }
              if modelName == Constants.ModelNames.brandName {
                self.brandLabel.text = String(format: modelName, tags.componentsJoined(by: ", "))
              }
            }
          }
          DispatchQueue.main.async {
            self.takePhotoButton.isEnabled = true
            self.chooseButton.isEnabled = true
          }
        })
      })
    }
  }
}

extension TagsPageViewController: UINavigationControllerDelegate {
  
}
