//
//  Photos.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/15/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import UIKit
import FirebaseDatabase.FIRDataSnapshot

protocol DUKeyed{
  var key: String? { get set }
}

class Photos: DUKeyed {
  //properties and initializers
  var key: String?
  let imageURL: String
  let imageHeight: CGFloat
  let poster: User
  let creationDate: Date
  
  
  
  var dictValue: [String : Any] {
    let createdAgo = creationDate.timeIntervalSince1970
    let userDict = ["uid" : poster.uid,
                    "username" : poster.username]
    
    return ["image_url" : imageURL,
            "image_height" : imageHeight,
            "created_at" : createdAgo,
            "poster" : userDict]    }
  
  
  
  init?(snapshot: DataSnapshot) {
    guard let dict = snapshot.value as? [String : Any],
      
      
      let imageURL = dict["image_url"] as? String,
      let imageHeight = dict["image_height"] as? CGFloat,
      let createdAgo = dict["created_at"] as? TimeInterval,
      
      let userDict = dict["poster"] as? [String : Any],
      let uid = userDict["uid"] as? String,
      let username = userDict["username"] as? String else {
        return nil
    }
    
    self.poster = User(uid: uid, username: username)
    self.key = snapshot.key
    self.imageURL = imageURL
    self.imageHeight = imageHeight
    self.creationDate = Date(timeIntervalSince1970: createdAgo)
  }
  init(imageURL: String, imageHeight: CGFloat) {
    self.imageURL = imageURL
    self.imageHeight = imageHeight
    self.creationDate = Date()
    
    self.poster = User.current
  }
}
