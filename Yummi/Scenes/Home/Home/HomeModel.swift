//
//  HomeModel.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 21/09/2022.
//

// MARK: - AllCategories
struct BaseCategoriesResponse: Codable {
    let status: Int
    let message: String
    let data: AllCategories
}

// MARK: - AllCategories
struct AllCategories: Codable {
    let categories: [Category]
    let populars, specials: [Popular]
}

// MARK: - Category
struct Category: Codable {
    let id, title: String
    let image: String
}

// MARK: - Popular
struct Popular: Codable {
    let id, name, popularDescription: String
    let image: String
    let calories: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case popularDescription = "description"
        case image, calories
    }
}
