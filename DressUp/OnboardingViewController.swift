
  //OnboardingViewController.swift
  //DressUp

  //Created by Chenyang Zhang on 10/26/17.
  //Copyright © 2017 Chenyang Zhang. All rights reserved.


import UIKit
import paper_onboarding
import Firebase
import FirebaseAuthUI

class OnboardingViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
  fileprivate let getStartedButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Get Started", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont(name: "GothamRounded-Bold", size: 20)!
    button.alpha = 0
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    let onboarding = PaperOnboarding(itemsCount: 3)
    onboarding.dataSource = self
    onboarding.delegate = self

    onboarding.translatesAutoresizingMaskIntoConstraints = false


    view.addSubview(onboarding)
    view.addSubview(getStartedButton)

    // add constraints
    for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
      let constraint = NSLayoutConstraint(item: onboarding,
                                          attribute: attribute,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: attribute,
                                          multiplier: 1,
                                          constant: 0)
      view.addConstraint(constraint)
    }

    view.addConstraint(NSLayoutConstraint(item: getStartedButton, attribute: .bottom, relatedBy: .equal, toItem: onboarding, attribute: .bottom, multiplier: 1.0, constant: -100))
    view.addConstraint(NSLayoutConstraint(item: getStartedButton, attribute: .centerX, relatedBy: .equal, toItem: onboarding, attribute: .centerX, multiplier: 1.0, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: getStartedButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300))
    view.addConstraint(NSLayoutConstraint(item: getStartedButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50))

    getStartedButton.addTarget(self, action: #selector(OnboardingViewController.getStartedButtonTapped), for: .touchUpInside)

  }
  deinit {
    getStartedButton.removeTarget(self, action: nil, for: .allEvents)
  }

  func onboardingItemsCount() -> Int {
    return 3
  }
  //configure each onboarding image
  func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
    let emptyImage: UIImage = UIImage()
    let titleFont = UIFont(name: "GothamRounded-Light", size: 24)!
    let descriptionFont = UIFont(name: "GothamRounded-Light", size: 18)!

    return [(#imageLiteral(resourceName: "icons8-clothes"), "Manage your closet", "Filter your clothes based on your own liking - choose an occasion, color, and apparel type and Style Me will generate a dashing outfit", emptyImage, UIColor.onboardingOne, UIColor.white, UIColor.white, titleFont, descriptionFont),
            (#imageLiteral(resourceName: "icons8-camera"), "Identify items", "Take a photo of a piece of clothing, or upload from photo library, and Style Me will automatically give you attributes to choose from for each item", emptyImage, UIColor.onboardingTwo, UIColor.white, UIColor.white, titleFont, descriptionFont),
            (#imageLiteral(resourceName: "icons8-hanger"), "One closet, one app", "Store all your clothing items, along with their attributes to the photo library. You never have to think about what clothes you own before going out again", emptyImage, UIColor.onboardingThree, UIColor.white, UIColor.white, titleFont, descriptionFont)][index]

  }
  func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {

  }

  func onboardingWillTransitonToIndex(_ index: Int) {
    if index == 1 {
      if self.getStartedButton.alpha == 1 {
        UIView.animate(withDuration: 0.4, animations: {
          self.getStartedButton.alpha = 0
        })
      }
    }
  }
  func onboardingDidTransitonToIndex(_ index: Int) {
    if index == 2 {
      UIView.animate(withDuration: 0.4, animations: {
        self.getStartedButton.alpha = 1
      })
    }
  }

  func getStartedButtonTapped() {
    //print(" get started")
    let userDefaults = UserDefaults.standard
    userDefaults.set(true, forKey: "onboardingComplete")
    userDefaults.synchronize()
    
    
    let newViewController = UIStoryboard.initialViewController(for: .login)
    //self.navigationController?.pushViewController(newViewController, animated: true)
    let transition = CATransition()
    transition.duration = 0.3
    transition.type = kCATransitionPush
    transition.subtype = kCATransitionFromRight
    view.window?.layer.add(transition, forKey: kCATransition)
    self.present(newViewController, animated: false, completion: nil)
  }
}













