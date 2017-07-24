//
//  UserService.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/13/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserService {
  static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
    let userAttrs = ["username": username]
    
    let ref = Database.database().reference().child("users").child(firUser.uid)
    ref.setValue(userAttrs) { (error, ref) in
      if let error = error {
        assertionFailure(error.localizedDescription)
        return completion(nil)
      }
      ref.observeSingleEvent(of: .value, with: {(snapshot) in
        let user = User(snapshot: snapshot)
        completion(user)
      })
    }
  }
  static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
    let ref = Database.database().reference().child("users").child(uid)
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
      guard let user = User(snapshot: snapshot) else {
        return completion(nil)
      }
      completion(user)
      
    })
  }
  static func photos(for user: User, completion: @escaping ([Photos]) -> Void) {
    let ref = DatabaseReference.toLocation(.photos(uid: user.uid))
    
    ref.observeSingleEvent(of: .value, with: { (snapshot) in
      guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
        return completion([])
      }
      
      let dispatchGroup = DispatchGroup()
      var photos: [Photos] = []
      
      for snap in snapshot {
        dispatchGroup.enter()
        
        guard let photo = Photos(snapshot: snap) else {return}
        photos.append(photo)
        dispatchGroup.leave()
      }
      
      dispatchGroup.notify(queue: .main, execute: {
        completion(photos)
      })
    })
  }
  
  
  static func observeProfile(for user: User, completion: @escaping (DatabaseReference, User?, [Photos]) -> Void) -> DatabaseHandle {
    let userRef = Database.database().reference().child("users").child(user.uid)
    //let userRef = DatabaseReference.MGLocation.users.child(user.uid)
    return userRef.observe(.value, with: { snapshot in
      
      guard let user = User(snapshot: snapshot) else {
        return completion(userRef, nil, [])
      }
      
      photos(for: user, completion: { photos in
        completion(userRef, user, photos)
      })
    })
  }
}

