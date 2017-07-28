//
//  PhotoService.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/14/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase

struct PhotoService {
  
  static func create(for image: UIImage, imageApparel: [String], imageColor: [String]) {
    DispatchQueue.main.async {
      let imageRef = StorageReference.newPhotoImageReference()
      StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
        guard let downloadURL = downloadURL else {
          return
        }
        
        let urlString = downloadURL.absoluteString
        let aspectHeight = image.aspectHeight
        create(forURLString: urlString, aspectHeight: aspectHeight, imageApparel: imageApparel, imageColor: imageColor)
      }
    }
  }
  
  private static func create(forURLString urlString: String, aspectHeight: CGFloat, imageApparel: [String], imageColor: [String]) {
    
    let currentUser = User.current
    let photoRef = Database.database().reference().child("photos").child(currentUser.uid).childByAutoId()
    let uidValue = photoRef.key
    let photo = Photos(imageURL: urlString, imageHeight: aspectHeight, imageUID: uidValue, imageApparel: imageApparel, imageColor: imageColor)
    let dict = photo.dictValue
    
    photoRef.updateChildValues(dict)
  }
  
  //delete a photo from firebase
  static func delete(deletePhoto: String) {
    let currentUser = User.current
    Database.database().reference().child("photos").child(currentUser.uid).child(deletePhoto).removeValue()
  }
}

