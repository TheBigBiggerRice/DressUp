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
  let imageUID: String
  let imageApparel: [String]
  let imageColor: [String]
  let imageOccasion: [String]
  let imagePosition: String

  var dictValue: [String : Any] {
    let createdAgo = creationDate.timeIntervalSince1970
    let userDict = ["uid" : poster.uid,
                    "username" : poster.username]
    
    return ["image_url" : imageURL,
            "image_height" : imageHeight,
            "created_at" : createdAgo,
            "image_uid" : imageUID,
            "image_apparel": imageApparel,
            "image_color": imageColor,
            "image_occasion": imageOccasion,
            "image_position": imagePosition,
            "poster" : userDict]
  }
  
  init?(snapshot: DataSnapshot) {
    guard let dict = snapshot.value as? [String : Any],
      
      let imageURL = dict["image_url"] as? String,
      let imageHeight = dict["image_height"] as? CGFloat,
      let createdAgo = dict["created_at"] as? TimeInterval,
      let imageUID = dict["image_uid"] as? String,
      let imageApparel = dict["image_apparel"] as? [String],
      let imageColor = dict["image_color"] as? [String],
      let imageOccasion = dict["image_occasion"] as? [String],
      let imagePosition = dict["image_position"] as? String,
    
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
    self.imageUID = imageUID
    self.imageApparel = imageApparel
    self.imageColor = imageColor
    self.imageOccasion = imageOccasion
    self.imagePosition = imagePosition
  }
  
  init(imageURL: String, imageHeight: CGFloat, imageUID: String, imageApparel: [String], imageColor: [String], imageOccasion: [String], imagePosition: String) {
    
    self.imageURL = imageURL
    self.imageHeight = imageHeight
    self.creationDate = Date()
    self.imageUID = imageUID
    self.imageApparel = imageApparel
    self.imageColor = imageColor
    self.imageOccasion = imageOccasion
    self.imagePosition = imagePosition
  
    self.poster = User.current
  }
  
}
