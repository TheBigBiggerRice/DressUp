//
//  StorageReference+Post.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/16/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import Foundation
import FirebaseStorage

extension StorageReference {
  
  static let dataFormatter = ISO8601DateFormatter()
  
  static func newPostImageReference() -> StorageReference {
    
    let uid = User.current.uid
    let timestamp = dataFormatter.string(from: Date())
    
    return Storage.storage().reference().child("images/posts/\(uid)/\(timestamp).jpg")
  }
}
