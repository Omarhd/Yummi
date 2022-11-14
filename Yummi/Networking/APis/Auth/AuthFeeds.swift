//
//  AuthFeeds.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import Foundation

enum AuthenticationFeed {
    case loginOTP
    case mobileLogin
}

extension AuthenticationFeed: Endpoint {
    var base: String {
#if RELEASE
        return BuildSettingsKey.BASE_URL.value
#elseif DEBUG
        return BuildSettingsKey.BASE_URL.value
#elseif STAGING
        return BuildSettingsKey.BASE_URL.value
#elseif QA
        return BuildSettingsKey.BASE_URL.value
#else
        return BuildSettingsKey.BASE_URL.value
#endif
    }
    
    var path: String {
        switch self {
        case .loginOTP:
            return "/v1/auth/otp"
        case .mobileLogin:
            return "/v1/auth/mobile_login"
        }
    }
}
