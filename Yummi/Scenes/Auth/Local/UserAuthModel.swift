//
//  AuthModel.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 17/11/2022.
//

import Foundation

// MARK: - User
struct User: Codable {
    let request: UserRequest
    let response: UserResponse
}

// MARK: - UserRequest
struct UserRequest: Codable {
    let phoneNumber: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phone_number"
        case password = "password"
    }
}

struct UserResponse: Codable {
    let id: Int
    let phoneNumber, password, updatedAt, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case phoneNumber = "phone_number"
        case password, updatedAt, createdAt
    }
}

