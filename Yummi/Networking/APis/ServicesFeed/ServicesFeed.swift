//
//  ServicesFeed.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 21/09/2022.
//

import Foundation

enum APIServicesFeed {
    case allCategories
}

extension APIServicesFeed: Endpoint {
    var base: String {
        return BuildSettingsKey.BaseURL.value
    }
    
    var path: String {
        switch self {
        case .allCategories:
            return "dish-categories"
            
        }
    }
}
