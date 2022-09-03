//
//  CategoryModel.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import Foundation

struct DishCategory: Codable {
    let id: String
    let name: String
    let image: String
}

struct Dish: Codable {
    let id: String
    let title: String
    let image: String
    let calories: Double?
    let description: String
    
    var formattedCalories: String {
        return String(format: "%.2f", calories ?? 0)
    }
}
