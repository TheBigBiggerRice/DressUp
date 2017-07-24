//
//  DatabaseReference+Extenstion.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/17/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//
import Foundation
import FirebaseDatabase

extension DatabaseReference {
  enum MGLocation {
    //insert cases to read/write to locations in Firebase
    case root
    
    case photos(uid: String)
    //    case showPost(uid: String, postKey: String)
    //    case newPost(currentID: String)
    
    case users
    case showUser(uid: String)
    //    case timeline(uid: String)
    //
    //    case followers(uid: String)
    //
    //    case likes(postKey: String, currentUID: String)
    //    case isLiked(postKey: String)
    
    
    
    func asDatabaseReference() -> DatabaseReference {
      let root = Database.database().reference()
      
      switch self {
      case .root:
        return root
      case .photos(let uid):
        return root.child("photos").child(uid)
        //      case let .showPost(uid, postKey):
        //        return root.child("posts").child(uid).child(postKey)
        //      case .newPost(let currentUID):
      //        return root.child("posts").child(currentUID).childByAutoId()
      case .users:
        return root.child("users")
      case .showUser(let uid):
        return root.child("users").child(uid)
        //      case .timeline(let uid):
        //        return root.child("timeline").child(uid)
        //      case .followers(let uid):
        //        return root.child("followers").child(uid)
        //      case let .likes(postKey, currentUID):
        //return root.child("postLikes").child(postKey).child(currentUID)
        //case .isLiked(let postKey):
        //return root.child("postLikes/\(postKey)")
      }
    }
  }
  static func toLocation(_ location: MGLocation) -> DatabaseReference {
    return location.asDatabaseReference()
    //let postsRef = DatabaseReference.toLocation(.posts(uid: uid))
  }
}
