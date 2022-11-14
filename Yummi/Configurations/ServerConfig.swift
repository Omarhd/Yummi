//
//  ServerConfig.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 16/09/2022.
//

import Foundation

enum BuildSettingsKey: String {
    
    case BASE_URL
    
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
        self.baseURL = BuildSettingsKey.BASE_URL.value
#elseif DEBUG
        self.baseURL = BuildSettingsKey.BASE_URL.value
#elseif STAGING
        self.baseURL = BuildSettingsKey.BASE_URL.value
#elseif QA
        self.baseURL = BuildSettingsKey.BASE_URL.value
#else
        self.baseURL = BuildSettingsKey.BASE_URL.value
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
