//
//  UIImage+Size.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/16/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    
    var aspectHeight: CGFloat {
        let heightRatio = size.height/736
        let widthRatio = size.width/414
        let aspectRatio = fmax(heightRatio, widthRatio)
        
        return size.height/aspectRatio
    }
    
}
