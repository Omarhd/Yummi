//
//  AuthFeeds.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import Foundation

enum AuthenticationFeed {
    case auth
}

extension AuthenticationFeed: Endpoint {
    var base: String {
#if RELEASE
        return BuildSettingsKey.AUTH_URL.value
#elseif DEBUG
        return BuildSettingsKey.AUTH_URL.value
#elseif STAGING
        return BuildSettingsKey.AUTH_URL.value
#elseif LOCAL
        return BuildSettingsKey.AUTH_URL.value
#else
        return BuildSettingsKey.AUTH_URL.value
#endif
    }
    
    var path: String {
        switch self {
        case .auth:
            return "users/add"
        }
    }
}
