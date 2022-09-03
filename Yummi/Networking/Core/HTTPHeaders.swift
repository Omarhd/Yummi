//
//  HTTPHeaders.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import Foundation

enum HTTPHeader {
    case contentType(String)
    case accept(String)
    case authorization(String)
    case noAuthentication(Bool)
    case lemonClientID(String)
    case lemonClientSecret(String)
    case Authorization(String)

    var header: (field: String, value: Any) {
        switch self {
        case .contentType(let value): return (field: "Content-Type", value: value)
        case .accept(let value): return (field: "Accept", value: value)
        case .authorization(let value): return (field: "Authorization", value: value)
        case .noAuthentication(let value): return (field: "No-Authentication", value: value)
        case .lemonClientID(let value): return (field: "x-lemon-client-id", value: value)
        case .lemonClientSecret(let value): return (field: "x-lemon-client-secret", value: value)
        case .Authorization(let value): return (field: "Authorization", value: value)
        }
    }
}


extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
