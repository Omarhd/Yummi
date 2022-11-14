//
//  UserDataModel.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 14/11/2022.
//

import UIKit

struct UserModel {
    let name: String
    let phone: String
    let image: UIImage
    
    func setUserData(user: UserModel) -> Bool {
        UserDefaults.standard.set(user, forKey: "User")
        return true
    }
    
    func getUserData(user: UserModel) {
        
    }
}
