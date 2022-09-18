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
        return BuildSettingsKey.RELEASE.value
#elseif DEBUG
        return BuildSettingsKey.DEBUG.value
#elseif STAGING
        return BuildSettingsKey.STAGING.value
#elseif QA
        return BuildSettingsKey.QA.value
#else
        return BuildSettingsKey.RELEASE.value
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
