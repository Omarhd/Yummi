//
//  Model.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 23/09/2022.
//

import Foundation

struct Products: Codable {
    let id: Int
    let name: String
    let price: Double
    let description: String
}
