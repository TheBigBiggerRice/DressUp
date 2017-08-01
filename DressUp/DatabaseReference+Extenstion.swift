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
  enum DULocation {
    
    case root
    
    case photos(uid: String)

    
    case users
    case showUser(uid: String)

    
    
    func asDatabaseReference() -> DatabaseReference {
      let root = Database.database().reference()
      
      switch self {
      case .root:
        return root
      case .photos(let uid):
        return root.child("photos").child(uid)

      case .users:
        return root.child("users")
      case .showUser(let uid):
        return root.child("users").child(uid)

      }
    }
  }
  static func toLocation(_ location: DULocation) -> DatabaseReference {
    return location.asDatabaseReference()
  }
}
