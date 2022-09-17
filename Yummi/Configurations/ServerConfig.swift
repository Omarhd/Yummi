//
//  ServerConfig.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 16/09/2022.
//

import Foundation

enum BaseURl: String {
    
    case RELEASE
    case DEBUG
    case STAGING
    case QA
    
    var value: String {
        get {
            return Bundle.main.infoDictionary![self.rawValue] as! String
        }
    }
}

class ServerConfig {
    
    static let shared = ServerConfig()
    
    var baseURL: String?
    
    func setupBaseUrls() {
#if RELEASE
        self.baseURL = BaseURl.RELEASE.value
#elseif DEBUG
        self.baseURL = BaseURl.DEBUG.value
#elseif STAGING
        self.baseURL = BaseURl.STAGING.value
#elseif QA
        self.baseURL = BaseURl.QA.value
#endif
    }
}
