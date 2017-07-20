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
    
    static func create(for image: UIImage) {
        DispatchQueue.main.async {
            let imageRef = StorageReference.newPostImageReference()
            StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
                guard let downloadURL = downloadURL else {
                    return
                }
                let urlString = downloadURL.absoluteString
                let aspectHeight = image.aspectHeight
                create(forURLString: urlString, aspectHeight: aspectHeight)
            }
        }
    }
  
    private static func create(forURLString urlString: String, aspectHeight: CGFloat) {
        
        let currentUser = User.current
        let post = Photos(imageURL: urlString, imageHeight: aspectHeight)
        let dict = post.dictValue
        let postRef = Database.database().reference().child("photos").child(currentUser.uid).childByAutoId()
        postRef.updateChildValues(dict)
    }
}

