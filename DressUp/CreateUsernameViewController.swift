//
//  CreateUsernameViewController.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/13/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//
import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
  @IBOutlet weak var usernameTextField: UITextField!
  
  @IBOutlet weak var confirmButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    usernameTextField.delegate = self

  }
  
  @IBAction func confirmButtonTapped(_ sender: UIButton) {
    
    guard let firUser = Auth.auth().currentUser,
      let username = usernameTextField.text,
      !username.isEmpty else {return}
    
    UserService.create(firUser, username: username) {
      (user) in
      guard let user = user else {return}
      User.setCurrent(user, writeToUserDefaults: true)
      
      let initialViewController = UIStoryboard.initialViewController(for: .main)
      self.view.window?.rootViewController = initialViewController
      self.view.window?.makeKeyAndVisible()
    }
  }
}

extension CreateUsernameViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
