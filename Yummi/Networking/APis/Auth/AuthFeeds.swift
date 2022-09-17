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
        return BaseURl.RELEASE.value
#elseif DEBUG
        return BaseURl.DEBUG.value
#elseif STAGING
        return BaseURl.STAGING.value
#elseif QA
        return BaseURl.QA.value
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
