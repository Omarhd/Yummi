//
//  ServerConfig.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 16/09/2022.
//

import Foundation

enum BaseURl: String {
    
    case RELEASE = "release"
    case DEBUG = "debug"
    case STAGING = "staging"
    case QA = "qa"
}

class ServerConfig {
    
    static let shared = ServerConfig()
    
    var baseURL: String?
    
    func setupBaseUrls() {
        #if RELEASE
        self.baseURL = BaseURl.RELEASE.rawValue
        #elseif DEBUG
        self.baseURL = BaseURl.DEBUG.rawValue
        #elseif STAGING
        self.baseURL = BaseURl.STAGING.rawValue
        #elseif QA
        self.baseURL = BaseURl.QA.rawValue
        #endif
    }
}
