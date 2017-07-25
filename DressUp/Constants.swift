//
//  Constants.swift
//  DressUp
//
//  Created by Chenyang Zhang on 7/13/17.
//  Copyright © 2017 Chenyang Zhang. All rights reserved.
//

import Foundation

struct Constants{
    struct Segue {
        static let toCreateUsername = "toCreateUsername"
    }
    struct UserDefaults {
        static let currentUser = "currentUser"
        static let uid = "uid"
        static let username = "username"
    }
    struct ModelIDs {
        static let categoryID = "e0be3b9d6a454f0493ac3a30784001ff"
        static let colorID = "eeed0b6733a644cea07cf4c60f87ebb7"
    }
    struct ModelNames {
        static let categoryName = "Categories:\n%@"
        static let colorName = "Colors:\n%@"
    }
}
