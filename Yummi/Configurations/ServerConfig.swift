//
//  ServerConfig.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 16/09/2022.
//

import Foundation

enum BuildSettingsKey: String {
    
    case RELEASE
    case DEBUG
    case STAGING
    case QA
    
    case scheme
    
    var value: String {
        get {
            return ""
        }
    }
}

class ServerConfig {
    
    static let shared = ServerConfig()
    
    var baseURL: String?
    
    func setupBaseUrls() {
#if RELEASE
        self.baseURL = BuildSettingsKey.RELEASE.value
#elseif DEBUG
        self.baseURL = BuildSettingsKey.DEBUG.value
#elseif STAGING
        self.baseURL = BuildSettingsKey.STAGING.value
#elseif QA
        self.baseURL = BuildSettingsKey.QA.value
#else
        self.baseURL = BuildSettingsKey.RELEASE.value
#endif
        
    }
    
    func setupGoogleInfo() -> String {
       
        var filePath: String!
        
#if RELEASE
        filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist", inDirectory: "Google-Info/Release")
#elseif DEBUG
        filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist", inDirectory: "Google-Info/Debug")
#elseif STAGING
        filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist", inDirectory: "Google-Info/Staging")
#elseif QA
        filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist", inDirectory: "Google-Info/AQ")
#else
        filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist", inDirectory: "Google-Info/Release")
#endif
  
        return "filePath"
    }
}
