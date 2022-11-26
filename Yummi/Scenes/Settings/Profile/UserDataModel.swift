//
//  UserDataModel.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 14/11/2022.
//

import UIKit

struct UserModel: Codable {
    let name: String
    let phone: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case phone = "phone"
        case image = "image"
    }
}
