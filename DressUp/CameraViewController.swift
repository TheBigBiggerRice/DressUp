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
  var categoryLabels = [UILabel]()
  var colorLabels = [UILabel]()
  
  let cameraRightBorder = CALayer()
  
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
  
  fileprivate let categoriesScrollView: UIScrollView = {
    let view = UIScrollView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  fileprivate let categoriesLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Categories"
    label.lineBreakMode = .byWordWrapping
    return label
  }()
  
  fileprivate let colorScrollView: UIScrollView = {
    let view = UIScrollView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  fileprivate let colorLabel: DULabel = {
    let label = DULabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.text = "Colors"
    label.lineBreakMode = .byWordWrapping
    
    return label
  }()
  fileprivate let occasionTextField: DUTextField = {
    let textField = DUTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Occasion:"
    
    return textField
  }()
  
  fileprivate let positionTextField: DUTextField = {
    let textField = DUTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Position:"
    
    return textField
  }()
  
  fileprivate let saveButton: UIButton = {
    let button = UIButton()
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
  fileprivate let chooseImageButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(#imageLiteral(resourceName: "chooseImageButton"), for: .normal)
    return button
  }()
  
  fileprivate let takePhotoImageButton: UIButton = {
    let button = UIButton()
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
    
    occasionTextField.delegate = self
    positionTextField.delegate = self
    
  }
  
  deinit {
    takePhotoImageButton.removeTarget(self, action: nil, for: .allEvents)
    chooseImageButton.removeTarget(self, action: nil, for: .allEvents)
    saveButton.removeTarget(self, action: nil, for: .allEvents)
  }
  
  private func initialize() {
    
    view.addSubview(backgroundImageView)
    view.insertSubview(blurView, aboveSubview: backgroundImageView)
    view.insertSubview(imageView, aboveSubview: blurView)
    view.insertSubview(chooseImageButton, aboveSubview: imageView)
    view.insertSubview(takePhotoImageButton, aboveSubview: imageView)
    
    view.addSubview(categoriesLabel)
    view.addSubview(categoriesScrollView)
    
    view.addSubview(colorLabel)
    view.addSubview(colorScrollView)
    
    view.addSubview(occasionTextField)
    view.addSubview(positionTextField)
    
    view.addSubview(saveButton)
    
    backgroundImageView.layer.borderColor = UIColor.black.cgColor
    
    takePhotoImageButton.addTarget(self, action: #selector(CameraViewController.takePhotoImageButtonTapped), for: .touchUpInside)
    chooseImageButton.addTarget(self, action: #selector(CameraViewController.chooseImageButtonTapped), for: .touchUpInside)
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
    
    //position text field
    view.addConstraint(NSLayoutConstraint(item: positionTextField, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: positionTextField, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: positionTextField, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
    
    //occasion text field
    view.addConstraint(NSLayoutConstraint(item: occasionTextField, attribute: .top, relatedBy: .equal, toItem: positionTextField, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: occasionTextField, attribute: .left, relatedBy: .equal, toItem: positionTextField, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: occasionTextField, attribute: .right, relatedBy: .equal, toItem: positionTextField, attribute: .right, multiplier: 1.0, constant: 0))
    
    //categories label
    view.addConstraint(NSLayoutConstraint(item: categoriesLabel, attribute: .top, relatedBy: .equal, toItem: occasionTextField, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: categoriesLabel, attribute: .left, relatedBy: .equal, toItem: occasionTextField, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: categoriesLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: categoriesLabel.intrinsicContentSize.width + 10))
    view.addConstraint(NSLayoutConstraint(item: categoriesLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
    
    //categories scroll view
    view.addConstraint(NSLayoutConstraint(item: categoriesScrollView, attribute: .left, relatedBy: .equal, toItem: categoriesLabel, attribute: .right, multiplier: 1.0, constant: 5))
    view.addConstraint(NSLayoutConstraint(item: categoriesScrollView, attribute: .top, relatedBy: .equal, toItem: categoriesLabel, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: categoriesScrollView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10))
    view.addConstraint(NSLayoutConstraint(item: categoriesScrollView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
    view.addConstraint(NSLayoutConstraint(item: categoriesScrollView, attribute: .centerY, relatedBy: .equal, toItem: categoriesLabel, attribute: .centerY, multiplier: 1.0, constant: 0))
    
    //color label
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .top, relatedBy: .equal, toItem: categoriesLabel, attribute: .bottom, multiplier: 1.0, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .left, relatedBy: .equal, toItem: categoriesLabel, attribute: .left, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: colorLabel.intrinsicContentSize.width + 10))
    view.addConstraint(NSLayoutConstraint(item: colorLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
    
    //color scroll view
    view.addConstraint(NSLayoutConstraint(item: colorScrollView, attribute: .left, relatedBy: .equal, toItem: colorLabel, attribute: .right, multiplier: 1.0, constant: 5))
    view.addConstraint(NSLayoutConstraint(item: colorScrollView, attribute: .top, relatedBy: .equal, toItem: colorLabel, attribute: .top, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: colorScrollView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -10))
    view.addConstraint(NSLayoutConstraint(item: colorScrollView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30))
    view.addConstraint(NSLayoutConstraint(item: colorScrollView, attribute: .centerY, relatedBy: .equal, toItem: colorLabel, attribute: .centerY, multiplier: 1.0, constant: 0))
    
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
  
  private dynamic func saveButtonTapped() {
    
    let occasionTags = occasionTextField.text?.components(separatedBy: ",") ?? []
    let positionTags = positionTextField.text ?? ""
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
    saveButtonHeightConstraint.constant = 40
    saveButton.alpha = 1
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
    
    label.layer.backgroundColor = UIColor.lighterPurple.cgColor
    
    return label
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
            
            if modelName == Constants.ModelNames.categoryName {
              self.apparelTags.removeAll()
              
              for concept in caiOutput.concepts {
                self.apparelTags.append(concept.conceptName)
                if self.apparelTags.count == 5 {
                  break
                }
              }
              for label in self.categoryLabels {
                label.removeFromSuperview()
              }
              
              self.categoryLabels.removeAll()
              //loop through the tags and set them as label texts, put the labels in an array
              for apparel in self.apparelTags {
                let label = self.createLabel()
                label.text = apparel
                self.categoryLabels.append(label)
              }
              
              var previousLabel: UILabel?
              
              for label in self.categoryLabels {
                if nil == previousLabel {
                  
                  previousLabel = label
                  
                  self.categoriesScrollView.addSubview(label)
                  
                  self.categoriesScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self.categoriesScrollView, attribute: .top, multiplier: 1.0, constant: 0))
                  self.categoriesScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: self.categoriesScrollView, attribute: .left, multiplier: 1.0, constant: 0))
                  self.categoriesScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: label.intrinsicContentSize.width + 20))
                  self.categoriesScrollView.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25))
                  
                } else {
                  self.categoriesScrollView.addSubview(label)
                  
                  self.view.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: previousLabel, attribute: .top, multiplier: 1.0, constant: 0))
                  self.view.addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: previousLabel, attribute: .right, multiplier: 1.0, constant: 5))
                  self.view.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: label.intrinsicContentSize.width + 20))
                  self.view.addConstraint(NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: previousLabel, attribute: .bottom , multiplier: 1.0, constant: 0))
                  
                  previousLabel = label
                  
                }
              }
              self.categoriesScrollView.addConstraint(NSLayoutConstraint(item: previousLabel!, attribute: .right, relatedBy: .equal, toItem: self.categoriesScrollView, attribute: .right, multiplier: 1.0, constant: 0))
              
            }
            
            if modelName == Constants.ModelNames.colorName {
              self.colorTags.removeAll()
              for concept in caiOutput.colors {
                self.colorTags.append(concept.conceptName)
                if self.colorTags.count == 5 {
                  break
                }
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
                  self.view.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: previousLabel, attribute: .top, multiplier: 1.0, constant: 0))
                  self.view.addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: previousLabel, attribute: .right, multiplier: 1.0, constant: 5))
                  self.view.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: label.intrinsicContentSize.width + 20))
                  self.view.addConstraint(NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: previousLabel, attribute: .bottom , multiplier: 1.0, constant: 0))
                  
                  previousLabel = label
                }
              }
              self.colorScrollView.addConstraint(NSLayoutConstraint(item: previousLabel!, attribute: .right, relatedBy: .equal, toItem: self.colorScrollView, attribute: .right, multiplier: 1.0, constant: 0))

              
            }
          }
          
          self.takePhotoImageButton.isEnabled = true
          self.chooseImageButton.isEnabled = true
          self.saveButton.isEnabled = true
          
          self.chooseImageButton.alpha = 1
          self.takePhotoImageButton.alpha = 1
          
          self.displaySaveButton()
          
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

